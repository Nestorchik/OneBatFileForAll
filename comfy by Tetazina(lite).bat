@echo off
setlocal
cd /d %~dp0
set target_dir=%~dp0
chcp 65001 > nul
set custom_n=%target_dir%ComfyUI\custom_nodes
set py=%target_dir%python\

call :ColorText "=============================================================" "Yellow"
call :ColorText ".bat file for installing lite version comfyui by TetaZina" "Green"
call :ColorText "telegram @partiaComfynistov or https://t.me/partiaComfynistov" "blue"
call :ColorText "=============================================================" "red"

echo ================================
echo Downloading and unzip python+git
echo ================================
curl --ssl-no-revoke -L -o pygit.bat https://huggingface.co/happyneishon/git/resolve/main/pygit.bat
call %target_dir%pygit.bat
rem del /f /q %target_dir%pygit.bat

echo ===================
echo Downloading ComfyUI
echo ===================
curl --ssl-no-revoke -L -o comfy.bat https://huggingface.co/happyneishon/git/resolve/main/comfy.bat
call %target_dir%comfy.bat
del /f /q %target_dir%comfy.bat

echo ===========================
echo Installing ComfyUI packages
echo ===========================
(
echo @echo off
echo setlocal
echo cd /d %~dp0
echo set target_dir=%~dp0
echo chcp 65001 > nul
echo set custom_n=%target_dir%ComfyUI\custom_nodes
echo set py=%target_dir%python\
echo %target_dir%python\python -m pip install -r %target_dir%ComfyUI\requirements.txt
echo %target_dir%python\python -m pip uninstall torch torchvision torchaudio -y
echo %target_dir%python\python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
) > packages.bat
call %target_dir%packages.bat
del /f /q %target_dir%packages.bat

echo =================================
echo run menu.bat install custom nodes
echo =================================
cd %target_dir%
curl --ssl-no-revoke -L -o menu.bat https://huggingface.co/happyneishon/git/resolve/main/menu.bat
call %target_dir%menu.bat

echo ========================
echo Building update bat file
echo ========================

curl --ssl-no-revoke -L -o update.bat https://huggingface.co/happyneishon/git/resolve/main/update.bat

cd %target_dir%
curl --ssl-no-revoke -L -o fix.bat https://huggingface.co/happyneishon/git/resolve/main/fix.bat
call %target_dir%fix.bat

echo =====================
echo Building run.bat file
echo =====================
echo @echo off > run.bat
echo setlocal >> run.bat
echo cd /d %~dp0 >>run.bat
echo set PATH=%target_dir%git\git\bin;%target_dir%git\git\libexec\;%target_dir%python;%target_dir%\python\Library\bin;%target_dir%python\Scripts >> run.bat
echo %target_dir%python\python %target_dir%ComfyUI\main.py --auto-launch >> run.bat

call :ColorText "=============================================================" "Yellow"
call :ColorText ".bat file for installing lite version comfyui by TetaZina" "Green"
call :ColorText "telegram @partiaComfynistov or https://t.me/partiaComfynistov" "blue"
call :ColorText "=============================================================" "red"

echo ================
echo Starting ComfyUI
echo ================
start "" "%target_dir%run.bat"
del "%~f0"
exit /b

:ColorText
setlocal
set text=%~1
set color=%~2
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host '%text%' -ForegroundColor %color%"
exit /b
pause