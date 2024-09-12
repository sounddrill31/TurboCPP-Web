#!/bin/bash

# Check if the script is running on Windows
if [ "$(expr substr $(uname -s) 1 7)" == "Windows" ]; then
  # Start the HTTP server using PowerShell
  powershell -Command "Add-Type -AssemblyName System.Net.Http; $listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://localhost:8000/'); $listener.Start(); Write-Host 'HTTP server started on http://localhost:8000/'; while ($listener.IsListening) { $context = $listener.GetContext(); $request = $context.Request; $response = $context.Response; $response.StatusCode = 200; $response.ContentType = 'text/html'; $response.OutputStream.Write([System.Text.Encoding]::UTF8.GetBytes(@(Get-Content -Path index.html -Encoding UTF8)), 0, (Get-Content -Path index.html -Encoding UTF8).Length); $response.OutputStream.Close(); }"
else
  # Start the HTTP server using Python
  python -m http.server 8000
fi