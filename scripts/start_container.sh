#!/bin/bash
# Pull the latest Docker image
echo "Pulling the latest Docker image..."
docker pull $REPOSITORY_URI:latest

# Run the Docker container
echo "Starting the Docker container..."
docker run -d -p 80:3000 --name todo-app $REPOSITORY_URI:latest
echo "Container started."