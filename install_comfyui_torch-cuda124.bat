@echo off
chcp 1251 >nul
echo ========================================================================================================
echo              ���� ������ ������� � ��������� � ������� ����� GIT-������ ComfyUI
echo                         ��������� ��� ������ ������ ��� ���� NVIDIA
echo                         � ����������� ���� ������� ���������� ComfyUI 
echo                         ---------------------------------------------  
echo                        �������, ��� � ���� ����� ������ ������� ���,
echo                  ����� ��� ����� ������������ ����� ���������� �������!!!
echo                  --------------------------------------------------------
echo                          ���������, ��� ��� GIT ��������� � PATH
echo                     �������� ���� � ������ "python=c:\p312\python.exe"
echo                   �� ���������� ������ ���� � ������ ������ � ������ 23.
echo                       ���������� ������ ������ - 3.10, 3.11 ��� 3.12
echo                  --------------------------------------------------------
echo               ��� ����������� ������ ������ �������� ��� ���� �������� �� "�������"!
echo ========================================================================================================
pause
setlocal
cls
echo
:: �������� � ��������� ������ ���� � ������ ������. 
set python=c:\p312\python.exe
set startDir=%CD%
set comfy=%startDir%\ComfyUI
set venv=%comfy%\venv
set scripts=%venv%\Scripts
echo ========================================================================================================
echo ��������� "ComfyUI"
echo ========================================================================================================
git clone https://github.com/comfyanonymous/ComfyUI.git
echo ========================================================================================================
echo ��������� VENV ��� ComfyUI
%python% -m venv %venv%
echo ========================================================================================================
echo ���������� ������ PIP
%scripts%\python -m pip install --upgrade pip
echo ========================================================================================================
echo ���������� � ��������� ������ TORCH-CUDA124
%scripts%\python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
echo ========================================================================================================
echo ��������� ������� ������ "ComfyUI"
%scripts%\python -m pip install -r %comfy%\requirements.txt
echo ========================================================================================================
echo ��������� "ComfyUI-Manager"
cd %comfy%\custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd %startDir%
echo ========================================================================================================
echo ��������� ������� ������ "ComfyUI-Manager"
%scripts%\python -m pip install -r %comfy%\custom_nodes\ComfyUI-Manager\requirements.txt
cd %startDir%
echo ========================================================================================================
echo ������ � ���������� bat-����...
echo @echo off>run.bat
echo setlocal>>run.bat
echo cd /d %~dp0 >>run.bat
echo %scripts%\python -s %comfy%\main.py --windows-standalone-build >> run.bat
echo ========================================================================================================
echo ��������� ���������
echo ========================================================================================================
echo �� �������� ���������� ������ � ����� "ComfyUI\models\checkpoints"
echo ��� ���������� "SymLinkCreator" ��� �������� ���-������
echo �� ������������ ������ � ����� �����������.
echo https://github.com/Nestorchik/SymLinkCreator.git
echo ==================================
echo ������ "ComfyUI"
echo ==================================
echo
echo ������ "ComfyUI" �� ������ http://127.0.0.1:8188
echo
%scripts%\python -s %comfy%\main.py --windows-standalone-build
pause


