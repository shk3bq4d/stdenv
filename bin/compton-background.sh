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
$WORK_PC1F)
    extra="
        --shadow-exclude-reg x32+0-0
        --shadow-radius=12
        --shadow-offset-x=-18
        --shadow-offset-y=-18
        "
    ;;
*)
    extra="
        --shadow-exclude-reg x39+0+0
        --shadow-radius=12
        --shadow-offset-x=-18
        --shadow-offset-y=-18
        "
    ;;
esac
logfile=$HOME/.tmp/log/compton.log
{ while :; do echo "$(date) rumo startup" >> $logfile; compton --dbus --config $f </dev/null >> $logfile 2>&1 || echo "$(date) exited with error $?"; sleep 5; done  } &
sleep 2
#compton -b --dbus $extra --experimental-backends --config $f
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
