::------------------------------------------------------------------------------
:: @link            http://kenijo.github.io/WSH/
:: @description     Script to manage aliases
:: @license         MIT License
::------------------------------------------------------------------------------

@echo off

if "%ALIASES%" == "" (
  set ALIASES="%WSH_CLINK%\custom_aliases"
)

setlocal enabledelayedexpansion

if "%~1" == "" echo Use /? for help & echo. & goto :p_show

:: check command usage

rem #region parseargument
goto parseargument

:do_shift
  shift

:parseargument
  set currentarg=%~1

  if /i "%currentarg%" equ "/f" (
    set ALIASES=%~2
    shift
    goto :do_shift
  ) else if /i "%currentarg%" == "/reload" (
    goto :p_reload
  ) else if "%currentarg%" equ "/H" (
    goto :p_help
  ) else if "%currentarg%" equ "/h" (
    goto :p_help
  ) else if "%currentarg%" equ "/?" (
    goto :p_help
  ) else if /i "%currentarg%" equ "/d" (
    if "%~2" neq "" (
      if "%~3" equ "" (
        :: /d flag for delete existing alias
        call :p_del %~2
        shift
        goto :eof
      )
    )
  ) else if "%currentarg%" neq "" (
    if "%~2" equ "" (
      :: Show the specified alias
      doskey /macros | findstr /b %currentarg%= && exit /b
      echo insufficient parameters.
      goto :p_help
    ) else (
      :: handle quotes within command definition, e.g. quoted long file names
      set _x=%*
    )
  )
rem #endregion parseargument

if not exist "%ALIASES%" (
  echo ;= rem ------------------------------------------------------------------------- >> "%ALIASES%"
  echo ;= rem ------------------------------------------------------------------------- >> "%ALIASES%"
  echo ;= rem  @link            http://kenijo.github.io/WSH/ >> "%ALIASES%"
  echo ;= rem  @description     Script to manage aliases >> "%ALIASES%"
  echo ;= rem  @license         MIT License >> "%ALIASES%"
  echo ;= rem ------------------------------------------------------------------------- >> "%ALIASES%"
)

:: validate alias
for /f "delims== tokens=1,* usebackq" %%G in (`echo "%_x%"`) do (
  set alias_name=%%G
  set alias_value=%%H
)

:: leading quotes added while validating
set alias_name=%alias_name:~1%

:: trailing quotes added while validating
set alias_value=%alias_value:~0,-1%

::remove spaces
set _temp=%alias_name: =%

if not ["%_temp%"] == ["%alias_name%"] (
  echo Your alias name can not contain a space
  endlocal
  exit /b
)

:: replace already defined alias
findstr /b /l /v /i "%alias_name%=" "%ALIASES%" >> "%ALIASES%.tmp"
echo %alias_name%=%alias_value% >> "%ALIASES%.tmp" && type "%ALIASES%.tmp" > "%ALIASES%" & @del /f /q "%ALIASES%.tmp"
doskey /macrofile="%ALIASES%"
endlocal
exit /b

:p_del
set del_alias=%~1
findstr /b /l /v /i "%del_alias%=" "%ALIASES%" >> "%ALIASES%.tmp"
type "%ALIASES%".tmp > "%ALIASES%" & @del /f /q "%ALIASES%.tmp"
doskey %del_alias%=
doskey /macrofile="%ALIASES%"
goto:eof

:p_reload
doskey /macrofile="%ALIASES%"
echo Aliases reloaded
exit /b

:p_show
doskey /macros | findstr /v /r "^;=" | sort
exit /b

:p_help
echo.Usage:
echo.
echo.  alias [options] [alias=alias command]
echo.
echo.Options:
echo.
echo.  Note: Options MUST precede the alias definition.
echo.
echo.  /d [alias]     Delete an [alias].
echo.  /f [macrofile] Path to the [macrofile] you want to store the new alias in.
echo.                 Default: %ALIASES%
echo.  /reload        Reload the aliases file.  Can be used with /f argument.
echo.                 Default: %ALIASES%
echo.
echo. If alias is called with no parameters, it will display the list of existing
echo. aliases.
echo.
echo. In the alias command, you can use the following notations:
echo.
echo. ^^^^^^^^%% - %% signs in env vars must be escaped if preserving the variable
echo.         in he alias is desired. Variables in aliases surrounded by double
echo.         quotes only require '^^%%' vs '^^^^^^^^%%'
echo. $*    - allows the alias to assume all the parameters of the supplied
echo.         command.
echo. $1-$9 - Allows you to separate parameter by number, much like %%1 in
echo.         batch.
echo. $T    - Command separator, allowing you to string several commands
echo.         together into one alias.
echo.
echo. For more information, read DOSKEY /?
exit /b
