#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 11 Jan 2019
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

#[[ -n ${VIMF6+1} ]] && echo running from vim-f6

exec > >(tee -a ~/.tmp/log/$(basename $0 .sh).log)
exec 2>&1
set +eu
#set -x
while read line; # subshell avoidance
do
	eval $line
done < <(grep -hE "^export (WORK)" ~/.std*)

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)
set | sort | grep WORK || true
echo bip

#dmenu_run -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#222222" -nf "#999999"
dmenu_run -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#FFFFFF" -nf "#000000"
echo EOF
exit 0

