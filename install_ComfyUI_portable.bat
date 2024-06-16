@echo off
setlocal
cd /d %~dp0
set curDir=%~dp0
echo ========================================================================================================
echo Downloading git
echo ========================================================================================================
curl --ssl-no-revoke -L -o git.zip https://github.com/Nestorchik/git/releases/download/git_portable/git.zip
echo Done - downloading git
echo ========================================================================================================
echo UnZip git
Call :UnZipFile "%curDir%git" "%curDir%git.zip"
if exist "%curDir%git.zip" del /f /q "%curDir%git.zip"
echo Done - UnZip git
echo ========================================================================================================
echo Downloading python
echo ========================================================================================================
curl --ssl-no-revoke -L -o python.zip https://github.com/Nestorchik/python_embeded/releases/download/python_embeded/python_embeded.zip
echo Done - downloading python
echo ========================================================================================================
echo UnZip python
Call :UnZipFile "%curDir%python" "%curDir%python.zip"
if exist "%curDir%python.zip" del /f /q "%curDir%python.zip"
echo Done - UnZip python
set PATH=%curDir%git\bin;%curDir%git\libexec\;%curDir%python;%curDir%\python\Library\bin;%curDir%python\Scripts
echo ========================================================================================================
echo Downloading "ComfyUI"
echo ========================================================================================================
%curDir%git\bin\git clone https://github.com/comfyanonymous/ComfyUI.git
echo ========================================================================================================
echo Done - downloading ComfyUI
echo Downloading "ComfyUI-Manager"
echo ========================================================================================================
cd %curDir%ComfyUI\custom_nodes
%curDir%git\bin\git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd %curDir%
echo Done...
echo ========================================================================================================
echo Installing python packages:
echo ... torch torchvision torchaudio insightface==0.7.3
echo ========================================================================================================
%curDir%python\python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
%curDir%python\python -m pip install insightface==0.7.3
echo ========================================================================================================
echo Done...
echo ========================================================================================================
echo Installing ComfyUI packages
echo ========================================================================================================
%curDir%python\python -m pip install -r %curDir%ComfyUI\requirements.txt
echo Done...
echo ========================================================================================================
echo Building bat-files...
echo setlocal>run.bat
echo cd /d %~dp0 >>run.bat
echo set PATH=%curDir%git\bin;%curDir%git\libexec\;%curDir%python;%curDir%\python\Library\bin;%curDir%python\Scripts >> run.bat
echo %curDir%python\python %curDir%ComfyUI\main.py --auto-launch >> run.bat
echo ========================================================================================================
echo Starting ComfyUI...
echo ========================================================================================================
%curDir%python\python %curDir%ComfyUI\main.py --auto-launch
echo ========================================================================================================
exit /b
:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%