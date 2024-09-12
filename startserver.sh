#!/bin/bash

# Check if npx is installed
if command -v npx &> /dev/null; then
  # npx is installed, use npx http-server
  npx http-server
else
  # npx is not installed, use python
  python -m http.server 8080
fi