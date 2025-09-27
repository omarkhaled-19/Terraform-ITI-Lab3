provider "aws" {
  region = "us-east-1"
}
# -------------------
# KEY PAIR (for both EC2s)
# -------------------
resource "tls_private_key" "lab_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "lab_key" {
  key_name   = var.key_name
  public_key = tls_private_key.lab_key.public_key_openssh
}

resource "local_file" "lab_private_key" {
  content  = tls_private_key.lab_key.private_key_pem
  filename = "${path.module}/${var.key_name}.pem"
}


#------------------------------
#Amazon Linux Image Data Source
#------------------------------
data "aws_ami" "amazon_linux2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#----------------
# VPC Module
#----------------
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  vpc_tags = var.vpc_tags
  igw-tags = var.igw_tags
  availability_zones = var.availability_zones

  private_subnets = var.private_subnets
  private_subnet_tags = var.private_subnet_tags
  private_rt_tags = var.private_rt_tags

  public_subnets = var.public_subnets
  public_subnet_tags = var.public_subnet_tags
  public_rt_tags = var.public_rt_tags

  eip_tags = var.eip_tags
  nat_tags = var.nat_tags
}

#-----------------------
# Security Groups Module
#-----------------------
module "security" {
  source = "./modules/security"

  sg-public-lb-name = var.sg_public_lb_name
  sg-proxy-name = var.sg_proxy_name
  sg-internal-lb-name = var.sg_internal_lb_name
  sg-webserver-name = var.sg_webserver_name

  selected-vpc-id = module.vpc.lab3_vpc_id
}

#-----------------------
#  Load Balancers Module
#-----------------------
#A call for creating public load balancer
module "public_lb" {
  source = "./modules/loadbalancer"

  name = var.public_lb_name
  internal = false
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id = module.vpc.lab3_vpc_id
  security_group_ids = [module.security.public_alb_sg_id]

  target_group_name = var.proxy_group_name
  target_port = var.proxy_port
  target_protocol = var.proxy_protocol
}

#A call for creating internal load balancer
module "internal_lb" {
  source = "./modules/loadbalancer"

  name = var.internal_lb_name
  internal = true
  subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.lab3_vpc_id
  security_group_ids = [module.security.internal_alb_sg_id]

  target_group_name = var.backends_group_name
  target_port = var.backends_port
  target_protocol = var.backends_protocol
}


#--------------------------------------
# EC2 Instances: 2x Proxy  + 2x Backend
#--------------------------------------

#----------Proxy Instances-------------
module "proxy-1" {
  source = "./modules/ec2-proxy"

  ami_id = data.aws_ami.amazon_linux2023.id
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnet_ids[0]
  sg_id = module.security.proxy_ec2_sg_id
  key_name = aws_key_pair.lab_key.key_name
  private_key_pem = tls_private_key.lab_key.private_key_pem
  instance_name = var.proxy-1-name

  backend_target = module.internal_lb.lb_dns
  target_group_arns = [module.public_lb.target_group_arn]
}

module "proxy-2" {
  source = "./modules/ec2-proxy"

  ami_id = data.aws_ami.amazon_linux2023.id
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnet_ids[1]
  sg_id = module.security.proxy_ec2_sg_id
  key_name = aws_key_pair.lab_key.key_name
  private_key_pem = tls_private_key.lab_key.private_key_pem
  instance_name = var.proxy-2-name

  backend_target = module.internal_lb.lb_dns
  target_group_arns = [module.public_lb.target_group_arn]
}

#--------------Backend EC2 instances-------------
module "backend-1" {
  source = "./modules/ec2-backend"

  ami_id = data.aws_ami.amazon_linux2023.id
  instance_type = var.instance_type
  subnet_id = module.vpc.private_subnet_ids[0]
  sg_id = module.security.backend_ec2_sg_id
  key_name = aws_key_pair.lab_key.key_name
  instance_name = var.backend-1-name 

  target_group_arns = [module.internal_lb.target_group_arn]
  target_port = 80
}
module "backend-2" {
  source = "./modules/ec2-backend"

  ami_id = data.aws_ami.amazon_linux2023.id
  instance_type = var.instance_type
  subnet_id = module.vpc.private_subnet_ids[1]
  sg_id = module.security.backend_ec2_sg_id
  key_name = aws_key_pair.lab_key.key_name
  instance_name = var.backend-2-name 

  target_group_arns = [module.internal_lb.target_group_arn]
  target_port = 80
}


#Local-Exec to print all ips.
#Using null-resource ensure new file is created each time a resource is destroyed
# -------------------
# Collect all IPs into all-ips.txt (ordered)
# -------------------
resource "null_resource" "write_ips" {
  provisioner "local-exec" {
    command = <<EOT
      echo "proxy1  ${module.proxy-1.proxy_public_ip}" > all-ips.txt
      echo "proxy2  ${module.proxy-2.proxy_public_ip}" >> all-ips.txt
      echo "backend1  ${module.backend-1.backend_private_ip}" >> all-ips.txt
      echo "backend2  ${module.backend-2.backend_private_ip}" >> all-ips.txt
    EOT
  }

  triggers = {
    proxy1   = module.proxy-1.proxy_public_ip
    proxy2   = module.proxy-2.proxy_public_ip
    backend1 = module.backend-1.backend_private_ip
    backend2 = module.backend-2.backend_private_ip
  }
}
