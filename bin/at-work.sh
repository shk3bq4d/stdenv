#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

source ~/bin/dot.hostname
for i in ~/.std*_aliases; do
	source  $i
done
case ${HOSTNAMEF:-hostnamef-unset} in \
${WORK_PC1F:-workpc1f-unset})
	exit 0
	;;
nov20.ly.lan)
	#ips --no-internet | grep -q 'wlp58s0.*172.28'
	ifconfig wlp0s20f3 | grep -qE "inet (10\.14\.2\.|192\.168\.168\.)" && exit 0
	;;
esac
exit 1
# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)

echo EOF
exit 0

