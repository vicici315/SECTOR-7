@echo off

git status
set/p a=ȷ��ִ�����͵�Զ����(y/n)
if %a% == y git push

git log --stat -1
echo [%timestamp%] comments: %comments% >> history.txt
echo "Finished Push!"
pause