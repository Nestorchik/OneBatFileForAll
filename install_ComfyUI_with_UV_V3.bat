@echo off && cd /D %CD%
echo Installing "UV+ComfyUI"
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
uv python install 3.12
powershell -c "Invoke-WebRequest 'https://github.com/comfyanonymous/ComfyUI/archive/refs/heads/master.zip' -OutFile 'ComfyUI.zip'"
powershell -c "Expand-Archive -Force 'ComfyUI.zip' '%CD%'"
ren ComfyUI-master ComfyUI && if exist "ComfyUI.zip" del /f /q "ComfyUI.zip"
powershell -c "Invoke-WebRequest 'https://github.com/ltdrdata/ComfyUI-Manager/archive/refs/heads/main.zip' -OutFile '%CD%\ComfyUI\custom_nodes\ComfyManager.zip'"
powershell -c "Expand-Archive -Force '%CD%\ComfyUI\custom_nodes\ComfyManager.zip' '%CD%\ComfyUI\custom_nodes'"
cd "%CD%\ComfyUI\custom_nodes" && ren ComfyUI-Manager-main ComfyUI-Manager && if exist "ComfyManager.zip" del /f /q "ComfyManager.zip" && cd "..\..\"
powershell -c "Invoke-WebRequest 'https://github.com/Nestorchik/UV/releases/download/uv/ComfyUI_pyproject.zip' -OutFile 'ComfyUI_pyproject.zip'"
powershell -c "Expand-Archive -Force 'ComfyUI_pyproject.zip' '%CD%'"
if exist "ComfyUI_pyproject.zip" del /f /q "ComfyUI_pyproject.zip"
echo cd "%CD%" >run.bat && echo uv run "%CD%\ComfyUI\main.py" --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest >>run.bat && echo pause >>run.bat
uv run "%CD%\ComfyUI\main.py" --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest
pause
