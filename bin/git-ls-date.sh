#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 01 Feb 2018
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=8846 -t newsh -p user.info ))
# exec 2>&1

#git ls-tree -r --name-only HEAD | while read filename; do
git ls-tree --name-only HEAD | while read filename; do
    #echo "$(git log -1 --format="%ad" -- $filename) $filename"
	date1="$(git log -1 --date=relative --format="%ad" -- "$filename")"
	date2="$(git log -1 --date=iso --format="%ad" -- "$filename")"
	date2="${date2:0:16}"
    if [[ -d "$filename" ]]; then
    	printf "a %-50s %-20s %s\n" "$filename/" "$date1" "$date2"
	else
    	printf "b %-50s %-20s %s\n" "$filename"  "$date1" "$date2"
	fi
done | sort |  cut -d ' ' -f 2-
exit 0

