#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

args="$@"

if ! helm history "$@" &>/dev/null; then
    set +x
    helm history "$@"
    exit 1
fi
source ~/bin/dot.bashcolors

helm history "$@" |
    grep -vF REVISION |
    tail -n+2  |
    tac |
    while read a b; do
        {
            echo -e "${EBLUE}=====================================================${EOFF}"
            echo helm status "$@" --revision $a;
                 helm status "$@" --revision $a;
            echo helm diff revision "$@" --color $(( a - 1 )) $a;
                 helm diff revision "$@" --color $(( a - 1 )) $a;
        }
    done |
    less
