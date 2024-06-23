@echo off
setlocal
cd /d %~dp0
set curDir=%~dp0
:: Don't forget to add the paths to the downloaded files to PATH
echo ========================================================================================================
echo Downloading git
echo ========================================================================================================
curl --ssl-no-revoke -L -o git.zip https://github.com/Nestorchik/git/releases/download/git_portable/git.zip
echo Done - downloading git
echo ========================================================================================================
echo UnZip git
Call :UnZipFile "%curDir%git" "%curDir%git.zip"
if exist "%curDir%git.zip" del /f /q "%curDir%git.zip"
echo ========================================================================================================
echo Done - UnZip git
echo ========================================================================================================
set PATH=%PATH%;%curDir%git\bin;%curDir%git\libexec\
set GIT_EXEC_PATH=%curDir%git\bin;%curDir%git\libexec;%curDir%git\libexec\git-core
echo Downloading Python 3.10.11
echo ========================================================================================================
%curDir%git\bin\git clone https://github.com/Nestorchik/python
echo ========================================================================================================
echo Done - downloading Python 3.10.11
echo ========================================================================================================
echo Testing environment
echo ========================================================================================================
%curDir%python\python --version
%curDir%python\python -m pip --version
%curDir%git\bin\git --version
echo ========================================================================================================
echo Done - testing environment
echo ========================================================================================================
echo Writing test bat file
echo %curDir%python\python --version > test_environment.bat
echo %curDir%python\python -m pip --version >> test_environment.bat
echo %curDir%git\bin\git --version >> test_environment.bat
echo pause >> test_environment.bat
echo Done - writing test bat file
echo Start test_environment.bat for testing installed versions
echo ========================================================================================================
rem Дальше сами...
pause
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
