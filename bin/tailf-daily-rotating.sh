#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 24 Dec 2018
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)

DATEBIN=date
uname | grep -qi freebsd && DATEBIN=gdate
! hash $DATEBIN 2>/dev/null && echo "FATAL: not present $DATEBIN. pkg install coreutils" && exit 1

if [[ -n ${VIMF6+1} ]]; then
	filepath="./BrowserServer.2018-12-24"
else
	filepath="$1"
	if [[ ! -f "$filepath" ]]; then
		echo "FATAL not a file $filepath"
		exit 1
	fi
fi
filename="$(basename "$filepath")"


for format in  \
	'%Y%m%d'  \
	'%Y.%m.%d'  \
	'%Y-%m-%d'  \
	'%y%m%d'  \
	'%y.%m.%d'  \
	'%y-%m-%d'  \
	'%d.%m.%Y' \
	'%d-%m-%Y' \
	'%d%m%Y' \
	'%d.%m.%y' \
	'%d-%m-%y' \
	'%d%m%y' \
	; do
	if [[ -f "$filepath" ]]; then
		today=$($DATEBIN "+$format" -r "$filepath")
	else
		today=$($DATEBIN "+$format")
	fi
	if echo "$filename" | grep -Fq $today; then
		template=${filepath//$today/}
		echo "detected format is $format ! template is $template"
		while :; do
			todays_filepath="$template$($DATEBIN +"$format")"
			now=$($DATEBIN +%s)
			midnight=$($DATEBIN +%s -d 'tomorrow 0:00')
			diff=$(($midnight - $now))
			echo "diff is $diff"
			echo "timeout $diff tail -n 300 -F \"$todays_filepath\""
			set +e
			timeout $diff tail -n 300 -F "$todays_filepath"
			set -e
		done
		break
	fi
done


echo EOF
exit 0

