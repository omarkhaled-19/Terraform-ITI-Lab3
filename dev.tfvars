#Key Name
key_name = "lab3-key"

#VPC input variables
vpc_cidr_block = "10.0.0.0/16"
vpc_tags = {
  "Name" = "Lab3-VPC"
}
igw_tags = {
  "Name" = "Lab3-IGW"
}

availability_zones = [ "us-east-1a", "us-east-1b" ]
private_subnets = [ "10.0.1.0/24", "10.0.3.0/24" ]
private_subnet_tags = [ {
  "Name" = "PVT_Subnet_1"
}, {
    "Name" = "PVT_Subent_2"
} ]
private_rt_tags = {
  "Name" = "pvt-route-table"
}

public_subnets = [ "10.0.0.0/24", "10.0.2.0/24" ]
public_subnet_tags = [ {
  "Name" = "PUB_Subnet_1"
}, {
    "Name" = "PUB_Subent_2"
} ]
public_rt_tags = {
  "Name" = "pub-route-table"
}

eip_tags = {
  "Name" = "Elastic IP for the NAT Gateway"
}
nat_tags = {
  "Name" = "Lab3-NGW"
}

#Security Groups Input Variables
sg_public_lb_name = "Lab3-SG-Public-LB"
sg_proxy_name = "Lab3-SG-Proxy"
sg_internal_lb_name = "Lab3-SG-Internal-LB"
sg_webserver_name = "Lab3-SG-Backend"

#Load Balncer Input Variables
#Load Balancer module: Public
public_lb_name = "Lab3-Public-LB"
proxy_group_name = "Lab3-Proxy-Group"
proxy_port = 80
proxy_protocol = "HTTP"
#Load Balancer module: Internal
internal_lb_name = "Lab3-Internal-LB"
backends_group_name = "Lab3-Backends-Group"
backends_port = 80
backends_protocol = "HTTP"

#EC2 Proxy Input Variables
instance_type = "t3.micro"
proxy-1-name = "lab3-proxy-1"
proxy-2-name = "lab3-proxy-2"

#EC2 Backend Input Variables
backend-1-name = "lab3-backend-1"
backend-2-name = "lab3-backend-2"

