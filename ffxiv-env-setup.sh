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
	echo "USING SYSTEM WINE"
	export WINEDIR="/usr/bin"
	export WINE="/usr/bin/wine"
	export LD_LIBRARY_PATH="/usr/lib/wineland/lib32"
	#export VK_ICD_FILENAMES="/usr/lib/wineland/vulkan/icd.d/intel_icd.i686.json:/usr/lib/wineland/vulkan/icd.d/radeon_icd.i686.json"
	export WINEESYNC=0
	export WINEFSYNC=0
	export WINE_VK_VULKAN_ONLY=1
	export WINE_VK_VULKAN_ONLY=1
	export WINEDLLOVERRIDES=""
fi


