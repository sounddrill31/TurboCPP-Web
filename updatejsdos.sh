#!/bin/bash

# Check for internet connectivity
if ping -q -c 1 -W 1 google.com >/dev/null; then
  # Internet is available, proceed with the script
  mkdir -p jsdos
  cd jsdos
  rm *.css *.js

  curl -O https://v8.js-dos.com/latest/js-dos.css
  curl -O https://v8.js-dos.com/latest/js-dos.js
else
  # No internet, exit the script
  echo "No internet connection available. Exiting..."
  exit 1
fi