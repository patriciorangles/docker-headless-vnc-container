#!/bin/bash
#Instalacion de Visual Studio Code

arch_system=$(dpkg --print-architecture)
# Seccion para AMD64
if [ "$arch_system" == "amd64" ]; then
    apt-get update && apt-get install -y apt-transport-https curl gpg
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
    apt-get update && apt-get install -y code libx11-xcb-dev libasound2
# Seccion para ARM64
elif [ "$arch_system" == "arm64" ]; then
    #wget https://az764295.vo.msecnd.net/stable/441438abd1ac652551dbe4d408dfcec8a499b8bf/code_1.75.1-1675892106_arm64.deb \
    #&& apt-get update && apt-get install ./code_1.75.1-1675892106_arm64.deb libx11-xcb-dev libasound2 -f -y
    wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/b1c0a14de1414fcdaa400695b4db1c0799bc3124/code_1.92.0-1722471464_arm64.deb
    && apt-get update && apt-get install ./code_1.92.0-1722471464_arm64.deb libx11-xcb-dev libasound2 -f -y
fi