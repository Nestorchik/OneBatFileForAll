@echo off
echo -------------------------------------------------------------------------------------------------------------------
echo                       This script install "ComfyUI_windows_portable_nvidia_cu121_or_cpu"
echo                                    from original "ConfyUI" git repository
echo                                   -----------------------------------------
echo                                    Save all files from current directory!!! 
echo                  Close this windows by pressing cross of the window or any key to continue...
echo -------------------------------------------------------------------------------------------------------------------
pause
cls
setlocal
cd /d %~dp0
set curDir=%~dp0
echo -------------------------------------------------------------------------------------------------------------------
echo Downloading wget...
echo -------------------------------------------------------------------------------------------------------------------
curl --ssl-no-revoke -L -o wget.exe https://github.com/Nestorchik/wget/releases/download/wget_portable/wget.exe
echo Done
echo Downloading ComfyUI_portable and 7z...
echo -------------------------------------------------------------------------------------------------------------------
%curDir%wget -c -q --show-progress https://github.com/Nestorchik/7z/releases/download/7z/7z.zip
%curDir%wget -c -q --show-progress https://github.com/comfyanonymous/ComfyUI/releases/download/latest/ComfyUI_windows_portable_nvidia_cu121_or_cpu.7z
echo Done
if exist "wget.exe" del /f /q "wget.exe"
if exist ".wget-hsts" del /f /q ".wget-hsts"
echo -------------------------------------------------------------------------------------------------------------------
echo UnZip 7z
powershell -command "Expand-Archive -Force '7z.zip' '7z'"
echo Done
if exist "7z.zip" del /f /q "7z.zip"
echo Unboxing ComfyUI_portable
%curDir%7z\7z x "%curDir%ComfyUI_windows_portable_nvidia_cu121_or_cpu.7z"
echo Done 
@RD /S /Q "%curDir%7z"
if exist "ComfyUI_windows_portable_nvidia_cu121_or_cpu.7z" del /f /q "ComfyUI_windows_portable_nvidia_cu121_or_cpu.7z"
echo -------------------------------------------------------------------------------------------------------------------
pause
