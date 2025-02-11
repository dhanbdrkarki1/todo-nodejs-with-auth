#!/bin/bash

# Ensure PM2 is installed
if ! command -v pm2 &> /dev/null; then
    echo "PM2 is not installed. Installing..."
    npm install -g pm2
fi

# Check if 'app2' is already managed by PM2
if pm2 describe app2 &> /dev/null; then
    echo "App 'app2' is already running. Restarting..."
    pm2 restart app2
else
    echo "Starting 'app2'..."
    pm2 start /var/www/app2/app.js --name app2
    pm2 save
fi

# Ensure PM2 is set up to restart on reboot (only needed once)
if [ ! -f ~/.pm2/dump.pm2 ]; then
    pm2 startup systemd
    pm2 save
fi

echo "PM2 process for 'app2' is now running."