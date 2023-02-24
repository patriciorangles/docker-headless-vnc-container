#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update
# python3-numpy used for websockify/novnc
# sudo used for configure sudo in user
apt-get install -y vim wget net-tools locales bzip2 procps \
    python3-numpy \
    sudo
apt-get clean -y

echo "generate locales für en_US.UTF-8"
locale-gen en_US.UTF-8
