#!/bin/bash
set -e

# Install Apache
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Configure reverse proxy
cat <<EOF | sudo tee /etc/httpd/conf.d/proxy.conf
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so
ProxyRequests Off
<VirtualHost *:80>
    ProxyPass / http://${backend_target}:80/
    ProxyPassReverse / http://${backend_target}:80/
</VirtualHost>
EOF

# Restart Apache
sudo systemctl restart httpd
