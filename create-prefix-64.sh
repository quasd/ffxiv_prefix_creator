#!/bin/bash
set -eu
# Include vars from env file
. ./ffxiv-env-setup.sh

# Executable paths
shared_ff14_path="$shared_data_path/FINAL FANTASY XIV - A Realm Reborn"
shared_act_path="$shared_data_path/ACT_executable"
shared_launcher_path="$shared_data_path/XIVLauncher_executable"
shared_TexTools_path="$shared_data_path/FFXIV TexTools"
shared_anamnesis_path="$shared_data_path/anamnesis"

# Appdata/Setting paths
shared_act_settings_path="$shared_data_path/ACT_appdata_roaming"
shared_launcher_settings_path="$shared_data_path/XIVLauncher_appdata_roaming"


if [ ! -f "$shared_ff14_path/boot/ffxivboot.exe" ]; then
	echo "$shared_ff14_path/boot/ffxivboot.exe not found, check your files/paths"
	exit 1
fi

if [ ! -f "$shared_launcher_path/Update.exe" ]; then
	#echo "$shared_launcher_path/Update.exe not found."
	if [ ! -f "$shared_data_path/Setup.exe" ]; then
		wget -P "$shared_data_path" -q "https://github.com/goatcorp/FFXIVQuickLauncher/releases/download/6.2.40/Setup.exe"
	fi
fi


if [ ! -f "$shared_act_path/Advanced Combat Tracker.exe" ]; then
	echo "$shared_act_path/Advanced Combat Tracker.exe not found, installing it."
	if [ ! -f "$shared_data_path/ACTv3.zip" ]; then
		wget -O "$shared_data_path/ACTv3.zip" -q https://advancedcombattracker.com/download.php?id=57
	fi
	unzip "$shared_data_path/ACTv3.zip" -d "$shared_act_path"
fi

if [ ! -f "$shared_TexTools_path/FFXIV_TexTools.exe" ]; then
	echo "$shared_TexTools_path/FFXIV_TexTools.exe not found, installing it."
	texTools_version="v2.3.7.8"
	if [ ! -f "$shared_data_path/FFXIV_TexTools_$texTools_version.zip" ]; then
		wget -P "$shared_data_path" -q "https://github.com/TexTools/FFXIV_TexTools_UI/releases/download/$texTools_version/FFXIV_TexTools_$texTools_version.zip"
	fi
	unzip "$shared_data_path/FFXIV_TexTools_$texTools_version.zip" -d "$shared_TexTools_path"
fi


if [ ! -f "$shared_anamnesis_path/Anamnesis.exe" ]; then
	echo "$shared_anamnesis_path/Anamnesis.exe"
	anamnesis_version="2022-07-13"
	if [ ! -f "$shared_data_path/$anamnesis_version.zip" ]; then
		wget -P "$shared_data_path" -q "https://github.com/imchillin/Anamnesis/releases/download/v$anamnesis_version/Anamnesis.zip"
	fi
	unzip "$shared_data_path/Anamnesis.zip" -d "$shared_anamnesis_path"


fi

if [ ! -f "$shared_TexTools_path/dxvk-$dxvk_version.tar.gz" ]; then
	echo "$shared_TexTools_path/dxvk-$dxvk_version.tar.gz, installing it."
	if [ ! -f "$shared_TexTools_path/dxvk-$dxvk_version.tar.gz" ]; then
		wget -O "$shared_data_path/dxvk-$dxvk_version.tar.gz" -q "https://github.com/doitsujin/dxvk/releases/download/v$dxvk_version/dxvk-$dxvk_version.tar.gz"
	fi
	tar xzvf "$shared_data_path/dxvk-$dxvk_version.tar.gz" -C "$shared_data_path"
fi

if [ ! -d "$shared_act_settings_path" ]; then 
	echo "$shared_act_settings_path not found, creating empty folder for it."
	mkdir -p "$shared_act_settings_path"
fi

