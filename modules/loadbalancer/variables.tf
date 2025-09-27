variable "name" {
  type        = string
  description = "Name of the load balancer"
}

variable "internal" {
  type        = bool
  description = "true = internal, false = internet-facing"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets where the LB will live"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups for the LB"
}

variable "target_group_name" {
  type        = string
  description = "Name of the target group"
}

variable "target_port" {
  type        = number
  description = "Port the targets will listen on"
}

variable "target_protocol" {
  type        = string
  description = "Protocol for the target group (http, https)"
}


# #Internal Load Balancer Variables
# variable "internal-lb-name" {
#   type = string
#   description = "Name of internal load balancer"
# }
# variable "internal-lb-type" {
#   type = string
#   description = "Type of internal load balancer: application or network or gateway"
# }
# variable "internal-lb-ip-type" {
#   type = string
#   description = "IP address type of internal load balancer: 1) 'ipv4' 2) 'dualstack' 3) 'dualstack-without-public-ipv4'  "
# }
# variable "sg-internal-lb-id" {
#   type = string
#   description = "ID of the internal lb security group"
# }
# variable "internal-lb-subnets" {
#   type = list(string)
#   description = "list of private subnet ids that the internal load balancer will route traffic to"
# }

# #Internal Load Balancer Target Group variables
# variable "internal-lb-tg-name" {
#   type = string
#   description = "name of internal target group"
# }
# variable "internal-lb-tg-port" {
#   type = number
#   description = "Port of the targets"
# }
# variable "internal-lb-tg-protocol" {
#   type = string
#   description = "protocol used to communicate with targets: http,tcp,udp,etc.."
# }
# variable "internal-lb-tg-slow_start" {
#   type = number
#   description = "Amount of time in seconds until instances warm up. preferrably 30 sec"
# }
# variable "internal-lb-tg-target-type" {
#   type = string
#   description = "type of targets: instances,ip,lambda"
# }
# variable "internal-listener-action-type" {
#   type = string
#   description = "The Action type of listener rule: 'forward': for directing to a target group"
# }




# #Internet Load Balancer variables
# variable "internet-lb-name" {
#   type = string
#   description = "Name of internet load balancer"
# }
# variable "internet-lb-type" {
#   type = string
#   description = "Type of internet load balancer: application or network or gateway"
# }
# variable "internet-lb-ip-type" {
#   type = string
#   description = "IP address type of internet load balancer: 1) 'ipv4' 2) 'dualstack' 3) 'dualstack-without-public-ipv4'  "
# }
# variable "sg-internet-lb-id" {
#   type = string
#   description = "ID of the internet lb security group"
# }
# variable "internet-lb-subnets" {
#   type = list(string)
#   description = "list of public subnet ids that the internet external load balancer will route traffic to"
# }
# #Internet LB target group variables
# variable "internet-lb-tg-name" {
#   type = string
#   description = "name of internet target group"
# }
# variable "internet-lb-tg-port" {
#   type = number
#   description = "Port of the targets"
# }
# variable "internet-lb-tg-protocol" {
#   type = string
#   description = "protocol used to communicate with targets: http,tcp,udp,etc.."
# }
# variable "internet-lb-tg-slow_start" {
#   type = number
#   description = "Amount of time in seconds until instances warm up. preferrably 30 sec"
# }
# variable "internet-lb-tg-target-type" {
#   type = string
#   description = "type of targets: instances,ip,lambda"
# }
# variable "internet-listener-action-type" {
#   type = string
#   description = "The Action type of internet lb listener rule: 'forward': for directing to a target group"
# }