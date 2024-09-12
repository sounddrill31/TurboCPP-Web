#!/bin/bash

# Check if npx is installed and internet is available
if command -v npx &> /dev/null && ping -q -c 1 -W 1 google.com &> /dev/null; then
  # npx is installed and internet is available, use npx http-server
  npx http-server
else
  # npx is not installed or internet is not available
  # Check if python is installed
  if command -v python &> /dev/null; then
    # python is installed, use python http.server
    python -m http.server 8080
  else
    # python is not installed, print an error message
    echo "Neither npx nor python is installed, cannot start http server."
  fi
fi