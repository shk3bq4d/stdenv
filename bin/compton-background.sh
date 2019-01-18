#!/usr/bin/env bash

pkill compton || true
f=~/.config/i3/compton.conf
if [[ ! -f $f ]]; then
    cd $(stdhome-dirname.sh)
    cd .config
    cd i3
    stdhome-install-onefile.sh compton.conf
fi
case $HOSTNAMEF in \
dec17.ly.lan)
    extra="
        --shadow-exclude-reg x20+0+0
        --shadow-radius=6
        --shadow-offset-x=-9
        --shadow-offset-y=-9
        "
    ;;
*)
    extra="
        --shadow-exclude-reg x24+0+0
        --shadow-radius=12
        --shadow-offset-x=-18
        --shadow-offset-y=-18
        "
    ;;
esac
compton -b --dbus $extra --config $f
echo true > ~/.tmp/compton-enabled
xwininfo -root -tree \
  | sed -n 's/^ *    \(0x[[:xdigit:]]*\).*/\1/p' \
  | while IFS=$'\n' read wid; do
    if xprop -id "$wid" | grep  -qE ^_NET_WM_WINDOW_OPACITY; then
        xprop -id "$wid" \
            -remove _NET_WM_WINDOW_OPACITY
        xdotool windowminimize $wid
    fi
  done
