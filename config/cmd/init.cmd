::-----------------------------------------------------------------------------
:: @author       Kenrick JORUS
:: @copyright    2022 Kenrick JORUS
:: @license      MIT License
:: @link         http://kenijo.github.io/WSH/
:: @description  Initialization script when starting CMD
::               !!! THIS FILE GETS OVERWRITTEN WHEN WSH IS UPDATED
::-----------------------------------------------------------------------------

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
set "PATH=%PATH%;%WSH_ROOT%\modules\kitty"
set "PATH=%PATH%;%WSH_ROOT%\modules\php"

:: Define aliases
doskey dir=dir /A /N $*
doskey dib=dir /A /B /N $*

:: ls --help
::    -A, --almost-all           do not list implied . and ..
::    -F, --classify             append indicator (one of */=>@|) to entries
::    -h, --human-readable       with -l, print sizes in human readable format (e.g., 1K 234M 2G)
::    -N, --literal              print entry names without quoting
::    -v                         natural sort of (version) numbers within text (however it is case sensite: a comes after Z)
::    --color[=WHEN]             colorize the output. WHEN defaults to 'always' or can be 'never' or 'auto'
::    --format=WORD              long -l, single-column -1, vertical -C
::    --time-style=STYLE         STYLE: full-iso, long-iso, iso, locale, +FORMAT
::    --sort=WORD                sort by WORD instead of name: none (-U), size (-S), time (-t), version (-v), extension (-X)
::    -g                         like -l, but do not list owner
::    -o                         like -l, but do not list group information

doskey clear=cls $*
doskey df=df -h $*
doskey du=du -h $*
doskey e.=explorer .
doskey egrep=egrep --color=auto $*
doskey fgrep=fgrep --color=auto $*
doskey grep=grep --color=auto $*
doskey history=cat "%WSH_ROOT%\config\clink\.history"
doskey pwd=cd
doskey unalias=alias /d $1
doskey vi=vim $*
  
:: Source custom_aliases.cmd if it exists
if "%CUSTOM_ALIASES%" == "" (
  set CUSTOM_ALIASES="%WSH_ROOT%\config\cmd\custom_aliases.cmd"
)
if not exist "%CUSTOM_ALIASES%" ( 
  echo ;= rem ----------------------------------------------------------------------------- >> "%CUSTOM_ALIASES%"
  echo ;= rem @author       Kenrick JORUS >> "%CUSTOM_ALIASES%"
  echo ;= rem @copyright    2022 Kenrick JORUS >> "%CUSTOM_ALIASES%"
  echo ;= rem @license      MIT License >> "%CUSTOM_ALIASES%"
  echo ;= rem @link         http://kenijo.github.io/WSH/ >> "%CUSTOM_ALIASES%"
  echo ;= rem @description  Define your own aliases for CMD >> "%CUSTOM_ALIASES%"
  echo ;= rem ----------------------------------------------------------------------------- >> "%CUSTOM_ALIASES%"
)
doskey /macrofile="%CUSTOM_ALIASES%"

:: Source custom_commands.cmd if it exists
if "%CUSTOM_COMMANDS%" == "" (
  set CUSTOM_COMMANDS="%WSH_ROOT%\config\cmd\custom_commands.cmd"
)
if not exist "%CUSTOM_COMMANDS%" ( 
  echo ::----------------------------------------------------------------------------- >> "%CUSTOM_COMMANDS%"
  echo :: @author       Kenrick JORUS >> "%CUSTOM_COMMANDS%"
  echo :: @copyright    2022 Kenrick JORUS >> "%CUSTOM_COMMANDS%"
  echo :: @license      MIT License >> "%CUSTOM_COMMANDS%"
  echo :: @link         http://kenijo.github.io/WSH/ >> "%CUSTOM_COMMANDS%"
  echo :: @description  Define your own custom commands for CMD >> "%CUSTOM_COMMANDS%"
  echo ::----------------------------------------------------------------------------- >> "%CUSTOM_COMMANDS%"
)
call "%CUSTOM_COMMANDS%"

:: Inject clink
"%WSH_ROOT%\modules\clink\clink.bat" inject --nolog --quiet --profile "%WSH_ROOT%\config\clink"

exit /b
