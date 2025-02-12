#!/bin/bash

TARGET_DIR="/home/ec2-user/app"

# Check if directory exists and clean it
if [ -d "$TARGET_DIR" ]; then
    echo "Cleaning up directory: $TARGET_DIR"
    
    rm -rf "$TARGET_DIR"/*
fi