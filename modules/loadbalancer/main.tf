resource "aws_lb" "lab3-lb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "lb-tg" {
  name        = var.target_group_name
  port        = var.target_port
  protocol    = var.target_protocol
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path = "/"
    protocol = "HTTP"
    interval = 30
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.lab3-lb.arn
  port              = var.target_port
  protocol          = var.target_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}

# #The Internet facing and internal application load balancers
# resource "aws_lb" "internal-load-balancer" {
#   internal = true
#   ip_address_type = var.internal-lb-ip-type
#   load_balancer_type = var.internal-lb-type
#   name = var.internal-lb-name
#   security_groups = [ var.sg-internal-lb-id ]
#   subnets = var.internal-lb-subnets
# }

# resource "aws_lb_target_group" "internal-lb-target-group" {
#   name = var.internal-lb-tg-name
#   port = var.internal-lb-tg-port
#   protocol = var.internal-lb-tg-protocol
#   slow_start = var.internal-lb-tg-slow_start
#   target_type = var.internal-lb-tg-target-type
#   ip_address_type = var.internal-lb-ip-type #Same as the one specified in the load balancer block
#   vpc_id = var.vpc-id
# }
# resource "aws_lb_target_group_attachment" "internal-lb-targets" {
#   count = length(var.vpc_private_subnets)
#   target_group_arn = aws_lb_target_group.internal-lb-target-group.arn
#   target_id = var.vpc_private_subnets[count.index].id
#   availability_zone = var.az[count.index]
#   port = var.internal-lb-tg-port #Same as the target group specification
# }
# resource "aws_lb_listener" "internal-lb-listener" {
#   port = var.internal-lb-tg-port #Same as the tg port
#   protocol = var.internal-lb-tg-protocol #Same as the tg protocol
#   default_action {
#     type = var.internal-listener-action-type
#     target_group_arn = aws_lb_target_group.internal-lb-target-group.arn
#   }
#   load_balancer_arn = aws_lb.internal-load-balancer.arn
# }




# resource "aws_lb" "internet-load-balancer" {
#   internal = false
#   ip_address_type = var.internet-lb-ip-type
#   load_balancer_type = var.internet-lb-type
#   name = var.internet-lb-name
#   security_groups = [ var.sg-internet-lb-id ] 
#   subnets = var.internal-lb-subnets
# }
# resource "aws_lb_target_group" "internet-lb-target-group" {
#   name = var.internet-lb-tg-name
#   port = var.internet-lb-tg-port
#   protocol = var.internet-lb-tg-protocol
#   slow_start = var.internet-lb-tg-slow_start
#   target_type = var.internet-lb-tg-target-type
#   ip_address_type = var.internet-lb-ip-type #Same as the one specified in the load balancer block
#   vpc_id = var.vpc-id
# }
# resource "aws_lb_target_group_attachment" "internet-lb-targets" {
#   count = length(var.vpc_public_subnets)
#   target_group_arn = aws_lb_target_group.internet-lb-target-group.arn
#   target_id = var.vpc_public_subnets[count.index].id
#   availability_zone = var.az[count.index]
#   port = var.internet-lb-tg-port #Same as the target group specification
# }
# resource "aws_lb_listener" "internet-lb-listener" {
#   port = var.internet-lb-tg-port
#   protocol = var.internet-lb-tg-protocol
#   load_balancer_arn = aws_lb.internet-load-balancer.arn
#   default_action {
#     type = var.internet-listener-action-type
#     target_group_arn = aws_lb_target_group.internet-lb-target-group.arn
#   }
# }