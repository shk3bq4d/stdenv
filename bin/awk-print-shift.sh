#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

n=2
if [[ $# -ge 1 ]] && [[ $1 =~ ^[0-9]+$ ]]; then
    n=$(( $1 + 1 ));
    shift
fi
# https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk
awk '{for (i='$n'; i<NF; i++) printf $i " "; print $NF}' "$@" |sed 's/ $//'
exit 0
