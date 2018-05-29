@echo off
setlocal enabledelayedexpansion
:Check
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    goto NotAdmin
) else ( goto Install )

:NotAdmin
echo Please run this script as Administrator
goto Quit

:Install
set PackageName=sequelize-auto
set CheckFile=check_%PackageName%

echo preper to install sequelize-auto...
set /p="check if sequelize-auto has installed? "<nul
2>nul npm ls sequelize-auto -g | findstr sequelize-auto > %CheckFile%
set /p IS_INSTALLED_SEQ=<%CheckFile%
if "%IS_INSTALLED_SEQ%"=="" (
    echo Not installed.
    >nul npm install sequelize-auto -g
    if '%errorlevel%' NEQ '0' goto InstallFail
) else ( echo Has installed.)
if exist "%CheckFile%" del %CheckFile%

set PackageName=mysql
set /p="check if mysql has installed?"<nul
2>nul npm ls mysql -g | findstr mysql > %CheckFile%
set /p IS_INSTALLED_MYSQL=<%CheckFile%
if "%IS_INSTALLED_MYSQL%"=="" (
    echo Not installed.
    >nul 2>&1 npm install mysql -g
    if '%errorlevel%' NEQ '0' goto InstallFail
) else ( echo Has installed. )
if exist "%CheckFile%" del %CheckFile%
goto RunSequelize

:RunSequelize
echo Load connection arguments.
CD /D "%~dp0"
if exist "connection_env.bat" ( call "connection_env.bat" ) else ( echo Can't find connection_env.bat )

echo running sequelize-auto.
sequelize-auto --database %DATABASE% --host %HOST% --user %USERNAME% --port %PORT% --pass %PASSWORD%  ^
    --camel --dialect mysql --output %OUTPUT%
goto Quit

:InstallFail
echo fail to install %PackageName%.
goto Quit

:Quit
SET /p="press any key to quit."
exit /b