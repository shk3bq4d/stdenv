#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

#git-reflog.sh --color=always | sed -r -n -e '/  \([^)]+\)$/s/(.*)  (\([^)]+\))$/\2 \1/p '
#git-reflog.sh --color=always | sed -r -n -e '/  \([^)]+\)$/s/(.*)  (\([^)]+\))$/\2 \1/p '
git reflog --color=always --date=relative --format='%C(auto)%<(80)%D%C(reset) %C(blue)%<(22)%gd%C(reset)' "$@" | grep -v '^ '
