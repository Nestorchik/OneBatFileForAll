cls
write-host ----------------------------------------------------------------------------------------
write-host Скачивание GIT...
Invoke-WebRequest https://github.com/Nestorchik/git/releases/download/git_portable/git.zip -OutFile git.zip
write-host Готово
write-host ----------------------------------------------------------------------------------------
write-host Разархивация...
Expand-Archive -Force git.zip git_folder
write-host Готово
write-host ВНЕСИТЕ В PATH set GIT_EXEC_PATH=%curDir%git\bin;%curDir%git\mingw64\bin;%curDir%git\mingw64\libexec\git-core\
write-host ----------------------------------------------------------------------------------------
write-host Удаление временных файлов...
Remove-Item git.zip
write-host Готово
write-host ----------------------------------------------------------------------------------------
cmd /c pause
