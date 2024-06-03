#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

args=""
ref=""
while :; do
    if [[ $# -eq 0 ]]; then
        if [[ -z "$ref" ]]; then
            ref=HEAD
        fi
        break
    fi

    if [[ "$1" == "-"* ]]; then
        args="$args $1"
        shift
        continue
    fi

    if git check-ref-format "$1" &>/dev/null; then
        ref="$1"
        shift
        continue
    fi
    if [[ -z "$ref" ]]; then
        ref="$(git log -1 --pretty='%H' "$@")"
        shift
    fi
    break
done

git commit --reset-author --reedit-message=$ref $args "$@"
