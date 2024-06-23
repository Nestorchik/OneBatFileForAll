set custom_n=%CD%\ComfyUI\custom_nodes
:: Don't forget to add the paths to the downloaded files to PATH
:: set GIT_EXEC_PATH=%CD%\git\bin;%CD%\git\libexec;%CD%\git\libexec\git-core
git clone https://github.com/Nestorchik/NStor-ComfyUI-Translation.git %custom_n%\NStor-ComfyUI-Translation
git clone https://github.com/AIGODLIKE/AIGODLIKE-ComfyUI-Translation.git %custom_n%\AIGODLIKE-ComfyUI-Translation
git clone https://github.com/ltdrdata/ComfyUI-Manager.git %custom_n%\ComfyUI-Manage