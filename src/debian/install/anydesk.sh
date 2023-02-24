#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

HOME=$1
echo "Install Anydesk. Home directory:" $HOME

apt-get update && apt-get install -y --no-install-recommends \
wget ca-certificates gnupg2 \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*
wget -O- https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor > /usr/share/keyrings/anydesk-archive-keyring.gpg
printf "deb [signed-by=/usr/share/keyrings/anydesk-archive-keyring.gpg] http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk.list
apt-get update && apt-get install -y --no-install-recommends \
anydesk libpolkit-gobject-1-0 \
locales tzdata \
lsb-release pciutils \
; exit 0 \
&& chmod -R 755 /usr/share/anydesk \
&& chmod 755 /var/lib/dpkg/info/anydesk.p* \
&& dpkg --configure anydesk \
&& apt-get install -f \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

any_dir="$HOME/.anydesk/"
mkdir -p $any_dir
# Permissions for remote access, password: anydeskpassword    
echo <<EOF_FF
ad.security.permission_profiles._default.permissions.audio=1
ad.security.permission_profiles._default.permissions.block_input=1
ad.security.permission_profiles._default.permissions.clipboard=1
ad.security.permission_profiles._default.permissions.clipboard_files=1
ad.security.permission_profiles._default.permissions.file_manager=1
ad.security.permission_profiles._default.permissions.input=1
ad.security.permission_profiles._default.permissions.lock_desk=1
ad.security.permission_profiles._default.permissions.privacy_feature=0
ad.security.permission_profiles._default.permissions.record_session=1
ad.security.permission_profiles._default.permissions.restart=1
ad.security.permission_profiles._default.permissions.sas=1
ad.security.permission_profiles._default.permissions.sysinfo=1
ad.security.permission_profiles._default.permissions.tcp_tunnel=0
ad.security.permission_profiles._default.permissions.user_pointer=1
ad.security.permission_profiles._default.permissions.vpn=1
ad.security.permission_profiles._default.permissions.whiteboard=1
ad.security.permission_profiles._full_access.pwd=0333b36c9d1185f18a5f3bd75307d873d98124bdfd6930d39e657dd8db6baafe
ad.security.permission_profiles._full_access.salt=6c3a53092dc86cfe7bc10a710b9ff315
ad.security.permission_profiles._unattended_access.permissions.sas=1
ad.security.permission_profiles.version=1
EOF_FF
> $any_dir/system.conf
