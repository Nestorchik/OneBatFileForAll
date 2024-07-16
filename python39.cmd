@echo off
curl --ssl-no-revoke -L -o python39.pak https://github.com/Nestorchik/python/releases/download/all/python39.pak >nul
expand python39.pak .\ -F:*
if exist "python39.pak" del /f /q "python39.pak"
.\python\python --version
pause