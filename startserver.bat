:: Kill all instances of nginx
taskkill /im nginx.exe /f

:: Remove all files in prebuilts\nginx-1.27.1\html
del /q /s prebuilts\nginx-1.27.1\html\*

:: Copy index.html and jsdos folder along with *.jsdos to prebuilts\nginx-1.27.1\html
copy /y index.html prebuilts\nginx-1.27.1\html
xcopy /y /s jsdos prebuilts\nginx-1.27.1\html\jsdos
copy /y *.jsdos prebuilts\nginx-1.27.1\html

:: Change directory to prebuilts\nginx-1.27.1 and run nginx.exe
cd /d prebuilts\nginx-1.27.1
if not exist temp mkdir temp
nginx.exe -c conf/nginx.conf 