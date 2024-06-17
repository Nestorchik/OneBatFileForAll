@echo off
:: Download secction
powershell -command "Invoke-WebRequest 'https://github.com/Nestorchik/git/releases/download/git_portable/git.zip' -OutFile 'git.zip'"
powershell -command "Invoke-WebRequest 'https://github.com/Nestorchik/python_embeded/releases/download/python_embeded/python_embeded.zip' -OutFile 'python_embeded.zip'"
:: UnZip section
powershell -command "Expand-Archive -Force 'git.zip' 'git_portable_free_name_folder'"
powershell -command "Expand-Archive -Force 'python_embeded.zip' 'python_portable_free_name_folder'"
:: Garbage removal section
if exist "git.zip" del /f /q "git.zip"
if exist "python_embeded.zip" del /f /q "python_embeded.zip"
:: and exit "back" if called by "CAll"
:: if you need close "cmd" window - remove next "pause"
pause
exit /b