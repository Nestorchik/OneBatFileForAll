cls
Invoke-WebRequest https://github.com/Nestorchik/git/releases/download/git_portable/git.zip -OutFile git.zip
Expand-Archive -Force git.zip git_folder
wrire-hist --- REMEMBER SET PATH set GIT_EXEC_PATH=%curDir%git\bin;%curDir%git\mingw64\bin;%curDir%git\mingw64\libexec\git-core\
Remove-Item git.zip
cmd /c pause
