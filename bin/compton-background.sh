#!/usr/bin/env bash

f=~/.config/i3/compton.conf
if [[ ! -f $f ]]; then
	cd $(stdhome-dirname.sh)
	cd .config
	cd i3
	stdhome-install-onefile.sh compton.conf
fi
compton -b --dbus --config $f
echo true > ~/.tmp/compton-enabled
