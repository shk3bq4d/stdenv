@echo off
set mr_debug=0
set mr_file=%tmp%\%~n0%random%%time:~9,2%.bat
set mr=
if "%mr_debug%"=="1" (
	echo mr_file %mr_file%
	echo %~dpn0_0.js %*
	echo.
	echo js start
	cscript //Nologo "%~dpn0_0.wsf" %* | tee.exe %mr_file%
) else (
	cscript //Nologo "%~dpn0_0.wsf" %* >%mr_file%
)
if errorlevel 1 (
	if "%mr_debug%"=="1" (
		echo js end with error level %errorlevel%
		echo.
		echo don't execute mr_file as it contains debug from mr_0.js
		goto end
	)
	::type %mr_file%
	call %mr_file%
	goto end
)
echo js end with error level %errorlevel%
echo.
if "%mr_debug%"=="1" goto end
type %mr_file%

:end
del %mr_file% >NUL 2>&1
set mr_file=
set mr=
