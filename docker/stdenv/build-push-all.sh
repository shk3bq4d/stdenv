#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 27 Feb 2019
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

#[[ -n ${VIMF6+1} ]] && echo running from vim-f6

# exec > >(tee -a ~/.tmp/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)
#
docker login
for i in apt py stdenv; do
	cd $DIR/$i
	t=shk3bq4d/stdenv:$i
	docker build -t $t .
	docker push $t

done

echo EOF
exit 0

