#!/bin/bash
cd "$(dirname "$0")"
. ffxiv-env-setup.sh

${WINE}64 "$ACTFOLDER/Advanced Combat Tracker.exe"
