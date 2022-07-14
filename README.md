# ffxiv_prefix_creator

Something I put together to allow me to quickly move between different wine/proton versions or recover from borked prefix. 

Some bits based on https://github.com/valarnin/ffxiv-tools/tree/lutris-xivlauncher
Modified setup_dxvk.sh from https://github.com/doitsujin/dxvk

Gnome extension by orzun https://gist.github.com/tuberry/dc651e69d9b7044359d25f1493ee0b39
changed to work by application window name instead of wmclass


# Dependencies

- winetricks (If you run in to any problems with winetricks please run sudo winetricks --self-update )
- lutris
  - with specified wine runner ( can be change with LUTRIS_PATH )

# Usage

```
git clone git@github.com:quasd/ffxiv_prefix_creator.git
cd ffxiv_prefix_creator
cp settings.sh.example settings.sh
vim settings.sh
```
- Update vars.
	- WINEPREFIX 
		- Path should not exist before running these scripts.
	- shared_data_path
		- Copy/link your "FINAL FANTASY XIV - A Realm Reborn" game folder to this path

- run ( will take few minutes )
YOU MUST SET DALAMUD TO LEGACY MODE IN xivlauncher when it launches!
```
./create-prefix-64.sh
```

- Launch the game with ACT
```
./ffxiv-run-both.sh
```

- Launch the orginal launcher
```
./ffxiv-run-both.sh org
```

- Launch texttools
```
./ffxiv-run-texttools.sh
```