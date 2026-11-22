#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

PREFIX="../new/location/"
PREFIX="../"

find . -maxdepth 1 -xtype l | while IFS= read -r link; do
    echo ""
    echo "iterating over $link"
    target="$(readlink "$link")"
    echo "  current target is $target"

    # only handle relative symlinks
    if [[ "$target" == /* ]]; then
        echo "  WARN: not treating absolute links"
        continue
        fi

    new_target="${PREFIX}${target}"
    if [[ ! -e "$new_target" ]]; then
        echo "  WARN: new target does not exist either $new_target"
        continue
    fi

    echo "  Repairing: $link -> $new_target"
    ln -snf "$new_target" "$link"
done
