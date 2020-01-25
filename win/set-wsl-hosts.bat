@echo off
set host_file=C:\Windows\System32\drivers\etc\hosts
set host_name=wsl.internal
type %host_file% | findstr /V %host_name% > %host_file%
for /f "delims=" %%i in ('wsl -e bash /home/yi/show_ip.sh') do (echo %%i %host_name% >> %host_file%)