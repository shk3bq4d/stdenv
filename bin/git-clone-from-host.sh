#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST DIRECTORY
##git clones REMOTEHOST:$PWD/DIRECTORY
## Author: Jeff Malone, 07 Mar 2024
##

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 2 || $# -gt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

set -x
set +x
case "$2" in \
std*)
    git clone --no-checkout "$1:$PWD/$2"
    cd "$2"
    git config core.worktree $HOME
    git config status.showuntrackedfiles no
    git config user.name "Jeff Malone"
    git config user.email "jeff@$(hostname -s)"
    git config core.excludesfile $HOME/.gitignore_global
    git config diff.tool vimdiff
    git config merge.tool vimdiff
    git config commit.verbose true
    git config branch.autosetupmerge always
    git checkout "$2"
    git branch --set-upstream-to=origin/"$2" "$2"
    ;;
*)
    git clone "$1:$PWD/$2"
    ;;
esac


echo "OK"
exit 0
