#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

tput civis
trap "tput cnorm; echo; exit" INT

prev_len=0

while true; do
    time_str=$(date +"%H:%M:%S")
    len=${#time_str}

    # Erase previous characters if the new string is shorter
    if (( len < prev_len )); then
        diff=$((prev_len - len))
        padding=$(printf '%*s' "$diff" '')
        echo -ne "\r$time_str$padding"
    else
        echo -ne "\r$time_str"
    fi

    prev_len=$len
    sleep 1
done
