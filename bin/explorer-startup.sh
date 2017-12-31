#!/usr/bin/env bash

#set -o posix 
#set | grep -i appd
set -eux

cd "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup"
explorer.exe  .
