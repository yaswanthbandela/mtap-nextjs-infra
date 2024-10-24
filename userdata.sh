#!/bin/bash
# Update and install necessary packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Nginx
sudo apt-get install -y nginx

# Configure Nginx
sudo rm /etc/nginx/sites-enabled/default

cat <<EOT > /etc/nginx/sites-available/nextjs
server {
    listen 80;

    server_name test.byklabs.store;  # Replace with your domain or public IP 

    location / {
        proxy_pass http://localhost:3000;  # Forward requests to Next.js
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOT

sudo ln -s /etc/nginx/sites-available/nextjs /etc/nginx/sites-enabled/nextjs

# Restart Nginx to apply the changes
sudo systemctl restart nginx
sudo systemctl enable nginx

# Install CodeDeploy Agent
sudo apt-get update
sudo apt-get install -y ruby wget
cd /home/ubuntu
wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

# Start the CodeDeploy agent
sudo service codedeploy-agent start

# Check if CodeDeploy agent is running
sudo service codedeploy-agent status
