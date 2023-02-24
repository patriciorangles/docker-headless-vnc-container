#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

USER_NAME=$1
HOME=$2

echo "Configure sudo for user: $USER_NAME, Home directory: $HOME"

# create user
adduser --home $HOME --disabled-password --gecos '' $USER_NAME
# add user to group sudo
adduser $USER_NAME sudo
# add permisions to sudoers file
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

