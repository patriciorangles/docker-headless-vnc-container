#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation and update the system"
apt-get update
apt-get upgrade -y
apt-get install -y vim wget net-tools locales bzip2 procps sudo aptitude \
    nautilus gedit terminator less htop nano \
    openssh-client \
    python3-numpy #used for websockify/novnc
apt-get clean -y

# Manejamos español para este contenedor
echo "generate locales para es_ES.UTF-8"
echo "es_ES.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
