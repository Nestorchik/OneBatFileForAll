@echo off
setlocal
cd /d %~dp0
set curDir=%~dp0
echo ========================================================================================================
echo              Этот скрипт скачает и установит в текущую папку портабельную версию ComfyUI
echo               с портабельным питоном и GIT, установит все пакеты питона для карт NVIDIA
echo                         и сгенерирует файл запуска интерфейса ComfyUI 
echo                         ---------------------------------------------  
echo                        Убедись, что в этой папке ничего нужного нет,
echo                  иначе все будет перезаписано вновь скачанными файлами!!!
echo                  --------------------------------------------------------
echo               Для прекращения работы просто закройте это окно нажатием на "крестик"!
echo ========================================================================================================
pause
echo Скачиваем git...
echo ========================================================================================================
curl --ssl-no-revoke -L -o git.zip https://github.com/Nestorchik/git/releases/download/git_portable/git.zip
echo Готово
echo ========================================================================================================
echo Разархивитуем git...
Call :UnZipFile "%curDir%git" "%curDir%git.zip"
if exist "%curDir%git.zip" del /f /q "%curDir%git.zip"
echo Готово
echo ========================================================================================================
echo Скачиваем python...
echo ========================================================================================================
curl --ssl-no-revoke -L -o python312.pak https://github.com/Nestorchik/python/releases/download/all/python312.pak
echo Готово
echo ========================================================================================================
echo Разархивируем python
expand python312.pak .\ -F:*
if exist "python312.pak" del /f /q "python312.pak"
echo Готово
set PATH=%curDir%git\bin;%curDir%git\libexec\;%curDir%python;%curDir%python\Library\bin;%curDir%python\Scripts
echo ========================================================================================================
echo Скачиваем "ComfyUI"...
echo ========================================================================================================
%curDir%git\bin\git clone https://github.com/comfyanonymous/ComfyUI.git
echo ========================================================================================================
echo Готово
echo Скачиваем "ComfyUI-Manager"...
echo ========================================================================================================
cd %curDir%ComfyUI\custom_nodes
%curDir%git\bin\git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd %curDir%
echo Готово
echo ========================================================================================================
echo Обновляем менеджер пакетов "PIP":
%curDir%python\python -m pip install --upgrade pip
echo Готово
echo ========================================================================================================
echo Инсталлируем пакеты питона для карт NVIDIA:
echo ... torch torchvision torchaudio
echo ========================================================================================================
%curDir%python\python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
echo ========================================================================================================
echo Готово
echo Инсталлируем пакеты ComfyUI...
echo ========================================================================================================
%curDir%python\python -m pip install -r %curDir%ComfyUI\requirements.txt
echo Готово
echo ========================================================================================================
echo Строим и записываем bat-файл...
echo @echo off>run.bat
echo setlocal>>run.bat
echo cd /d %~dp0 >>run.bat
echo set PATH=%curDir%git\bin;%curDir%git\libexec\;%curDir%python;%curDir%python\Library\bin;%curDir%python\Scripts >> run.bat
echo set GIT_EXEC_PATH=%curDir%git\bin;%curDir%git\libexec;%curDir%git\libexec\git-core >> run.bat
echo %curDir%python\python -s %curDir%ComfyUI\main.py --windows-standalone-build >> run.bat
echo ========================================================================================================
echo Запускаем ComfyUI...
echo ========================================================================================================
%curDir%python\python -s %curDir%ComfyUI\main.py --windows-standalone-build
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