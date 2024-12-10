::------------------------------------------------------------------------------
:: @link            http://kenijo.github.io/WSH/
:: @description     Initialization script when starting Clink
:: @license         MIT License
::
::        !!! THIS FILE GETS OVERWRITTEN WHEN WSH IS UPDATED !!!
::
:: Set Clink as autorun
::  clink autorun install -- --nolog --profile "%WSH_CLINK%"
::
:: Set Clink as autorun
::  clink config prompt wsh
::
::------------------------------------------------------------------------------

@echo off

:: Display Windows version to mimic original CMD
::for /F "tokens=*" %%a in ('ver') do (set VERSION=%%a)
::echo %VERSION%

:: Find and set the script root directory
if not defined WSH_CLINK set "WSH_CLINK=%~dp0"

:: Move up to WSH root directoryt
for %%I in ("%WSH_CLINK%\..\..") do set "WSH_ROOT=%%~fI"

:: Remove trailing '\'
if "%WSH_CLINK:~-1%" == "\" SET "WSH_CLINK=%WSH_CLINK:~0,-1%"
if "%WSH_ROOT:~-1%" == "\" SET "WSH_ROOT=%WSH_ROOT:~0,-1%"

:: Update PATH
set "PATH=%PATH%;%WSH_ROOT%\config\clink\bin"
set "PATH=%PATH%;%WSH_ROOT%\modules\git\usr\bin"
set "PATH=%PATH%;%WSH_ROOT%\modules\php"
set "PATH=%PATH%;%WSH_ROOT%\modules\putty"

:: Source custom_aliases if it exists
if exist "%WSH_CLINK%\custom_aliases" (
    doskey /macrofile="%WSH_CLINK%\custom_aliases" 2> nul
)

:: Cleanup past Clink files
del /F /Q "%WSH_CLINK%\clink.log" 2> nul
del /F /Q "%WSH_CLINK%\clink_errorlevel_*" 2> nul

exit /B
