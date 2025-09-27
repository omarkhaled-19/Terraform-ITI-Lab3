output "proxy_instance_id" {
  description = "ID of the proxy EC2 instance"
  value       = aws_instance.proxy.id
}

output "proxy_private_ip" {
  description = "Private IP of the proxy EC2 instance"
  value       = aws_instance.proxy.private_ip
}

output "proxy_public_ip" {
  description = "Public IP of the proxy EC2 instance"
  value       = aws_instance.proxy.public_ip
}


output "proxy_tg_attachment_ids" {
  description = "IDs of the proxy EC2 target group attachments"
  value       = [for a in aws_lb_target_group_attachment.proxy_tg_attachment : a.id]
}
