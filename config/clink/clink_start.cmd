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

:: Define aliases
doskey dir=dir /A /N $*
doskey dib=dir /A /B /N $*

:: ls --help
::      -A, --almost-all        do not list implied . and ..
::      -F, --classify          append indicator (one of */=>@|) to entries
::      -h, --human-readable    with -l, print sizes in human readable format (e.g., 1K 234M 2G)
::      -N, --literal           print entry names without quoting
::      -v                      natural sort of (version) numbers within text (however it is case sensite: a comes after Z)
::      --color[=WHEN]          colorize the output. WHEN defaults to 'always' or can be 'never' or 'auto'
::      --format=WORD           long -l, single-column -1, vertical -C
::      --time-style=STYLE      STYLE: full-iso, long-iso, iso, locale, +FORMAT
::      --sort=WORD             sort by WORD instead of name: none (-U), size (-S), time (-t), version (-v), extension (-X)
::      -g                      like -l, but do not list owner
::      -o                      like -l, but do not list group information
doskey ls=ls -AFhN --color=auto --time-style=long-iso --format=vertical
::doskey dir=ls -AFhN --color=auto --time-style=long-iso --format=vertical
doskey ll=ls -AFhN --color=auto --time-style=long-iso --format=long

doskey clear=cls $*
doskey df=df -h $*
doskey du=du -h $*
doskey e.=explorer .
doskey egrep=egrep --color=auto $*
doskey fgrep=fgrep --color=auto $*
doskey grep=grep --color=auto $*
doskey pwd=cd
doskey unalias=alias /d $1
doskey vi=vim $*

:: Source custom_commands if it exists
if exist "%WSH_CLINK%\custom_commands" (
    call "%WSH_CLINK%\custom_commands" > nul
)

:: Cleanup past Clink files
del /F /Q "%WSH_CLINK%\clink.log" 2>null
del /F /Q "%WSH_CLINK%\clink_errorlevel_*" 2>null

exit /B
