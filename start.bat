@echo off
REM Double-click this file to play Space Waves locally.
cd /d "%~dp0"

set PORT=8080
set URL=http://localhost:%PORT%/index.html

where python >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start "Space Waves server" cmd /c "python -m http.server %PORT%"
    goto :launch
)

where py >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start "Space Waves server" cmd /c "py -m http.server %PORT%"
    goto :launch
)

echo Could not find Python on this machine.
echo Install Python from https://python.org and run this file again.
pause
exit /b 1

:launch
timeout /t 1 /nobreak >nul
start "" "%URL%"
echo Server running at %URL%
echo Close the "Space Waves server" window to stop the game server.
pause
