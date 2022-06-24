#!/bin/bash

cd "$(dirname "$0")"
. ffxiv-env-setup.sh

export xivlauncher="$WINEPREFIX/drive_c/Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn/boot/ffxivboot.exe"
export actlauncher="$ACTFOLDER/Advanced Combat Tracker.exe"

echo "Running: $WINE $xivlauncher"
${WINE}64 "$xivlauncher"

echo "Running $actlauncher"
${WINE}64 "$actlauncher"

