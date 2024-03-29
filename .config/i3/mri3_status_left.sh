#!/usr/bin/env bash

set -u
set -e
set -o pipefail
LOG=~/.tmp/log/mri3_status_left_i3blocks.log
LOG=/dev/null
date >> $LOG
echo $PATH >> $LOG
case $(hostname -f) in \
apr16.ly.lan|dec17.ly.lan|acer2011.ly.lan|nov20.ly.lan|feb22.ly.lan)
	f=~/.config/i3/i3blocks-$(hostname -f).conf
	test -f "$f" || f=~/.config/i3/i3blocks-default.conf
	i3blocks -c $f |tee -a $LOG
	exit 0
	;;
esac

# Send the header so that i3bar knows we want to use JSON:
echo '{ "version": 1 }'

# Begin the endless array.
echo '['

# We send an empty first array of blocks to make the loop simpler:
echo '[]'

# Now send blocks with information forever:
#while :;
#do
	#echo ",[ {\"name\":\"time\",\"full_text\":\"$(date)\",\"color\":\"#00ff00\"},{\"name\":\"time\",\"full_text\":\"$(date)\",\"color\":\"#0000ff\"} ]"
	#sleep 1
#done
#exit 0

#export LANG=en_US.UTF-8
f=~/.tmp/keyboard-layout
if [[ ! -f $f ]]; then
	bAString=($(setxkbmap -query | grep -E "^layout"))
	cl=${bAString[1]}
	echo $cl > $f
fi

LC_TIME=en_US.utf8 i3status -c ~/.config/i3/.i3status-ol.conf | while :; do
	read line
	kb="$(< $f)"
	case "$kb" in \
	"ch")
		COLOR="#FF0000"
		kb="CH"
		;;
	"dvp")
		COLOR="#55FF00"
		kb="dvp"
		;;
	*)
		COLOR="#FFFFFF"
		;;
	esac
	echo ",[ {\"full_text\": \"$kb\",\"color\":\"$COLOR\"},{\"full_text\": \"$line\"}]"
done

