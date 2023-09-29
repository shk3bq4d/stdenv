#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

for i in "$@"; do
    if [[ ! -e "$i" ]]; then
        echo "FATAL: $i does not exist"
        exit 1
    fi
done

ts=$(date +'%Y.%m.%d')
for i in "$@"; do
    j="$(sed -r -e 's/^20[0-9]{2}[.\-][0-9]{2}[.\-][0-9]{2}[.\-]?//' <<< "$i")"
    to="${ts}-$j"
#   echo "i is $i"
#   echo "i is $i"
    if [[ "$i" == "$to" ]]; then
        echo "NOOP $i"
        continue
    fi
    if mv "$i" "$to"; then
        echo "$i -> $to"
    else
        echo "FATAL trying to mv $i $to"
        exit 1
    fi
done

echo EOF
exit 0
