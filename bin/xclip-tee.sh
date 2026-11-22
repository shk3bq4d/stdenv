#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
source ~/bin/dot.x11
xclip_tee() {
    if hash xclip &>/dev/null; then
#       >&2 echo tee0
        tee >(xclip -i)
    else
#       >&2 echo tee1
        cat
    fi
}

cat "$@" | xclip_tee
exit 0
