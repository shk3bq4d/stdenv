#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

current_output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).output')
other_output=$(i3-msg -t get_outputs | jq -r '.[] | select(.active and .name != "'$current_output'").name')

i3-msg -t get_workspaces | jq -r '.[] | select(.output == "'$current_output'").name'
if [ -n "$other_output" ]; then
    i3-msg -t get_workspaces | jq '.[] | select(.output == "'$current_output'").name' | while read ws; do
        # i intentionnaly do not do jq -r and as such, keep the leading and trailing " from a jsonn string
        echo "ws $ws"
        i3-msg workspace "$ws"
        i3-msg move workspace to output next # "$other_output"
    done
else
    echo "no other output detected"
    exit 1
fi

echo EOF
exit 0
