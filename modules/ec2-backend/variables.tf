variable "ami_id" {
  type        = string
  description = "AMI ID for backend EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type (e.g., t2.micro)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the backend EC2 will launch"
}

variable "sg_id" {
  type        = string
  description = "Security group ID for the backend EC2"
}

variable "key_name" {
  type        = string
  description = "Key pair name (used if you want to SSH for debugging)"
}

variable "instance_name" {
  type        = string
  description = "Tag name for backend EC2"
}

variable "target_group_arns" {
  type        = list(string)
  description = "List of target group ARNs to attach this backend EC2 to"
  default     = []
}

variable "target_port" {
  type        = number
  description = "Port for the target group attachment"
  default     = 80
}
