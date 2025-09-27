#Security Groups and their rules

#--------------Public ALB Security Group----------------
resource "aws_security_group" "sg-public-lb" {
  name = var.sg-public-lb-name
  vpc_id = var.selected-vpc-id
}

resource "aws_vpc_security_group_ingress_rule" "public-lb-ingress" {
  security_group_id = aws_security_group.sg-public-lb.id
  cidr_ipv4 = "0.0.0.0/0"
  description = "Allows HTTP requests from the internet"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
}
resource "aws_vpc_security_group_egress_rule" "public-lb-egress" {
  security_group_id = aws_security_group.sg-public-lb.id
  cidr_ipv4 = "0.0.0.0/0"
  description = "Allow outbound traffic to the internet"
  ip_protocol = "-1"
}

#-------------Proxy EC2 Security Group--------------
resource "aws_security_group" "sg-proxy" {
  name = var.sg-proxy-name
  vpc_id = var.selected-vpc-id
}
resource "aws_vpc_security_group_ingress_rule" "proxy-ingress" {
  security_group_id = aws_security_group.sg-proxy.id
  referenced_security_group_id = aws_security_group.sg-public-lb.id
  description = "Allow inbound traffic from the public Load Balancer"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
}
#To allow remote-exec ssh connection provisioning
resource "aws_vpc_security_group_ingress_rule" "proxy-ssh" {
  security_group_id = aws_security_group.sg-proxy.id
  cidr_ipv4         = "0.0.0.0/0" # just for the lab, otherwise use a bastion host and its ip
  description       = "Allow SSH from Terraform to provision using remote-exec"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "proxy-egress" {
  security_group_id = aws_security_group.sg-proxy.id
  cidr_ipv4 = "0.0.0.0/0"
  description = "Allow outbound HTTP traffic to anywhere"
  ip_protocol = "-1" 
}

#---------------EC2 Webservers-----------------
resource "aws_security_group" "sg-webserves" {
  name = var.sg-webserver-name
  vpc_id = var.selected-vpc-id
}
resource "aws_vpc_security_group_ingress_rule" "webservers-ingress" {
  security_group_id = aws_security_group.sg-webserves.id
  referenced_security_group_id = aws_security_group.sg-internal-lb.id
  description = "Allow HTTP traffic from internal load balancer"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
}
resource "aws_vpc_security_group_ingress_rule" "webservers-ssh" {
  security_group_id = aws_security_group.sg-webserves.id
  cidr_ipv4 =  "0.0.0.0/0"
  description = "Allow SSH traffic from just for lab troubleshooting"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "webservers-egress" {
  security_group_id = aws_security_group.sg-webserves.id
  cidr_ipv4 = "0.0.0.0/0"
  description = "Allow outbound traffic (through NAT gw defined in the route table)"
  ip_protocol = "-1"
}


#-----------Internal Load Balancer Security Group------------
resource "aws_security_group" "sg-internal-lb" {
  name = var.sg-internal-lb-name
  vpc_id = var.selected-vpc-id
}
resource "aws_vpc_security_group_ingress_rule" "internal-lb-ingress" {
  security_group_id = aws_security_group.sg-internal-lb.id
  referenced_security_group_id = aws_security_group.sg-proxy.id
  description = "Allow inbound traffic from proxy servers"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
}
resource "aws_vpc_security_group_egress_rule" "internal-lb-egress" {
  security_group_id = aws_security_group.sg-internal-lb.id
  referenced_security_group_id = aws_security_group.sg-webserves.id
  description = "Allow outbound HTTP traffic to the Backends"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
}


