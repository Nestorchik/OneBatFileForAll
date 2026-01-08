@echo off && setlocal && cd /D %CD%
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
uv python install 3.12
git clone https://github.com/comfyanonymous/ComfyUI.git
git clone https://github.com/ltdrdata/ComfyUI-Manager.git "%CD%\ComfyUI\custom_nodes\ComfyUI-Manager"
uv venv --python 3.12 --seed
uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu129
uv pip install -r "%CD%\ComfyUI\requirements.txt"
uv pip install -r "%CD%\ComfyUI\custom_nodes\ComfyUI-Manager\requirements.txt"
echo cd "%CD%" >run.bat
echo uv run "%CD%\ComfyUI\main.py" --windows-standalone-build --preview-method latent2rgb --preview-size 512>>run.bat
echo pause >>run.bat
uv run "%CD%\ComfyUI\main.py" --windows-standalone-build
pause
