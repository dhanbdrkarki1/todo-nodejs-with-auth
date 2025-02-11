#!/bin/bash
# Verify the deployment
echo "Verifying deployment..."
sleep 10 # Wait for the application to start
curl -s http://localhost:3000 || exit 1
echo "Deployment verified."