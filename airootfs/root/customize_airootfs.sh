#!/bin/sh

# This script will be run inside chroot (airootfs)
# customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.

# Files are in airootfs/opt/customize
CUSTOMIZE="/opt/customize"

_yay() {

AUR_PACKAGES=`jq '.aur[]' packages_aur.x86_64`

for package in ${AUR_PACKAGES[@]}
do
  sudo -u $USR -- yay -S --needed --noconfirm $package
done
}

_cp () {
    cp ${CUSTOMIZE}/$1 /root/$1
    cp ${CUSTOMIZE}/$1 /etc/skel/$1
    cp ${CUSTOMIZE}/$1 /home/hypr/$1
}

mkdir -p /root/.config
mkdir -p /etc/skel/.config
mkdir -p /home/hypr/.config

_cp .zshrc
_cp .config/starship.toml


