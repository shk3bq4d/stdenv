#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin

if [[ -z "${TERM:-}" ]]; then
    export TERM=xterm # needed for clear
fi

if tput civis &>/dev/null; then # ignores TERM and lack of stdin problems
    trap "tput cnorm; echo; exit" INT
fi
host="$(hostname -s)"
if [[ $# -gt 0 ]]; then
    host="${host} $@"
fi

prev_len=0
clear_count=0
clear_count_threshold=30
title_count_threshold=60
title_count="$(date +%S)"
_sleep=1

while true; do
    time_str="${host} $(date +"%Y.%m.%d %H:%M:%S")"
    len=${#time_str}

    title_count=$(( title_count + 1 ))
    if (( title_count > title_count_threshold )); then
        title_count="$(( $(date +%S) - $_sleep ))"
        echo -ne "\033]0;$time_str\007"
    fi

    clear_count=$(( clear_count + 1 ))
    if (( clear_count >= clear_count_threshold )); then
        clear_count=0
        clear
        echo -ne "\r$time_str"
    elif (( len < prev_len )); then
        # Erase previous characters if the new string is shorter
        diff=$((prev_len - len))
        padding=$(printf '%*s' "$diff" '')
        echo -ne "\r$time_str$padding"
    else
        echo -ne "\r$time_str"
    fi

    prev_len=$len
    sleep $_sleep
done
