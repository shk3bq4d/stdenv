#!/usr/bin/env bash

##
## zabbix-agent-test HOST...
##
##

function usage() { sed -r -n -e '/^##/s/^..// p' $0 ; }
[[ $# -lt 1 ]] && usage && exit 1
STRINGS="cat -"
command -v tr      &>/dev/null && STRINGS="tr -dc '[[:print:]]'"
command -v strings &>/dev/null && STRINGS="strings"
command -v sed &>/dev/null && STRINGS='sed -r -e s/^ZBXD// -e s/[\d001-\d020]//g'
#echo "$STRINGS"
for arg in "$@"; do 
	echo -ne "\n$arg: "
	for k in agent.version system.hostname; do
		r=$(  (echo $k; sleep 1)   | nc $arg 10050 2>/dev/null)
		if [[ $? -ne 0 ]]; then
			#echo " Error connecting"
			nc -v $arg 10050
			break
		fi
		printf "\n%-20s %s" "${k}:" "$(echo -n "$r" | $STRINGS)"
	done
done
