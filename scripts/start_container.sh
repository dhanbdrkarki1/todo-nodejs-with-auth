#!/bin/bash
# Pull the Docker image
echo "Pulling Docker image..."
docker pull $REPOSITORY_URI:$IMAGE_TAG

# Run the Docker container
echo "Starting Docker container..."
docker run -d -p 3000:3000 --name todo-app $REPOSITORY_URI:$IMAGE_TAG
echo "Container started."