#!/bin/bash

# Clean up app2 directory
if [ -d "/var/www/app2" ]; then
  rm -rf /var/www/app2/*
fi