#!/bin/bash

# Instalacion de extensiones para VSCode
echo "Instalamos las extensiones de VSCode"
echo "ms-ceintl.vscode-language-pack-es"
code --install-extension ms-ceintl.vscode-language-pack-es #Idioma ES
echo "ms-python.vscode-pylance"
code --install-extension ms-python.vscode-pylance #Manejo de python
echo "ms-python.python"
code --install-extension ms-python.python #Manejo de python
echo "ms-python.debugpy"
code --install-extension ms-python.debugpy #Depuracion de python

