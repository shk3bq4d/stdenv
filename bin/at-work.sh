#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail

source ~/bin/dot.hostname
for i in ~/.std*_aliases; do
	source  $i
done
#echo WORK_PC4 is $WORK_PC4
#echo HOSTNAMEF is $HOSTNAMEF
test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$({ timeout 3 hostname -f || cat /etc/hostname; } | tr '[:upper:]' '[:lower:]')
case ${HOSTNAMEF:-hostnamef-unset} in \
${WORK_PC1F:-workpc1f-unset}) exit 0 ;;
${WORK_PC2F:-workpc2f-unset}) exit 0;;
${WORK_PC3F:-workpc3f-unset}) ip a show wlp2s0    | grep -qE "inet (10\.14\.52\.)" && exit 0 ;;
${WORK_PC4F:-workpc4f-unset}) ip a show wlp0s20f3 | grep -qE "inet (10\.14\.52\.)" && exit 0 ;;
nov20.ly.lan)
	#ips --no-internet | grep -q 'wlp58s0.*172.28'
	ip a show wlp0s20f3 | grep -qE "inet (10\.14\.(2|52)\.|192\.168\.168\.)" && exit 0
	;;
esac
exit 1
