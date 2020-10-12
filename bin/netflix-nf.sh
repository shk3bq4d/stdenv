#!/usr/bin/env bash
~/bin/mute-off.sh
nohup /usr/bin/google-chrome https://www.netflix.com/browse &>/dev/null &
for i in $(seq 5); do
	/usr/bin/mplayer ~/Music/bip-stereo.mp3
	sleep 1
done
