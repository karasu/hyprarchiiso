#!/bin/sh

# This script will be run inside chroot (airootfs)
# customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.

# Files are in airootfs/opt/customize
CUSTOMIZE="/opt/customize"

USR="hypr"
AUR_PACKAGES=`jq '.aur[]' /opt/customize/packages_aur.x86_64`

install_aur_packages () {
    for package in ${AUR_PACKAGES[@]}
    do
      sudo -u $USR -- yay -S --needed --noconfirm $package
    done
}

copy_customize_files () {
    mkdir -p /root/.config
    mkdir -p /etc/skel/.config
    mkdir -p /home/hypr/.config

    cp -Rv ${CUSTOMIZE}/. /root
    cp -Rv ${CUSTOMIZE}/. /etc/skel
    cp -Rv ${CUSTOMIZE}/. /home/hypr
}

install_aur_packages
copy_customize_files

