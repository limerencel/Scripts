#!/bin/bash

# Check if filename is provided
if [ -z "$1" ]; then
    echo "Please provide a config file name."
    exit 1
fi

# Create or edit the config file
sudo nano /etc/nginx/sites-available/$1

# Create symbolic link
sudo ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/

# Test and reload nginx
sudo nginx -t && sudo systemctl reload nginx
