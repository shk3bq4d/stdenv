#!/usr/bin/env bash
~/bin/mute-off.sh
~/bin/volume-100.sh
nohup /usr/bin/google-chrome https://www.netflix.com/browse &>/dev/null &
for i in $(seq 1); do
	/usr/bin/mplayer ~/Music/bip-stereo.mp3
	sleep 1
done
