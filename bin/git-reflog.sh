#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

git reflog --date=relative --decorate --format='%C(auto)%h %C(blue)%<|(17)%gd%C(reset) %<|(110)%gs %C(green)%s%C(reset) %C(auto)%d%C(reset)' "$@"
