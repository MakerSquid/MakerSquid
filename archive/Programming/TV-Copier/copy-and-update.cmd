@echo off
rem copy the file(s)

N:\TV-Copier.exe %1 %2 %3 %4

rem update metadata
c:
cd \pytivo
c:\python27\python.exe .\pyTivoMetaThis-0.30.py -r  g:\shares\tv\
c:\Python27\python.exe .\pyTivoMetaThis-0.30.py -r g:\shares\tv-kids
cls
exit

