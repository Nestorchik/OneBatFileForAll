@echo off
setlocal
cd /d %~dp0
set curDir=%~dp0
:: Don't forget to add the paths to the downloaded files to PATH
:: set GIT_EXEC_PATH=%curDir%git\bin;%curDir%git\libexec;%curDir%git\libexec\git-core
echo ========================================================================================================
echo              ��� �ਯ� ᪠砥� � ��⠭���� � ⥪���� ����� ���⠡����� ����� ComfyUI
echo               � ���⠡���� ��⮭�� � GIT, ��⠭���� �� ������ ��⮭� ��� ���� NVIDIA
echo                         � ᣥ������ 䠩� ����᪠ ����䥩� ComfyUI 
echo                         ---------------------------------------------  
echo                        �������, �� � �⮩ ����� ��祣� �㦭��� ���,
echo                  ���� �� �㤥� ��१���ᠭ� ����� ᪠砭�묨 䠩����!!!
echo                  --------------------------------------------------------
echo               ��� �४�饭�� ࠡ��� ���� ���ன� �� ���� ����⨥� �� "���⨪"!
echo ========================================================================================================
pause
echo ���稢��� git...
echo ========================================================================================================
curl --ssl-no-revoke -L -o git.zip https://github.com/Nestorchik/git/releases/download/git_portable/git.zip
echo ��⮢�
echo ========================================================================================================
echo �����娢��㥬 git...
Call :UnZipFile "%curDir%git" "%curDir%git.zip"
if exist "%curDir%git.zip" del /f /q "%curDir%git.zip"
echo ��⮢�
echo ========================================================================================================
echo ���稢��� python...
echo ========================================================================================================
curl --ssl-no-revoke -L -o python.zip https://github.com/Nestorchik/python_embeded/releases/download/python_embeded/python_embeded.zip
echo ��⮢�
echo ========================================================================================================
echo �����娢��㥬 python
Call :UnZipFile "%curDir%python" "%curDir%python.zip"
if exist "%curDir%python.zip" del /f /q "%curDir%python.zip"
echo ��⮢�
set PATH=%curDir%git\bin;%curDir%git\libexec\;%curDir%python;%curDir%python\Library\bin;%curDir%python\Scripts
echo ========================================================================================================
echo ���稢��� "ComfyUI"...
echo ========================================================================================================
%curDir%git\bin\git clone https://github.com/comfyanonymous/ComfyUI.git
echo ========================================================================================================
echo ��⮢�
echo ���稢��� "ComfyUI-Manager"...
echo ========================================================================================================
cd %curDir%ComfyUI\custom_nodes
%curDir%git\bin\git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd %curDir%
echo ��⮢�
echo ========================================================================================================
echo ���⠫���㥬 ������ ��⮭� ��� ���� NVIDIA:
echo ... torch torchvision torchaudio insightface==0.7.3
echo ========================================================================================================
%curDir%python\python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
%curDir%python\python -m pip install insightface==0.7.3
echo ========================================================================================================
echo ��⮢�
echo ���⠫���㥬 ������ ComfyUI...
echo ========================================================================================================
%curDir%python\python -m pip install -r %curDir%ComfyUI\requirements.txt
echo ��⮢�
echo ========================================================================================================
echo ��ந� � �����뢠�� bat-䠩�...
echo @echo off>run.bat
echo setlocal>>run.bat
echo cd /d %~dp0 >>run.bat
echo set PATH=%curDir%git\bin;%curDir%git\libexec\;%curDir%python;%curDir%python\Library\bin;%curDir%python\Scripts >> run.bat
echo set GIT_EXEC_PATH=%curDir%git\bin;%curDir%git\libexec;%curDir%git\libexec\git-core >> run.bat
echo %curDir%python\python -s %curDir%ComfyUI\main.py --auto-launch >> run.bat
echo ========================================================================================================
echo ����᪠�� ComfyUI...
echo ========================================================================================================
%curDir%python\python %curDir%ComfyUI\main.py --windows-standalone-build
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