@echo off
setlocal
pushd .
set dir=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
if not exist "%dir%" goto winxp
cd /d %dir%
call explorer.bat
goto end

:winxp
set mr_err=
cd /d %userprofile%
cd *menu*
cd *program*
cd startup
call "%~dp0run.bat" explorer.exe .
echo ha
set mr_err=

goto end

:end
popd
