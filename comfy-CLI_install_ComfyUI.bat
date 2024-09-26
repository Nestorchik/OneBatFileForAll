@echo off
setlocal
set PATH=%CD%\python;%CD%\python\Scripts;%PATH%
:: GIT must be in the PATH
:: set git="git"
::echo %PATH%
::pause
echo ================================================================================
echo  This file will install "Python" with "Comfy-CLI" 
echo ================================================================================
:: In this example - python x86_64_windows 
echo Downloading "Python"...
curl --ssl-no-revoke -L -o python.gz https://github.com/indygreg/python-build-standalone/releases/download/20240909/cpython-3.12.6+20240909-x86_64-pc-windows-msvc-shared-install_only_stripped.tar.gz
tar -xvzf python.gz >nul
if exist "%CD%\python.gz" del /f /q "%CD%\python.gz"
echo done
echo ================================================================================
echo Upgrading "pip"
"%CD%\python\python" -m pip install --upgrade pip
echo done
echo ================================================================================
echo Installing "comfy-cli"...
"%CD%\python\python" -m pip install comfy-cli
echo done
echo ================================================================================
:: You can use at the end one of [--amd | --m_series | --cpu | --nvidia | --intel_arc]
:: Remember about Python version!
echo Installing "ComfyUI"
"%CD%\python\Scripts\comfy" --workspace="%CD%\ComfyUI" --skip-prompt install --nvidia
echo done
echo ================================================================================
echo Installing nodes...
"%CD%\python\Scripts\comfy" node install ComfyUI-Crystools
"%CD%\python\Scripts\comfy" node install ComfyUI-Crystools-save
echo done
:: Example model download
echo ================================================================================
echo Generating file "example_download_model.bat"
echo @echo off >example_download_model.bat
echo echo ================================================================================>>example_download_model.bat
echo echo Downloading model>>example_download_model.bat
echo "%CD%\python\Scripts\comfy" --skip-prompt model download --url https://huggingface.co/stable-diffusion-v1-5/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt>>example_download_model.bat
echo echo done>>example_download_model.bat
echo done
echo echo ================================================================================>>example_download_model.bat
echo pause>>example_download_model.bat
:: Example install custom nodes
echo ================================================================================
echo Generating file "example_install_node.bat"
echo @echo off >example_install_node.bat
echo echo ================================================================================>>example_install_node.bat
echo echo Installing node: "ComfyUI-OpenPose-Editor", wait...>>example_install_node.bat
echo "%CD%\python\Scripts\comfy" node install ComfyUI-OpenPose-Editor>>example_install_node.bat
echo echo done>>example_install_node.bat
echo done
echo echo ================================================================================>>example_install_node.bat
echo pause>>example_install_node.bat
:: Example generate run bat-file
echo ================================================================================
echo Generate file "run_ComfyUI.bat"
echo @echo off>run_ComfyUI.bat
echo "%CD%\python\Scripts\comfy" launch -- --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest>>run_ComfyUI.bat
echo pause>>run_ComfyUI.bat
echo done
:: Example generate bat-file - update all components
echo ================================================================================
echo Generate file "update_all_ComfyUI.bat"
echo @echo off>update_all_ComfyUI.bat
echo echo ================================================================================>>update_all_ComfyUI.bat
echo echo Updating all... wait...>>update_all_ComfyUI.bat
echo "%CD%\python\Scripts\comfy" node update all>>update_all_ComfyUI.bat
echo echo ================================================================================>>update_all_ComfyUI.bat
echo pause>>update_all_ComfyUI.bat
echo done
:: Example start ComfyUI via Comfy-CLI launch
echo ================================================================================
echo Starting "ComfyUI"
"%CD%\python\Scripts\comfy" launch -- --windows-standalone-build --front-end-version Comfy-Org/ComfyUI_frontend@latest
echo ================================================================================
pause
