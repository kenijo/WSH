::------------------------------------------------------------------------------
:: @link            http://kenijo.github.io/WSH/
:: @description     Initialization script when starting CMD
:: @license         MIT License
::
::        !!! THIS FILE GETS OVERWRITTEN WHEN WSH IS UPDATED !!!
::------------------------------------------------------------------------------

@echo off

:: Display Windows version to mimic original CMD
for /F "tokens=*" %%a in ('ver') do (set VERSION=%%a)
echo %VERSION%

:: Find and set the script root directory
if not defined WSH_ROOT set "WSH_ROOT=%~dp0"

:: Move up to WSH root directoryt
for %%I in ("%WSH_ROOT%\..\..") do set "WSH_ROOT=%%~fI"

:: Remove trailing '\'
if "%WSH_ROOT:~-1%" == "\" SET "WSH_ROOT=%WSH_ROOT:~0,-1%"

:: Update PATH
set "PATH=%PATH%;%WSH_ROOT%\modules\bin"
set "PATH=%PATH%;%WSH_ROOT%\modules\git\usr\bin"
set "PATH=%PATH%;%WSH_ROOT%\modules\php"
set "PATH=%PATH%;%WSH_ROOT%\modules\putty"

:: Source aliases.cmd if it exists
if exist "%WSH_ROOT%\config\cmd\aliases.cmd" (
    call "%WSH_ROOT%\config\cmd\aliases.cmd"
)

:: Source custom_commands.cmd if it exists
if exist "%WSH_ROOT%\config\cmd\custom_commands.cmd" (
    call "%WSH_ROOT%\config\cmd\custom_commands.cmd"
)

:: Inject clink
:: "%WSH_ROOT%\modules\clink\clink.bat" inject --nolog --quiet --profile "%WSH_ROOT%\config\clink"

exit /b
