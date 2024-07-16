@echo off
curl --ssl-no-revoke -L -o python312.pak https://github.com/Nestorchik/python/releases/download/all/python312.pak >nul
expand python312.pak .\ -F:*
if exist "python312.pak" del /f /q "python312.pak"
.\python\python --version
pause