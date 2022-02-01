#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:~/bin

process_single() {
    local jar touch
    jar="$(realpath "$1")"
    extractdir="${jar}.x"
    test -e "${extractdir}" && return
    {
        mkdir "${extractdir}"
        cd "${extractdir}"
        7za x "$jar" && echo "extracted in $PWD"
    }
}

TOPDIR="$PWD"
for repetition in $(seq 5); do
find "$TOPDIR" -xdev -type f -\( -iname '*.jar' -or -iname '*.war' -\) | while read line; do
    process_single "$line"
done
done

echo done
exit 0
