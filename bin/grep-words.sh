#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

case $0 in \
*-i*) case_sensitive="-i";;
*)    case_sensitive="";;
esac

test -t 1 && color=always || color=no

go() {
  if [[ $# -eq 0 ]]; then
      cat -
  else
      arg="$1"
      shift
      export GREP_COLORS='ms=01;32'
      #"$0" "$@" | grep --line-buffered --color=$color -aE $case_sensitive "$arg" --
      "$0" "$@" | ack --color $case_sensitive "$arg" --
  fi

}

go "$@"
