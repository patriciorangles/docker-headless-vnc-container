#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Installing ttf-wqy-zenhei"
apt-get install -y --no-install-recommends ttf-wqy-zenhei
apt-get clean -y
