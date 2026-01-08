::NStor ComfyUI venv - Version from 08.01.2026
@echo off && setlocal && cd /D %CD%
where uv >nul 2>&1 && uv self update || powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
git clone https://github.com/comfyanonymous/ComfyUI.git
git clone https://github.com/ltdrdata/ComfyUI-Manager.git "%CD%\ComfyUI\custom_nodes\ComfyUI-Manager"
uv venv --python 3.12.12 --seed --clear
uv pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu130
uv pip install -r "%CD%\ComfyUI\requirements.txt"
uv pip install -r "%CD%\ComfyUI\custom_nodes\ComfyUI-Manager\requirements.txt"
echo cd "%CD%" >run.bat
echo uv run "%CD%\ComfyUI\main.py" --windows-standalone-build>>run.bat
echo pause >>run.bat
uv run "%CD%\ComfyUI\main.py" --windows-standalone-build
pause
