variable "sg-public-lb-name" {
    type = string
    description = "Name of the public load balancer security group"
}
variable "sg-proxy-name" {
  type = string
  description = "Name of Proxy EC2 security group"
}
variable "sg-webserver-name" {
  type = string
  description = "Name of the private instances' security group"
}
variable "selected-vpc-id" {
  type = string
  description = "The Vpc id for the security group"
}

variable "sg-internal-lb-name" {
  type = string
  description = "Name of Internal LB security Group"
}