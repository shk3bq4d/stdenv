#!/usr/bin/env bash

i3blocks -c ~/.config/i3/i3blocks-$(hostname -f)-right.conf
exit 0

set -u
set -e
set -o pipefail

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


#tail -F ~/.config/i3/mri3status_right.json | while :; do
while :; do cat ~/.config/i3/mri3_status_right.json | while read time line; do
	[[ "$time" == "#"* ]] && continue
	echo "$line"
	sleep $time
done; done

