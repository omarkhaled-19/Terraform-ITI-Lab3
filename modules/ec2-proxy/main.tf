# # --- Generate SSH Key Pair ---
# resource "tls_private_key" "proxy_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "proxy_key" {
#   key_name   = var.key_name
#   public_key = tls_private_key.proxy_key.public_key_openssh
# }

# # Save private key locally (for SSH into proxy EC2)
# resource "local_file" "proxy_private_key" {
#   content  = tls_private_key.proxy_key.private_key_pem
#   filename = "${path.module}/${var.key_name}.pem"
# }

# --- Proxy EC2 Instance ---
resource "aws_instance" "proxy" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = var.instance_name
    Role = "proxy"
  }

  # --- SSH connection for remote-exec ---
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = var.private_key_pem
    host        = self.public_ip
  }

  

  #--- Provision Apache Reverse Proxy ---
  provisioner "remote-exec" {
    inline = [
    "sudo yum update -y",
    "sudo yum install -y httpd",
    "sudo systemctl start httpd",
    "sudo systemctl enable httpd",
    "sudo bash -c 'cat > /etc/httpd/conf.d/proxy.conf <<EOF\nLoadModule proxy_module modules/mod_proxy.so\nLoadModule proxy_http_module modules/mod_proxy_http.so\nProxyRequests Off\n<VirtualHost *:80>\n    ProxyPass / http://${var.backend_target}:80/\n    ProxyPassReverse / http://${var.backend_target}:80/\n</VirtualHost>\nEOF'",
    "sudo systemctl restart httpd"
  ]
  }
}


# --- Register Proxy EC2 with Load Balancer Target Group(s) ---
resource "aws_lb_target_group_attachment" "proxy_tg_attachment" {
  count            = length(var.target_group_arns)
  target_group_arn = var.target_group_arns[count.index]
  target_id        = aws_instance.proxy.id
  port             = var.target_port
}
