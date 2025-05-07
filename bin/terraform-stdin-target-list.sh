#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin


cat "$@" |
sed -r -n -e '
# remove ansi colors
s/\x1B\[([0-9]{1,2}(;[0-9]{1,2}){0,2})?[mGK]//g

# do the terraform transformation
s/  # (.*) (must|will) be .*/-target ,\1,/p


' | tr , "'"
