#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
# https://stackoverflow.com/questions/11981716/how-to-quickly-find-all-git-repos-under-a-directory/12010862#12010862

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

HIGHLIGHT="\e[01;34m"
NORMAL='\e[00m'

#export GIT_ASKPASS=/bin/false
export GIT_TERMINAL_PROMPT=0

case $(git --version) in \
"git version 1."*)
    actions() {
        timeout 2m git fetch --all           --tags --no-recurse-submodules
        git gc
    }
    ;;
*)
    actions() {
        timeout 2m git fetch --all --auto-gc --tags --no-recurse-submodules
    }
    ;;

esac

function update {
  local d="$1"
  if [ -d "$d" ]; then
    if [ -e "$d/.ignore" ]; then
      echo -e "\n${HIGHLIGHT}Ignoring $d${NORMAL}"
    else
      cd $d > /dev/null
      if [ -d ".git" ]; then
        echo -e "\n${HIGHLIGHT}Updating `pwd`$NORMAL"
        if actions; then
            echo "ok"
        else
            echo "ignoring error"
        fi
        #git gc || true
      else
        scan *
      fi
      cd .. > /dev/null
    fi
  fi
  #echo "Exiting update: pwd=`pwd`"
}

function scan {
  #echo "`pwd`"
  for x in $*; do
    update "$x"
  done
}

if [ $# -ne 0 ]; then cd "$1" > /dev/null; fi
#echo -e "${HIGHLIGHT}Scanning ${PWD}${NORMAL}"
if ! can-ping-gateway.sh; then
    echo "ABORT as probably no network avaible"
    exit 0
fi
if hash wifi-current-ssid-$(id -un).sh &>/dev/null;
    ssid="$(wifi-current-ssid-$(id -un).sh || true)"
else
    ssid="$(wifi-current-ssid.sh || true)"
fi
case "$ssid" in \
jul20)
    echo "ABORT, not doing this on wifi $wifi"
    exit 0
*)
esac
scan ~/git
