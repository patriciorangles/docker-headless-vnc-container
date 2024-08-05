#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation and update the system"
apt-get update
apt-get upgrade -y
apt-get install -y vim wget net-tools locales bzip2 procps sudo aptitude \
    nautilus gedit terminator less htop nano\
    python3-numpy #used for websockify/novnc
apt-get clean -y

echo "generate locales für en_US.UTF-8"
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
