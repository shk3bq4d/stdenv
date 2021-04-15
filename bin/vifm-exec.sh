#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

if ! hash vifm &>/dev/null; then
    echo "FATAL: vifm not installed on system"
    exit 1
fi

MYVIFMRC=/dev/null vifm -c only -c ":filetype * bash" -c "set nofollowlinks" .
