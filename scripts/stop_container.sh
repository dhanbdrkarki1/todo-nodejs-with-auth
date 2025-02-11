#!/bin/bash

# Check if REPOSITORY_URI environment variable is set
if [ -z "$REPOSITORY_URI" ]; then
    echo "Error: REPOSITORY_URI environment variable is not set"
    exit 1
fi

# Stop and remove any existing containers
echo "Stopping and removing existing containers..."
echo "Repository URI: $REPOSITORY_URI"

# Stop containers
if docker ps -q --filter ancestor=$REPOSITORY_URI &>/dev/null; then
    echo "Stopping containers..."
    docker stop $(docker ps -q --filter ancestor=$REPOSITORY_URI)
    echo "Containers stopped successfully"
else
    echo "No running containers found for $REPOSITORY_URI"
fi

# Remove containers
if docker ps -a -q --filter ancestor=$REPOSITORY_URI &>/dev/null; then
    echo "Removing containers..."
    docker rm $(docker ps -a -q --filter ancestor=$REPOSITORY_URI)
    echo "Containers removed successfully"
else
    echo "No containers to remove for $REPOSITORY_URI"
fi

echo "Container cleanup completed"
