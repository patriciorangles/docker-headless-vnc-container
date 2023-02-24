#!/bin/bash
# Instalacion de postgres
apt-get install software-properties-common apt-transport-https wget -y
wget -O- https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /usr/share/keyrings/postgresql.gpg
echo deb [arch=amd64,arm64,ppc64el signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main | sudo tee /etc/apt/sources.list.d/postgresql.list
apt-get update && apt-get install postgresql -y