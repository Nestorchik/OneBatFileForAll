@echo off
curl --ssl-no-revoke -L -o python310.pak https://github.com/Nestorchik/python/releases/download/all/python310.pak >nul
expand python310.pak .\ -F:*
if exist "python310.pak" del /f /q "python310.pak"
.\python\python --version
pause