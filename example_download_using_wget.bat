@echo off
setlocal
cd /d %~dp0
set curDir=%~dp0
echo -------------------------------------------------------------------------------------------------------------------
echo Downloading wget
echo -------------------------------------------------------------------------------------------------------------------
curl --ssl-no-revoke -L -o wget.exe https://github.com/Nestorchik/wget/releases/download/wget_portable/wget.exe
echo Done - downloading wget
echo -------------------------------------------------------------------------------------------------------------------
echo Downloading models
echo -------------------------------------------------------------------------------------------------------------------
%curDir%wget -c -q --show-progress https://github.com/Nestorchik/git/releases/download/git_portable/git.zip
echo -------------------------------------------------------------------------------------------------------------------
%curDir%wget -c -q --show-progress https://github.com/Nestorchik/python/releases/download/python_portable_310/python.zip
echo -------------------------------------------------------------------------------------------------------------------
if exist "%curDir%.wget-hsts" del /f /q "%curDir%.wget-hsts"
if exist "%curDir%wget.exe" del /f /q "%curDir%wget.exe"
pause
exit /b