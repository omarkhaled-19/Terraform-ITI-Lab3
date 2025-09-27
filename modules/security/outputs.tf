output "public_alb_sg_id" {
  description = "Security Group ID for the Public Load Balancer"
  value       = aws_security_group.sg-public-lb.id
}

output "proxy_ec2_sg_id" {
  description = "Security Group ID for the Proxy EC2"
  value       = aws_security_group.sg-proxy.id
}


output "internal_alb_sg_id" {
  description = "Security Group ID for the Internal Load Balancer"
  value       = aws_security_group.sg-internal-lb.id
}

output "backend_ec2_sg_id" {
  description = "Security Group ID for the Backend Webservers"
  value       = aws_security_group.sg-webserves.id
}
