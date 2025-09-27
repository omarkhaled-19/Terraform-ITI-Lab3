variable "ami_id" {
  type        = string
  description = "AMI ID for the proxy EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the proxy EC2 (e.g., t2.micro)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the proxy EC2 will launch"
}

variable "sg_id" {
  type        = string
  description = "Security group ID for the proxy EC2"
}


variable "key_name" {
  type        = string
  description = "Key pair name to use for the proxy EC2"
}

variable "private_key_pem" {
  type        = string
  description = "Private key PEM content for SSH provisioning"
  sensitive   = true
}

variable "instance_name" {
  type        = string
  description = "Tag name for the proxy EC2 instance"
}

variable "backend_target" {
  type        = string
  description = "Target backend (internal ALB DNS or backend private IP)"
}

variable "target_group_arns" {
  type        = list(string)
  description = "List of target group ARNs to attach this proxy EC2 to"
  default     = []
}

variable "target_port" {
  type        = number
  description = "Port to use when attaching to the target group"
  default     = 80
}
