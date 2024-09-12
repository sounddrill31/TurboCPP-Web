:: Check for internet connectivity
ping -n 1 google.com >nul
if %errorlevel% equ 0 (
  :: Internet is available, proceed with the script
  mkdir jsdos
  cd jsdos
  del *.css *.js

  powershell -Command "Invoke-WebRequest -Uri https://v8.js-dos.com/latest/js-dos.css -OutFile js-dos.css"
  powershell -Command "Invoke-WebRequest -Uri https://v8.js-dos.com/latest/js-dos.js -OutFile js-dos.js"
) else (
  :: No internet, exit the script
  echo No internet connection available. Exiting...
  exit /b 1
)