#!/bin/bash
set -e  # Exit on error

# Load environment variables
if [ -f "/home/ec2-user/app/env_vars" ]; then
    export $(grep -v '^#' /home/ec2-user/app/env_vars | xargs)
else
    echo "Error: env_vars file not found!"
    exit 1
fi

# Ensure variables are set
if [ -z "$REPOSITORY_URI" ] || [ -z "$IMAGE_TAG" ]; then
    echo "Error: REPOSITORY_URI or IMAGE_TAG is not set!"
    exit 1
fi

echo "Using REPOSITORY_URI: $REPOSITORY_URI"
echo "Using IMAGE_TAG: $IMAGE_TAG"

# Authenticate Docker with ECR
echo "Authenticating with ECR..."
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI


# Pull the latest image from ECR
echo "Pulling Docker image..."
docker pull $REPOSITORY_URI:$IMAGE_TAG || { echo "Failed to pull Docker image"; exit 1; }

# Run the new container
echo "Starting Docker container..."
docker run -d -p 80:3000 --name $CONTAINER_NAME $REPOSITORY_URI:$IMAGE_TAG || { echo "Failed to start container"; exit 1; }

echo "Container started successfully."