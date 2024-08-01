#!/usr/bin/env bash
# agregado manejo de arm64
set -e

VERSION="128.0"
echo "Install Firefox $VERSION"

arch_system=$(dpkg --print-architecture)

function disableUpdate(){
    ff_def="$1/browser/defaults/profile"
    mkdir -p $ff_def
    echo <<EOF_FF
user_pref("app.update.auto", false);
user_pref("app.update.enabled", false);
user_pref("app.update.lastUpdateTime.addon-background-update-timer", 1182011519);
user_pref("app.update.lastUpdateTime.background-update-timer", 1182011519);
user_pref("app.update.lastUpdateTime.blocklist-background-update-timer", 1182010203);
user_pref("app.update.lastUpdateTime.microsummary-generator-update-timer", 1222586145);
user_pref("app.update.lastUpdateTime.search-engine-update-timer", 1182010203);
EOF_FF
    > $ff_def/user.js
}

function instFF() {
    if [ "$arch_system" == "amd64" ]; then
        if [ ! "${1:0:1}" == "" ]; then
            FF_VERS=$1
            if [ ! "${2:0:1}" == "" ]; then
                FF_INST=$2
                echo "download Firefox $FF_VERS and install it to '$FF_INST'."
                mkdir -p "$FF_INST"
                FF_URL=http://releases.mozilla.org/pub/firefox/releases/$FF_VERS/linux-x86_64/es-MX/firefox-$FF_VERS.tar.bz2
                echo "FF_URL: $FF_URL"
                wget -qO- $FF_URL | tar xvj --strip 1 -C $FF_INST/
                ln -s "$FF_INST/firefox" /usr/bin/firefox
                # Enable Update
                #disableUpdate $FF_INST
                exit $?
            fi
        fi
        echo "function parameter are not set correctly please call it like 'instFF [version] [install path]'"
        exit -1
    elif [ "$arch_system" == "arm64" ]; then
        echo "No existe firefox en ARM64, se usa firefox-esr"
        apt-get update && apt-get install -y firefox-esr
    fi
}

instFF "$VERSION" '/usr/lib/firefox'