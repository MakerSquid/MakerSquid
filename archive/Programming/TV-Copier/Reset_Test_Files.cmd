@echo off

rmdir .\Target /s /q
rmdir .\Source /s /q

mkdir .\Target
mkdir .\Source 

xcopy ..\..\Reset_Test_Files\Source\*.* .\Source\*.* /e
xcopy ..\..\Reset_Test_Files\Target\*.* .\Target\*.* /e

exit
