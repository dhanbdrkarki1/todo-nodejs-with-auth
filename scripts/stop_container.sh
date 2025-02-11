#!/bin/bash
# Stop and remove any existing containers
echo "Stopping and removing existing containers..."
echo "$REPOSITORY_URI"
docker stop $(docker ps -q --filter ancestor=$REPOSITORY_URI) || true
docker rm $(docker ps -a -q --filter ancestor=$REPOSITORY_URI) || true
echo "Containers stopped and removed."