if [ ! -d "$shared_launcher_settings_path" ]; then 
	echo "$shared_launcher_settings_path not found, creating empty folder for it."
	mkdir -p "$shared_launcher_settings_path"
fi
windows_runtime_5="windowsdesktop-runtime-5.0.17-win-x64.exe"
windows_runtime_6="windowsdesktop-runtime-6.0.6-win-x64.exe"

if [ ! -f "$shared_data_path/$windows_runtime_5" ]; then
	echo "Download the 'Windows Desktop Runtime' $windows_runtime_5 from https://versionsof.net/core/5.0/ and place it in $shared_data_path/$windows_runtime_5"
	exit 1
fi

if [ ! -f "$shared_data_path/$windows_runtime_6" ]; then 
	echo "Download the 'Windows Desktop Runtime' $windows_runtime_6 from https://versionsof.net/core/6.0/ and place it in $shared_data_path/$windows_runtime_6"
	exit 1
fi
#-------------------------------------------------------------------------------------#
#                          Echo out paths we are using wine from                              #
#-------------------------------------------------------------------------------------#
echo "----------------------------------"
which wine
which winetricks
echo "Prefix:$WINEPREFIX"
echo "-----------------------------------------"
echo "Executable paths"
echo "-----------------------------------------"
echo "shared_ff14_path: $shared_ff14_path"
echo "shared_act_path: $shared_act_path"
echo "shared_launcher_path: $shared_launcher_path"
echo "shared_TexTools_path: $shared_TexTools_path"
echo "-----------------------------------------"
echo "Appdata/Setting paths"
echo "-----------------------------------------"
echo "shared_act_settings_path: $shared_act_settings_path"
echo "shared_launcher_settings_path: $shared_launcher_settings_path"
echo "-----------------------------------------"
read -p "Are you sure? y/n :" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
	#-------------------------------------------------------------------------------------#
	#                                    Create all folders needed                                  #
	#-------------------------------------------------------------------------------------#
	mkdir -p "$WINEPREFIX/drive_c/Program Files/"
	mkdir -p "$WINEPREFIX/drive_c/Program Files (x86)/SquareEnix/"
	mkdir -p "$WINEPREFIX/drive_c/users/$USER/AppData/Local"
	if [ ! -z "${PROTON_PATH+x}" ]; then
		mkdir -p "$WINEPREFIX/drive_c/users/steamuser/"
		mkdir -p "$WINEPREFIX/drive_c/users/steamuser/AppData/Roaming/"
	else 
		mkdir -p "$WINEPREFIX/drive_c/users/$USER/"
		mkdir -p "$WINEPREFIX/drive_c/users/$USER/AppData/Roaming/"
	fi

	set +eu

	#-------------------------------------------------------------------------------------#
	#                   Create symlinks for ff14, act, xivlauncher and texTools                   #
	#-------------------------------------------------------------------------------------#
	mkdir -p "$shared_ff14_path"
	ln -T -s "$shared_ff14_path" "$WINEPREFIX/drive_c/Program Files (x86)/SquareEnix/FINAL FANTASY XIV - A Realm Reborn"
	ln -T -s "$shared_act_path" "$WINEPREFIX/drive_c/Advanced Combat Tracker"
	mkdir -p "$shared_launcher_path"
	ln -T -s "$shared_launcher_path" "$WINEPREFIX/drive_c/users/$USER/AppData/Local/XIVLauncher"
	ln -T -s "$shared_TexTools_path" "$WINEPREFIX/drive_c/Program Files/FFXIV TexTools"
	ln -T -s "$shared_anamnesis_path" "$WINEPREFIX/drive_c/anamnesis"

	#-------------------------------------------------------------------------------------#
	#         Symlink Documents fodler to prefix. ( This is where save data for ff14 is stored )  #
	#-------------------------------------------------------------------------------------#
	
	if [ ! -z "${PROTON_PATH+x}" ]; then
		ln -T -s "/home/$USER/Documents/" "$WINEPREFIX/drive_c/users/steamuser/Documents"
	else
		ln -T -s "/home/$USER/Documents/" "$WINEPREFIX/drive_c/users/$USER/Documents"
	fi
	#-------------------------------------------------------------------------------------#

	#-------------------------------------------------------------------------------------#
	#                  Symlink act/launcher settings folders to prefix                            #
	#-------------------------------------------------------------------------------------#
	if [ ! -z "${PROTON_PATH+x}" ]; then
		ln -T -s "$shared_act_settings_path" "$WINEPREFIX/drive_c/users/steamuser/AppData/Roaming/Advanced Combat Tracker"
		ln -T -s "$shared_launcher_settings_path" "$WINEPREFIX/drive_c/users/steamuser/AppData/Roaming/XIVLauncher"
	else
		ln -T -s "$shared_act_settings_path" "$WINEPREFIX/drive_c/users/$USER/AppData/Roaming/Advanced Combat Tracker"
		ln -T -s "$shared_launcher_settings_path" "$WINEPREFIX/drive_c/users/$USER/AppData/Roaming/XIVLauncher"
	fi
	#-------------------------------------------------------------------------------------#

	set -eu
	#-------------------------------------------------------------------------------------#
	#                            Initialize prefix                                                #
	#-------------------------------------------------------------------------------------#
	read -p "Start install y/n :" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Starting"
	else
		exit 1
	fi
	if [ ! -z "${LUTRIS_PATH+x}" ];then
		echo "Initialize with lutris wine"
		which wineboot
		wineboot --init
	elif [ ! -z "${PROTON_PATH+x}" ]; then
		echo "Initialize with proton wine"
		wine64 /usr/share/steam/compatibilitytools.d/proton-ge-custom/files/lib64/wine/x86_64-windows/wineboot.exe --init
	else
		echo "Initialize with system wine"
		#wineboot --init
	fi
	#-------------------------------------------------------------------------------------#
	#                             Ensure mono not installed                                       #
	#-------------------------------------------------------------------------------------#
	wine uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}'
	wine64 uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}'
	#-------------------------------------------------------------------------------------#
	#               install dependencies and set os to win10                                      #
	#-------------------------------------------------------------------------------------#
	winetricks -q -f dotnet48
	wineserver -k
	winetricks -q vcrun2019 d3dcompiler_47
	wineserver -k
	winetricks win10

	wine "$shared_data_path/$windows_runtime_5" /q
	wine "$shared_data_path/$windows_runtime_6" /q
	#-------------------------------------------------------------------------------------#
	#         Allow act/anamnesis capture network traffic/read processes                          #
	#-------------------------------------------------------------------------------------#
	echo "Editing $WINEDIR/wine"
	sudo setcap cap_net_raw,cap_net_admin,cap_sys_ptrace=eip "$WINEDIR/wine"
	echo "Editing $WINEDIR/wine64"
	sudo setcap cap_net_raw,cap_net_admin,cap_sys_ptrace=eip "$WINEDIR/wine64"
	echo "Editing $WINEDIR/wineserver"
	sudo setcap cap_net_raw,cap_net_admin,cap_sys_ptrace=eip "$WINEDIR/wineserver"

	echo "Installing DXVK"
	cp setup_dxvk.sh "$shared_data_path/dxvk-$dxvk_version/setup_dxvk.sh"
	"$shared_data_path/dxvk-$dxvk_version/setup_dxvk.sh" install

	if [ -f "$shared_launcher_path/XIVLauncher.exe" ]; then
		export xivlauncher="$WINEPREFIX/drive_c/users/$USER/AppData/Local/XIVLauncher/XIVLauncher.exe"
		wine64 "$xivlauncher"
	else
		echo "Launching FFXIVQuickLauncher installer"
		echo "REMEBER TO SET DALAMUD TO LEGACY MODE"
		wine "$shared_data_path/Setup.exe"
	fi
else
	echo "Doing nothing"
fi