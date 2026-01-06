@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Create Symlink(s)
color 0A

:START
cls
echo =========================
echo     CREATE SYMLINK(S)
echo =========================
echo.
echo ^*^*THIS SCRIPT MUST BE RUN IN ADMIN^*^*
echo.
echo.

echo Enter the path of the authentic folder
echo.
set "REAL="
set /p "REAL=Authentic Folder Path: "
if not defined REAL goto START

if not exist "%REAL%\" goto REAL_MISSING

echo.
echo.
echo Enter the path of where you want the symlink created (Must NOT exist already)
echo.
set "LINK="
set /p "LINK=Enter Symlink Creation Path: "
if not defined LINK goto START

if exist "%LINK%" goto LINK_EXISTS

rem Parent folder must exist
for %%I in ("%LINK%") do set "PARENT=%%~dpI"
if not exist "%PARENT%\" goto PARENT_MISSING

echo.
echo.
echo Ready to create symlink?
echo   Y - Yes
echo   N - No
echo.
set "CHOICE="
set /p "CHOICE=Enter command: "

if /I "%CHOICE%"=="N" goto START
if /I "%CHOICE%"=="Y" goto CREATE

echo.
echo [ERROR] Invalid choice. Type Y or N.
echo.
pause
goto START

:CREATE
echo.
echo.
echo [ACTION] Creating directory symlink...
echo   REAL    --^> "%REAL%"
echo   SYMLINK --^> "%LINK%"
echo.

mklink /D "%LINK%" "%REAL%" >nul 2>&1
set "EC=%errorlevel%"

echo.
if "%EC%"=="0" goto SUCCESS

echo [FAILED] ErrorLevel: %EC%
echo.
echo Run this .bat as Administrator!!!
echo.
pause
goto START

:SUCCESS
echo [SUCCESS] Symlink created successfully.
echo.
pause
goto START

:REAL_MISSING
echo.
echo [ERROR] Authentic folder does not exist:
echo   "%REAL%"
echo.
pause
goto START

:LINK_EXISTS
echo.
echo [ERROR] Symlink Creation Path already exists (it MUST NOT exist):
echo   "%LINK%"
echo.
pause
goto START

:PARENT_MISSING
echo.
echo [ERROR] Parent folder does not exist:
echo   "%PARENT%"
echo.
pause
goto START
