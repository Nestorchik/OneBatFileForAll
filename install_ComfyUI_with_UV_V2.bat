@echo off && setlocal && cd /D %CD%
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
git clone https://github.com/comfyanonymous/ComfyUI.git
git clone https://github.com/ltdrdata/ComfyUI-Manager.git "%CD%\ComfyUI\custom_nodes\ComfyUI-Manager"
uv venv --python 3.12
uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
uv pip install pip
uv pip install -r "%CD%\ComfyUI\requirements.txt"
echo cd "%CD%" >run.bat
echo uv run "%CD%\ComfyUI\main.py" --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest >>run.bat
echo pause >>run.bat
uv run "%CD%\ComfyUI\main.py" --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest
pause
