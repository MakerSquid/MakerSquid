@echo off
cls
git status
git add *
git commit -m"changes"
git push
git status
pause
exit
