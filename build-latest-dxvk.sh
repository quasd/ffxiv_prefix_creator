#!/bin/bash
. /home/$USER/bin/ffxiv-env-setup.sh
cd /home/$USER/build/dxvk
#export LUTRIS_VERSION="lutris-fshack-6.21-3-x86_64"
#export WINEDIR="/home/eki/.local/share/lutris/runners/wine/$LUTRIS_VERSION/bin"
#export WINE="/home/eki/.local/share/lutris/runners/wine/$LUTRIS_VERSION/bin/wine"	
rm -rf dxvk-master
git pull
git checkout master
#git checkout v1.9.4
./package-release.sh master ./ --no-package
#/home/eki/build/dxvk/dxvk-master/setup_dxvk.sh install

