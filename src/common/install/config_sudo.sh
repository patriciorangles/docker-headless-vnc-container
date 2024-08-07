#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

USER_ID=$1
HOME=$2

echo "Configure sudo for user with ID: $USER_ID, Home directory: $HOME"

# Get the username associated with the provided user ID
USER_NAME=$(getent passwd "$USER_ID" | cut -d: -f1)

if [ -z "$USER_NAME" ]; then
    echo "No user found with ID: $USER_ID"
    exit 1
fi

echo "User name found: $USER_NAME"

# Check if user already exists
if id "$USER_NAME" &>/dev/null; then
    echo "User $USER_NAME already exists."
else
    # create user
    adduser --home "$HOME" --disabled-password --gecos '' "$USER_NAME"
fi

# add user to group sudo
adduser "$USER_NAME" sudo
# add permissions to sudoers file
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Se modifica el shell del usuario, suele venir sin un shell valido
echo "Modificando el shell del User ID: $USER_ID"
usermod -s /bin/bash $(getent passwd $USER_ID | cut -d: -f1)