#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

[[ $# -eq 0 ]] && echo "FATAL: no args provided" && exit 1

GIT_SEQUENCE_EDITOR=~/bin/git-rebase-editor.sh git rebase --keep-empty --rebase-merges -i "$@"


exit 0
