#!/bin/bash
startDir=$(dirname "$0" | xargs readlink -f)
echo "StarDir:$startDir"
cd "$startDir"
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

kill $(ps aux |grep electron |grep overlay | awk '{print $2}') 2> /dev/null
kill $(ps aux |grep "Advanced Combat Tracker.exe" | awk '{print $2}') 2> /dev/null

echo "Running $actlauncher"
wine64 "$actlauncher"&

sleep 15

cd "$startDir"
if [ "$enable_kagerou" == "yes" ]; then
	electron ./ --overlay=kagerou&
fi
if [ "$enable_killcount" == "yes" ]; then
	electron ./ --overlay=counter&
fi

if [ "$enable_gnome_window_moving" == "yes" ]; then
	sleep 15
	if [ "$enable_kagerou" == "yes" ]; then
		gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/MoveResize --method org.gnome.Shell.Extensions.MoveResize.Call "'kagerou overlay'" 1 0 150 400 400
	fi
	if [ "$enable_killcount" == "yes" ]; then
		gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/MoveResize --method org.gnome.Shell.Extensions.MoveResize.Call "'FFXIV Kill Counter'" 1 0 550 400 400
	fi
fi
