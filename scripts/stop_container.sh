#!/bin/bash
set -e  # Exit on error

# Load environment variables
if [ -f /home/ec2-user/app/env_vars ]; then
    source /home/ec2-user/app/env_vars
else
    echo "Error: env_vars file not found!"
    exit 1
fi

# Ensure REPOSITORY_URI is set
if [ -z "$REPOSITORY_URI" ]; then
    echo "Error: REPOSITORY_URI is not set!"
    exit 1
fi

echo "Repository URI: $REPOSITORY_URI"

# Stop and remove any running containers
echo "Stopping and removing existing containers..."
if docker ps -q --filter "ancestor=$REPOSITORY_URI:$IMAGE_TAG" &>/dev/null; then
    echo "Stopping containers..."
    docker stop $(docker ps -q --filter "ancestor=$REPOSITORY_URI:$IMAGE_TAG") || true
    echo "Containers stopped successfully"
else
    echo "No running containers found for $REPOSITORY_URI:$IMAGE_TAG"
fi

if docker ps -a -q --filter "ancestor=$REPOSITORY_URI:$IMAGE_TAG" &>/dev/null; then
    echo "Removing containers..."
    docker rm $(docker ps -a -q --filter "ancestor=$REPOSITORY_URI:$IMAGE_TAG") || true
    echo "Containers removed successfully"
else
    echo "No containers to remove for $REPOSITORY_URI:$IMAGE_TAG"
fi

echo "Container cleanup completed."