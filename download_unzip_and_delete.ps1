cls
write-host ----------------------------------------------------------------------------------------
write-host Download GIT...
Invoke-WebRequest https://github.com/Nestorchik/git/releases/download/git_portable/git.zip -OutFile git.zip
write-host Done
write-host ----------------------------------------------------------------------------------------
write-host UnZip...
Expand-Archive -Force git.zip git_folder
write-host Done
write-host ----------------------------------------------------------------------------------------
write-host Delete tmp files...
Remove-Item git.zip
write-host Done
write-host ----------------------------------------------------------------------------------------
cmd /c pause
