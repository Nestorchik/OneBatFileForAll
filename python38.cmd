@echo off
curl --ssl-no-revoke -L -o python38.pak https://github.com/Nestorchik/python/releases/download/all/python38.pak >nul
expand python38.pak .\ -F:*
if exist "python38.pak" del /f /q "python38.pak"
.\python\python --version
pause