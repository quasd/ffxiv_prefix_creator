#!/bin/bash
cd "$(dirname "$0")"
. ./settings.sh
if [ ! -z "${LUTRIS_PATH+x}" ]; then
	if [ ! -d "$LUTRIS_PATH" ]; then
		echo "First install relevant runner from lutris for $LUTRIS_PATH"
		exit 1
	fi
fi
if [ ! -z "${LUTRIS_PATH+x}" ];then
	if [ "$LUTRIS_PATH" == "SYSTEM" ]; then 
		echo "USING SYSTEM WINE"
		export WINEDIR="/usr/bin"
		export WINE="/usr/bin/wine"
	else
		echo "USING LUTRIS WINE"
		export WINEDIR="$LUTRIS_PATH/bin"
		export WINE="$LUTRIS_PATH/bin/wine"
		export PATH="$LUTRIS_PATH/bin:$PATH"
	fi
elif [ ! -z "${PROTON_PATH+x}" ]; then
	echo "USING PROTON WINE"
	export WINEDIR="$PROTON_PATH/bin"
	export WINE="$PROTON_PATH/bin/wine"
	export PATH="$PROTON_PATH/bin:$PATH"
else
	echo "SOMETHING WRONG"
	exit 1
fi


