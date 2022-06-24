#!/bin/bash

cd "$(dirname "$0")"
. ffxiv-env-setup.sh

export WINEDLLOVERRIDES="d3d9,dxgi,dxgi.dll=b"
wine64 "$WINEPREFIX/drive_c/anamnesis/Anamnesis.exe"
