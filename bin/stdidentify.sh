#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ FILES
##tells from which std repos a file is based
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 22 Dec 2017
##

set -euo pipefail

function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }
short=0
while getopts ":hs" o; do
    case "${o}" in
        h)
            usage
			exit 0
            ;;
        s)
            short=1
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

[[ $# -lt 1 ]] && echo FATAL: incorrect number of args && usage && exit 1

mrprint() {
	local mask="%-40s %s\n"
	if (( $short )); then
		echo "$2"
	else
		printf "$mask" "$1" "$2"
	fi
}

process() {
	local f mask
	f="$1"
	if [[ ! -f "$f" ]]; then
		mrprint "$f" "not a file"
		return 2
	fi
	fullpath="$(readlink -f "$f")"
	if [[ ! -f "$fullpath" ]]; then
		mrprint "$f" "points to deadlink $fullpath"
		return 3
	fi
	if [[ "$fullpath" == ${STDHOME_DIRNAME}/* ]]; then
		mrprint "$f" "stdhome"
		return 0
	fi
	for g in $(stdothers.sh); do
		if git --git-dir="$g/.git" log -1 --oneline "$f" | grep -q " " &>/dev/null; then
			mrprint "$f" "$(basename "$g")"
			return 0
		fi
	done
	mrprint "$f" "unindentified"
	return 1
}
_exit=0
for file in "$@"; do
	process "$file" || _exit=1
done

exit $_exit

