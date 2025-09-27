
output "lb_name" {
    value = aws_lb.lab3-lb.name
    description = "Name of the load balancer"
}
output "lb_arn" {
  value = aws_lb.lab3-lb.arn
  description = "ARN of the load balancer"
}
output "lb_dns" {
  value = aws_lb.lab3-lb.dns_name
  description = "The DNS name of the load balancer"
}
output "target_group_arn" {
  value = aws_lb_target_group.lb-tg.arn
  description = "ARN of Target group"
}

output "target_group_name" {
  value = aws_lb_target_group.lb-tg.name
}

# #Output for Internal LB
# output "internal_lb_name" {
#     value = aws_lb.internal-load-balancer.name
#     description = "Name of the internal lb"
# }




# #Output for Internet External LB
# output "internet_lb_name" {
#   value = aws_lb.internet-load-balancer.name
#   description = "Name of internet lb"
# }