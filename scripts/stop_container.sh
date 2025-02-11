#!/bin/bash
set -e  # Exit on error

# Load environment variables
if [ -f "/home/ec2-user/app/env_vars" ]; then
    export $(grep -v '^#' /home/ec2-user/app/env_vars | xargs)
else
    echo "Error: env_vars file not found!"
    exit 1
fi

# Check if REPOSITORY_URI is set
if [ -z "$REPOSITORY_URI" ]; then
    echo "Error: REPOSITORY_URI environment variable is not set!"
    exit 1
fi

echo "Stopping and removing existing containers..."
echo "Repository URI: $REPOSITORY_URI"

# Stop running containers
if docker ps -q --filter ancestor=$REPOSITORY_URI &>/dev/null; then
    echo "Stopping containers..."
    docker stop $(docker ps -q --filter ancestor=$REPOSITORY_URI)
    echo "Containers stopped successfully"
else
    echo "No running containers found for $REPOSITORY_URI"
fi

# Remove stopped containers
if docker ps -a -q --filter ancestor=$REPOSITORY_URI &>/dev/null; then
    echo "Removing containers..."
    docker rm $(docker ps -a -q --filter ancestor=$REPOSITORY_URI)
    echo "Containers removed successfully"
else
    echo "No containers to remove for $REPOSITORY_URI"
fi

echo "Container cleanup completed."