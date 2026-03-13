@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set LAYER=%~1
set SLICE=%~2

if "%LAYER%"=="" goto :usage
if "%SLICE%"=="" goto :usage

set VALID=0
for %%L in (entities features pages widgets) do (
    if /i "%LAYER%"=="%%L" set VALID=1
)
if %VALID%==0 (
    echo [ERROR] Недопустимый слой: %LAYER%
    echo Допустимые: entities, features, pages, widgets
    exit /b 1
)

set BASE=src\%LAYER%\%SLICE%

if exist "%BASE%" (
    echo [ERROR] Slice "%SLICE%" уже существует в слое "%LAYER%"
    exit /b 1
)

:: ===== Директории =====
mkdir "%BASE%\ui"
mkdir "%BASE%\model"
mkdir "%BASE%\api"
mkdir "%BASE%\lib"
mkdir "%BASE%\config"

:: ===== UI — Vue-компонент =====
(
echo ^<script setup lang="ts"^>
echo.
echo ^</script^>
echo.
echo ^<template^>
echo   ^<div^>^</div^>
echo ^</template^>
echo.
echo ^<style scoped^>
echo.
echo ^</style^>
) > "%BASE%\ui\%SLICE%.vue"

:: ===== Пустые ts-файлы =====
type nul > "%BASE%\ui\index.ts"
type nul > "%BASE%\model\types.ts"
type nul > "%BASE%\model\index.ts"
type nul > "%BASE%\api\index.ts"
type nul > "%BASE%\lib\index.ts"
type nul > "%BASE%\config\index.ts"
type nul > "%BASE%\index.ts"

:: ===== Результат =====
echo.
echo ========================================
echo  Slice "%SLICE%" создан в слое "%LAYER%"
echo ========================================
echo.
echo  %BASE%\
echo  ├── ui\
echo  │   ├── %SLICE%.vue
echo  │   └── index.ts
echo  ├── model\
echo  │   ├── types.ts
echo  │   └── index.ts
echo  ├── api\
echo  │   └── index.ts
echo  ├── lib\
echo  │   └── index.ts
echo  ├── config\
echo  │   └── index.ts
echo  └── index.ts
echo.
exit /b 0

:usage
echo.
echo Использование: create-slice.bat ^<layer^> ^<slice-name^>
echo.
echo   layer       - entities ^| features ^| pages ^| widgets
echo   slice-name  - имя слайса
echo.
echo Пример:
echo   create-slice.bat features AuthForm
echo   create-slice.bat entities User
exit /b 1

:: Пример использованиия: pnpm slice pages settingPage