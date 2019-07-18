@ECHO OFF

COPY /Y portsetter.exe \\smartweb01\smartweb1\Configs\Configurator.exe 
COPY /Y portsetter.exe \\smartweb01\smartweb2\Configs\Configurator.exe
COPY /Y portsetter.exe \\smartweb01\smartweb3\Configs\Configurator.exe
COPY /Y portsetter.exe \\smartweb01\smartweb4\Configs\Configurator.exe
COPY /Y portsetter.exe \\smartweb01\smartweb5\Configs\Configurator.exe
COPY /Y portsetter.exe \\smartweb01\smartweb6\Configs\Configurator.exe

PAUSE
CLS
EXIT