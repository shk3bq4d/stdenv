#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

_stdin() {
    if [[ $# -eq 0 ]]; then
        cat
    else
        echo "$@"
    fi

}
_stdin "$@" | ~/.local/bin/zxcvbn  | jq .score
