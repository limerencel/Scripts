#!/bin/bash

# This script creates an Nginx reverse proxy configuration file with real IP forwarding.

# Prompt user for input
read -p "Enter the domain name: " domain
read -p "Enter the proxy_pass (upstream server URL): " proxy_pass

# Define the configuration file path
config_file="/etc/nginx/sites-available/${domain}"

# Create the configuration file with reverse proxy setup and real IP forwarding
echo "Creating Nginx reverse proxy configuration for $domain..."

cat > $config_file <<EOF
server {
    listen 80;
    server_name $domain;

    location / {
    # Directs requests to the specified backend server
    proxy_pass $proxy_pass;

    # Sets the HTTP protocol version used for proxy communication
    proxy_http_version 1.1;

    # For WebSocket: Upgrades the connection to a WebSocket connection
    proxy_set_header Upgrade \$http_upgrade;

    # For WebSocket: Maintains the upgrade of the connection to a WebSocket
    proxy_set_header Connection 'upgrade';

    # Passes the original Host header to the backend server
    proxy_set_header Host \$host;

    # Forwards the client's real IP address to the backend server
    proxy_set_header X-Real-IP \$remote_addr;

    # Appends the client's IP address in a forwarded-for format
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;

    # Forwards the original scheme (http or https) used by the client
    proxy_set_header X-Forwarded-Proto \$scheme;

    # Bypasses cache if the request is an upgrade to a WebSocket
    proxy_cache_bypass \$http_upgrade;
}

}
EOF

# check if the create_sites.sh exist in the current directory

filename="create_sites.sh"
if [ -f "$filename" ]; then 
  read -p "Modify this config file now? (yes/no) " choice
  case $choice in
    yes|y)
      . ./"$filename"
      ;;
    no|n)
      echo "Exiting script."
      exit 0
      ;;
    *)
      echo "Please type yes or no."
      ;;
  esac
else
  read -p "Do you need to download it now and run it? (yes/no) " download
  case $download in
    yes|y)
      curl -o "$filename" https://raw.githubusercontent.com/limerencel/Scripts/main/create_sites.sh && chmod +x "$filename" && . ./"$filename"
      ;;
    no|n)
      echo "Exiting script."
      exit 0
      ;;
    *)
      echo "Please type yes or no."
      ;;
  esac
fi



echo "Configuration file created at $config_file"
