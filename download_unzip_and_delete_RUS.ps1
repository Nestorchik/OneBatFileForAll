cls
write-host ----------------------------------------------------------------------------------------
write-host ���������� GIT...
Invoke-WebRequest https://github.com/Nestorchik/git/releases/download/git_portable/git.zip -OutFile git.zip
write-host ������
write-host ----------------------------------------------------------------------------------------
write-host ������������...
Expand-Archive -Force git.zip git_folder
write-host ������
write-host ������� � PATH set GIT_EXEC_PATH=%curDir%git\bin;%curDir%git\mingw64\bin;%curDir%git\mingw64\libexec\git-core\
write-host ----------------------------------------------------------------------------------------
write-host �������� ��������� ������...
Remove-Item git.zip
write-host ������
write-host ----------------------------------------------------------------------------------------
cmd /c pause
