#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

if [[ $# -eq 0 ]]; then
    volume=60
else
    volume="$@"
fi

pactl list sink-inputs | awk '
  $1 == "Sink" && $2 == "Input" { id = $3 }
  /application.process.binary = "snapclient"/ { print id }
' | tr -d '#' | xargs -tI{} pactl set-sink-input-volume {} ${volume}%
