#!/bin/bash

cd "$(dirname "$0")"
. ./ffxiv-env-setup.sh

cd $WINEPREFIX
if [ -n "$1" ]  && [ "$1" == "org" ]; then
	export xivlauncher="$WINEPREFIX/drive_c/Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn/boot/ffxivboot.exe"
else
	export xivlauncher="$WINEPREFIX/drive_c/users/$USER/AppData/Local/XIVLauncher/XIVLauncher.exe"
fi
export actlauncher="$ACTFOLDER/Advanced Combat Tracker.exe"

echo "Running: $WINE $xivlauncher"
${WINE}64 "$xivlauncher"

echo "Running $actlauncher"
${WINE}64 "$actlauncher"

