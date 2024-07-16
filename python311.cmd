@echo off
curl --ssl-no-revoke -L -o python311.pak https://github.com/Nestorchik/python/releases/download/all/python311.pak >nul
expand python311.pak .\ -F:*
if exist "python311.pak" del /f /q "python311.pak"
.\python\python --version
pause