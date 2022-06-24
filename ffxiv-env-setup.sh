#!/bin/bash

#-------------------------------------------------------------------------------------#
#                                          PATHS                                              #
#-------------------------------------------------------------------------------------#
export WINEPREFIX="/home/$USER/games/ff14_reinstall_v10"
#export WINEPREFIX="/home/$USER/games/ff14_reinstall_v10"
export shared_data_path="/home/$USER/games/ff14_data2"
#-------------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------------#
#                                          DXVK/graphic setings                               #
#-------------------------------------------------------------------------------------#
export dxvk_version="1.10.1"
export DXVK=1
export WINEFSYNC=1
export DXVK_HUD=fps,frametimes,gpuload,version
export DXVK_LOG_LEVEL="none"
#-------------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------------#
#                            Wine verobisty and dlloverrides                                   #
#-------------------------------------------------------------------------------------#
export WINEDEBUG=-all
#export WINEDEBUG=warn+all
#export WINEDLLOVERRIDES="mscoree=n,d3d10core=n,d3d11=n,d3d12=n,d3d9=n,dxgi=n,dssenh=n" #  ,ntdll=n
export WINEARCH=win64
#-------------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------------#
#      Select one from below, if all are commented out, system wine will be used              #
#-------------------------------------------------------------------------------------#
export ACTFOLDER="$WINEPREFIX/drive_c/Advanced Combat Tracker"
export LUTRIS_PATH="/home/$USER/.local/share/lutris/runners/wine/lutris-fshack-7.2-x86_64"
#export LUTRIS_PATH="/home/$USER/.local/share/lutris/runners/wine/wine-7.11-staging-amd64"
#export PROTON_PATH="/usr/share/steam/compatibilitytools.d/proton/dist/"
#export PROTON_PATH="/usr/share/steam/compatibilitytools.d/proton-ge-custom"
#export LUTRIS_PATH="SYSTEM"
#-------------------------------------------------------------------------------------#
if [ ! -z "${LUTRIS_PATH+x}" ]; then
	if [ ! -f "$LUTRIS_PATH" ]; then
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


