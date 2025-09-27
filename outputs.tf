output "public_lb_dns" {
  value       = module.public_lb.lb_dns
  description = "DNS name of the public ALB (entry point)"
}

output "internal_lb_dns" {
  value       = module.internal_lb.lb_dns
  description = "DNS name of the internal ALB"
}

output "proxy_public_ips" {
  value = [
    module.proxy-1.proxy_public_ip,
    module.proxy-2.proxy_public_ip
  ]
  description = "Public IPs of proxy servers"
}

output "proxy_private_ips" {
  value = [
    module.proxy-1.proxy_private_ip,
    module.proxy-2.proxy_private_ip
  ]
  description = "Private IPs of proxy servers"
}

output "backend_private_ips" {
  value = [
    module.backend-1.backend_private_ip,
    module.backend-2.backend_private_ip
  ]
  description = "Private IPs of backend EC2s"
}
