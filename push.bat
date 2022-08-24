@echo off
set d=%date:~0,1000%
set t=%time:~0,8%
set timestamp=%d% %t%
 
set /p comments=please input commit comments:
echo [%timestamp%] commit: %comments% >> history.txt

git push
git log --stat -1
echo "Finished Push!"
pause