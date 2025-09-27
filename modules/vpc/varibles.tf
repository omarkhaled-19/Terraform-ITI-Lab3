#VPC Specific variables
variable "vpc_cidr_block" {
  type = string
  description = "VPC cidr block"
}

variable "vpc_tags" {
  type = map(string)
  description = "VPC tags, for the VPC Name"
}

#Internet Gateway
variable "igw-tags" {
  type = map(string)
  description = "IGW Gateway Tag Name"
}

#Availability Zones
variable "availability_zones" {
  type = list(string)
  description = "List of us-east-1 availability zones to use"
}


#Private subnets ipv4 cidr blocks
variable "private_subnets" {
  type = list(string)
  description = "List of Private Subnet ipv4 cidr blocks"
}
variable "private_subnet_tags" {
  type = list(map(string))
  description = "Private Subnets Tags name"
}
#Public subnets ipv4 cidr blocks
variable "public_subnets" {
  type = list(string)
  description = "List of Public Subnet ipv4 cidr blocks"
}
variable "public_subnet_tags" {
  type = list(map(string))
  description = "public Subnets Tags name"
}


#Elastic IP vars
variable "eip_tags" {
  type = map(string)
  description = "Elastic IP tags for Name"
}
#NAT Gateway vars
variable "nat_tags" {
  type = map(string)
  description = "NAT Gateway tags for Name"
}

#Public Route Table
variable "public_rt_tags" {
  type = map(string)
  description = "Public rt tags for Name"
}
#Private Route Table
variable "private_rt_tags" {
  type = map(string)
  description = "Private rt tags for Name"
}