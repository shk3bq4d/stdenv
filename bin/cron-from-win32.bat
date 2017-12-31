@echo off
set path=%~dp0\..\..\..\..\bin;%~dp0\..\..\..\..\sbin;%~dp0\..\..\..\..\usr\bin;%~dp0\..\..\..\..\usr\sbin
cd %~dp0\..\..\..\..\usr\sbin
echo on
start "title" /low %~dp0\..\..\..\..\usr\sbin\cron.exe
@echo off
echo "cron should have started"
pause
