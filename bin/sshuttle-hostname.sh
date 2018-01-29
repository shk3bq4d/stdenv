#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ JUMP TARGET.. [NB_QUERY_DNS]
##configures whatever action with whatever config
##    JUMP: jump
##    TARGET: 
##    NB_QUERY_DNS: defaults to one
##
## Author: Jeff Malone, 29 Jan 2018
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1
NB_QUERY_DNS=1
JUMP=$1
shift
TARGET=$1
LIST=""

it=0
while :; do
	it=$(( $it + 1 ))
	#[[ $NB_QUERY_DNS -eq 0 ]] && break
	for TARGET in "$@"; do
		if [[ "$TARGET" =~ ^[0-9]+$ ]]; then
			NB_QUERY_DNS=$TARGET
			break
		fi
		LIST=$(echo -e "$LIST\n$(dig +short $TARGET)")
	done
	[[ $NB_QUERY_DNS -eq $it ]] && break
done
LIST="$(sort -un <<<"$LIST")"

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=24568 -t newsh -p user.info ))
# exec 2>&1
#
#
sshuttle -v -r  $JUMP $LIST
# sshuttle -l 0.0.0.0 -v -r  $JUMP $LIST # makes it available to docker containers
# https://stackoverflow.com/questions/29838892/how-to-let-docker-container-work-with-sshuttle


echo EOF
exit 0

