output "backend_instance_id" {
  value       = aws_instance.backend.id
  description = "ID of the backend EC2 instance"
}

output "backend_private_ip" {
  value       = aws_instance.backend.private_ip
  description = "Private IP of the backend EC2 instance"
}

output "backend_tg_attachment_ids" {
  description = "IDs of the backend EC2 target group attachments"
  value       = [for a in aws_lb_target_group_attachment.backend_tg_attachment : a.id]
}
