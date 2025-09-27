# --- Backend EC2 Instance ---
resource "aws_instance" "backend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = false
  key_name                    = var.key_name

  tags = {
    Name = var.instance_name
    Role = "backend"
  }

  # --- Bootstrap Apache with user_data ---
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Backend EC2 - $(hostname)</h1>" > /var/www/html/index.html
              EOF
              
}

# --- Register Backend EC2 with Load Balancer Target Group(s) ---
resource "aws_lb_target_group_attachment" "backend_tg_attachment" {
  count            = length(var.target_group_arns)
  target_group_arn = var.target_group_arns[count.index]
  target_id        = aws_instance.backend.id
  port             = var.target_port
}


