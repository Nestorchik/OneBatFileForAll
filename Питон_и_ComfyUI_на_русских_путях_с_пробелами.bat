@echo off
chcp 866 >nul
cd /d %~dp0
set curDir=%~dp0
echo ========================================================================================================
echo  �ਬ�� ࠡ��� � ��ਫ��楩 � �஡����� � ��⮭�.
echo  �᫨ �����, �� �祭� �����, � �����.
echo ========================================================================================================
curl --ssl-no-revoke -L -o wget.exe https://github.com/Nestorchik/wget/releases/download/wget_portable/wget.exe
"%curDir%wget" -c -q --show-progress --no-check-certificate https://github.com/Nestorchik/git/releases/download/git_portable/git.zip
"%curDir%wget" -c -q --show-progress --no-check-certificate https://github.com/Nestorchik/python_embeded/releases/download/python_embeded/python_embeded.zip
powershell -c "Expand-Archive -Force 'git.zip' '��� � �஡����'"
if exist "git.zip" del /f /q "git.zip"
powershell -c "Expand-Archive -Force 'python_embeded.zip' '��⮭ � �஡����'"
if exist "python_embeded.zip" del /f /q "python_embeded.zip"
if exist "wget.exe" del /f /q "wget.exe"
if exist ".wget-hsts" del /f /q ".wget-hsts"
set "PATH=%curDir%��� � �஡����\bin;%curDir%��� � �஡����\bin\libexec\git-core;%curDir%��⮭ � �஡����"
echo ========================================================================================================
cd %curDir%��� � �஡����\bin
md "%curDir%ComfyUI"
git clone https://github.com/comfyanonymous/ComfyUI.git "%curDir%ComfyUI"
echo ========================================================================================================
git clone https://github.com/ltdrdata/ComfyUI-Manager.git "%curDir%ComfyUI\custom_nodes\ComfyUI-Manage"
cd %curDir%
echo @echo off>run.bat
echo setlocal>>run.bat
echo cd /d "%~dp0">>run.bat
echo set curDir="%~dp0">>run.bat
echo set "PATH=%curDir%��� � �஡����\bin;%curDir%��� � �஡����\mingw64\bin;%curDir%��� � �஡����\mingw64\libexec\git-core;%curDir%��⮭ � �஡����">>run.bat
echo python "%curDir%ComfyUI\main.py" --auto-launch>>run.bat
cd "%curDir%��⮭ � �஡����"
python.exe -m pip install --upgrade pip
python -m pip install numpy==1.26.4
python -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
python -m pip install -r "%curDir%ComfyUI\requirements.txt"
python -m pip install -r "%curDir%ComfyUI\custom_nodes\ComfyUI-Manage\requirements.txt"
python "%curDir%ComfyUI\main.py" --auto-launch
exit /b
