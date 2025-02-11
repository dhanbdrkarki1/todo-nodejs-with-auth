#!/bin/bash
# Stop and remove any existing containers
echo "Stopping and removing existing containers..."
docker stop $(docker ps -q --filter ancestor=$REPOSITORY_URI:latest) || true
docker rm $(docker ps -a -q --filter ancestor=$REPOSITORY_URI:latest) || true
echo "Containers stopped and removed."