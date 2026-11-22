#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

pid=$(xpid)

subtree() {
  local cur=$1 all=$1 next
  while next=$(ps -o pid= --ppid "$cur" | tr -d ' ' | paste -sd, -); [ -n "$next" ]; do
    all="$all,$next"
    cur=$next
  done
  ps -o pid,ppid,stat,cmd --forest -p "$all"
}

subtree $pid
#ps -f --forest  -p $(xpid)
