@echo off
setlocal
cd /d %~dp0
:: Download secction
echo -------------------------------------------------------------------------------------------------------------------
echo Downloading wget...
echo -------------------------------------------------------------------------------------------------------------------
curl --ssl-no-revoke -L -o wget.exe https://github.com/Nestorchik/wget/releases/download/wget_portable/wget.exe
echo Done
echo -------------------------------------------------------------------------------------------------------------------
echo Downloading ZIP-files...
echo -------------------------------------------------------------------------------------------------------------------
%curDir%wget -c -q --show-progress https://github.com/Nestorchik/git/releases/download/git_portable/git.zip
%curDir%wget -c -q --show-progress https://github.com/Nestorchik/python_embeded/releases/download/python_embeded/python_embeded.zip
echo Done
echo -------------------------------------------------------------------------------------------------------------------
echo Run UnZip command...
:: Extracting ZIP-files
powershell -command "Expand-Archive -Force '%curDir%git.zip' '%curDir%git_portable_free_name_folder'"
powershell -command "Expand-Archive -Force '%curDir%python_embeded.zip' '%curDir%python_portable_free_name_folder'"
echo Done
echo -------------------------------------------------------------------------------------------------------------------
:: Garbage removal
if exist "%curDir%.wget-hsts" del /f /q "%curDir%.wget-hsts"
if exist "%curDir%wget.exe" del /f /q "%curDir%wget.exe"
if exist "%curDir%python_embeded.zip" del /f /q "%curDir%python_embeded.zip"
if exist "%curDir%git.zip" del /f /q "%curDir%git.zip"
:: and exit "back" if called by "CAll"
:: if you need close "cmd" window - remove next "pause"
pause
exit /b