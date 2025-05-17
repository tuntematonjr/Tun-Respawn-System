@echo off
pushd %~dp0

rem === Resolve absolute paths ===
set "cfgRel=server\server_basic.cfg"
set "configRel=server\server_config.cfg"
set "modRel=..\Tun-Respawn-System\.hemttout\build"

for %%I in ("%cfgRel%") do set "cfgPath=%%~fI"
for %%I in ("%configRel%") do set "configPath=%%~fI"
for %%I in ("%modRel%") do set "modPath=%%~fI"

echo Resolved Paths:
echo   -cfg=%cfgPath%
echo   -config=%configPath%
echo   -mod=%modPath%

popd

echo Copied from, credits for them: https://github.com/MultiTheFranky/rtf-42nd/blob/main/debugMultiplayer.bat

rem === Full loop for launching server and clients ===
:fullLoop



rem === Launch HEMTT server with config paths ===
hemtt launch server -- "-cfg=%cfgPath%" "-config=%configPath%" "-mod=%modPath%"

rem Check if the process gives an error
if errorlevel 1 goto armaClosed

rem Sleep for 5 seconds
timeout /t 5 >nul

rem Launch the Arma 3 clients (2 clients)
hemtt launch player -i 2 -Q -- "-mod=%modPath%"

timeout /t 5 >nul

rem Check every 1 second if Arma 3 is still running
:loop
tasklist /fi "imagename eq arma3_x64.exe" | find /i /n "arma3_x64.exe" >nul
if errorlevel 1 goto armaClosed
timeout /t 1 >nul
goto loop

:armaClosed
echo.
echo 1. Restart only
echo 2. Close
echo.

CHOICE /C 12 /M "Select an option: "
IF ERRORLEVEL 2 GOTO stopDebug
IF ERRORLEVEL 1 GOTO fullLoop

:stopDebug
exit