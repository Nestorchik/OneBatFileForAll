powershell -c "Invoke-WebRequest 'https://github.com/indygreg/python-build-standalone/releases/download/20240909/cpython-3.12.6+20240909-x86_64-pc-windows-msvc-shared-install_only_stripped.tar.gz' -OutFile 'python.gz'"
tar -xzf python.gz
if exist "python.gz" del /f /q "python.gz"
exit /b