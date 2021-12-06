#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:~/bin

cat /tmp/.9zamdzCtVG8 |
    tr ' ' $'\n' |
    tr $'\t' $'\n' |
    tr '[[:upper:]]' '[[:lower:]]' |
    grep -E '^([a-z][a-z0-9-]{2,40}\.){2,5}(lan|co|io|com|ch)$' |
    sort -u
