set custom_n=%CD%\ComfyUI\custom_nodes
git clone https://github.com/Nestorchik/NStor-ComfyUI-Translation.git %custom_n%\NStor-ComfyUI-Translation
git clone https://github.com/AIGODLIKE/AIGODLIKE-ComfyUI-Translation.git %custom_n%\AIGODLIKE-ComfyUI-Translation
git clone https://github.com/ltdrdata/ComfyUI-Manager.git %custom_n%\ComfyUI-Manage
git -C "%CD%\ComfyUI\custom_nodes\NStor-ComfyUI-Translation" pull
git -C "%CD%\ComfyUI\custom_nodes\AIGODLIKE-ComfyUI-Translation" pull
git -C "%CD%\ComfyUI\custom_nodes\ComfyUI-Manage" pull
pause
