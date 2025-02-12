#!/bin/bash
set -e  # Exit on error

# Load environment variables
if [ -f "/home/ec2-user/app/env_vars" ]; then
    export $(grep -v '^#' /home/ec2-user/app/env_vars | xargs)
else
    echo "Error: env_vars file not found!"
    exit 1
fi

echo "Stopping and removing existing containers..."

# Stop containers using the container name (defined in CONTAINER_NAME env var)
echo "Stopping containers..."
docker ps -q --filter name="$CONTAINER_NAME" | xargs -r docker stop

# Remove stopped containers
echo "Removing stopped containers..."
docker ps -aq --filter name="$CONTAINER_NAME" | xargs -r docker rm

echo "Container cleanup completed."