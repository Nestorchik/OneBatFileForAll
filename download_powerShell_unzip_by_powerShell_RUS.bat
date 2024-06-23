@echo off
setlocal
set curDIR=%CD%
:: ����� ������� (4-5-6 ��ப) �⮡� ᤢ����� ���� ��砫�� ᮮ�饭��
:: �.�. �� ������� ��砫쭮�� ᮮ�饭�� �㤥� ����뢠���� ����ᮩ PowerShell
echo =======================================================================================================
echo ��� �ਯ� ᪠砥� � ��⠭���� �祭� ����᭮� �ਫ������
echo              �� ��� -= ���� � ����� =-
echo =======================================================================================================
echo �������, �� � �⮩ ����� ��祣� �㦭��� ���, ���� �� �㤥� ��१���ᠭ� ����� ᪠砭�묨 䠩����!!!
echo ������ ���� ������� ��� �த�������
echo ��� �४�饭�� ࠡ��� ���� ���ன� �� ���� ����⨥� �� "���⨪".
echo =======================================================================================================
pause
:: ����� ᪠稢����
echo ���稢��� git...
powershell -c "Invoke-WebRequest 'https://github.com/Nestorchik/git/releases/download/git_portable/git.zip' -OutFile 'git.zip'"
echo ��⮢�
echo =======================================================================================================
echo ���稢��� Python...
powershell -c "Invoke-WebRequest 'https://github.com/Nestorchik/python_embeded/releases/download/python_embeded/python_embeded.zip' -OutFile 'python_embeded.zip'"
echo ��⮢�
::
:: ����� ࠧ��娢�樨
echo =======================================================================================================
echo �����娢��㥬 git...
powershell -c "Expand-Archive -Force 'git.zip' 'git_portable_free_name_folder'"
echo ��⮢�
echo =======================================================================================================
echo �����娢��㥬 Python
powershell -c "Expand-Archive -Force 'python_embeded.zip' 'python_portable_free_name_folder'"
echo ��⮢�
:: �� ������ �������� � PATH ��� �� ᪠砭���
:: set GIT_EXEC_PATH=%curDir%\git\bin;%curDir%\git\libexec;%curDir%\git\libexec\git-core
::
:: ����� 㤠����� �६����� 䠩���
echo =======================================================================================================
echo ������ �६���� 䠩��
if exist "git.zip" del /f /q "git.zip"
if exist "python_embeded.zip" del /f /q "python_embeded.zip"
echo ��⮢�
echo =======================================================================================================
:: �᫨ �� ���� ����� ������ ������ ��� �����襭�� ࠡ��� (�⮡� ������ �뫮 ��-� ������ � �࠭�)
:: ��������஢��� ��� 㤠���� "pause"
pause
:: � ��室 � ⥣�� "/b" �⮡� �������� � ��뢠�騩 䠩� �᫨ �맢��� �� "call"
exit /b