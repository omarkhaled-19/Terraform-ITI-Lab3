variable "key_name" {
  type = string
  description = "SSH Key pair name"
}

#VPC Module Root Variables
variable "vpc_cidr_block" {
  type = string
  description = "VPC cidr block"
  default = "10.0.0.0/16"
}
variable "vpc_tags" {
  type = map(string)
  description = "Tags for VPC"
}
variable "igw_tags" {
  type = map(string)
  description = "Tags for Internet Gateway"
}
variable "availability_zones" {
  type = list(string)
  description = "List of Availability Zones to use"
}

variable "private_subnets" {
  type = list(string)
  description = "List of private subnets cidr blocks"
}
variable "private_subnet_tags" {
  type = list(map(string))
  description = "List of Tags for each private subnet"
}
variable "private_rt_tags" {
  type = map(string)
  description = "Tags for Private Route Table"
}

variable "public_subnets" {
  type = list(string)
  description = "List of public subnets cidr blocks"
}
variable "public_subnet_tags" {
  type = list(map(string))
  description = "List of Tags for each public subnet"
}
variable "public_rt_tags" {
  type = map(string)
  description = "Tags for Public Route Table"
}

variable "eip_tags" {
  type = map(string)
  description = "Tags for Elastic IP"
}
variable "nat_tags" {
  type = map(string)
  description = "Tags for NAT Gateway"
}

#======================================
#Security Groups Root Variables

variable "sg_public_lb_name" {
  type = string
  description = "Public Load Balancer SG Name"
}
variable "sg_proxy_name" {
  type = string
  description = "Proxy servers SG Name"
}
variable "sg_internal_lb_name" {
  type = string
  description = "Internal Load Balancer SG Name"
}
variable "sg_webserver_name" {
  type = string
  description = "Backend servers SG Name"
}

#Load Balancer Module: Public 
variable "public_lb_name" {
  type = string
  description = "Name of the public load balancer"
}
variable "proxy_group_name" {
  type = string
  description = "Name of the Proxy Servers Target Group"
}
variable "proxy_port" {
  type = number
  description = "Port the Proxy targets will listen on"
}
variable "proxy_protocol" {
  type = string
  description = "Protocol the Proxy targets use: HTTP,SSH,etc.."
}
#Load Balancer Module: Internal
variable "internal_lb_name" {
  type = string
  description = "Name of the internal load balancer"
}
variable "backends_group_name" {
  type = string
  description = "Name of the Backend Servers Target Group"
}
variable "backends_port" {
  type = number
  description = "Port the Backend targets will listen on"
}
variable "backends_protocol" {
  type = string
  description = "Protocol the Backend targets use: HTTP,SSH,etc.."
}


#EC2-Proxy Variables
variable "instance_type" {
  type = string
  description = "Type of machine: t3.micro, etc.."
}
variable "proxy-1-name" {
  type = string
  description = "Proxy 1 Server Name"
}

variable "proxy-2-name" {
  type = string
  description = "Proxy 2 Server Name"
}

#EC2-Backend Variables
variable "backend-1-name" {
  type = string
  description = "Backend 1 Server Name"
}
variable "backend-2-name" {
  type = string
  description = "Backend 2 Server Name"
}
