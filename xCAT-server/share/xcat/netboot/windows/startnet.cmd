@echo off
echo Initializing, please wait.
wpeinit
ping -n 60 127.0.0.1 > NUL 2>&1
md \temp
for /f "delims=: tokens=2" %%c in ('ipconfig /all ^|find "DHCP Server"') do set XCATD=%%c
for /f %%c in ('echo %XCATD%') do set XCATD=%%c
net use i: \\%XCATD%\install
for /f "delims=: tokens=2" %%c in ('ipconfig ^|find "IPv4 Address. . ."') do set NODEIP=%%c
for /f %%c in ('echo %NODEIP%') do set NODEIP=%%c
copy i:\autoinst\%NODEIP%.cmd x:\xcat\autoscript.cmd
call x:\xcat\autoscript.cmd
wpeutil reboot
