@echo off
set d=%date:~0,10%
set t=%time:~0,8%
set timestamp=%d% %t%
git status
set/p a=ȷ��ִ�����͵�Զ����(y/n)
if %a% == y (
	git push
	echo At [%timestamp%] Push. >> history.txt
)

git log --stat -1
echo "Finished Push!"
pause