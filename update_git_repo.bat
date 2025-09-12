@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ================================
echo 🔍 Поиск Git-репозиториев и обновление
echo ================================

for /d /r %%G in (.git) do (
    if exist "%%G\config" (
        set "REPO=%%~dpG"
        set "REPO=!REPO:~0,-1!"
        echo.
        echo 🚀 Найден репозиторий: !REPO!
        git -C "!REPO!" pull
    )
)

echo.
echo ================================
echo ✅ Обновление завершено
echo ================================
pause
