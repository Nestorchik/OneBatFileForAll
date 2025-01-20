@echo off
setlocal
set PATH=%CD%;%PATH% 
set curDIR=%CD%
cd /D %curDIR%
powershell -c "Invoke-WebRequest 'https://github.com/Nestorchik/UV/releases/download/uv/uv-x86_64-pc-windows-msvc.zip' -OutFile 'uv.zip'"
powershell -c "Expand-Archive -Force 'uv.zip' '%CD%'"
if exist "uv.zip" del /f /q "uv.zip"
git clone https://github.com/comfyanonymous/ComfyUI.git
git clone https://github.com/ltdrdata/ComfyUI-Manager.git "%curDIR%\ComfyUI\custom_nodes\ComfyUI-Manager"
uv venv --python 3.12
uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
uv pip install pip
uv pip install -r "%curDIR%\ComfyUI\requirements.txt"
echo cd "%curDIR%" >run.bat
echo uv run "%curDIR%\ComfyUI\main.py" --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest >>run.bat
echo pause >>run.bat
uv run "%curDIR%\ComfyUI\main.py" --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest
pause
