#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 08 Jan 2019
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

#[[ -n ${VIMF6+1} ]] && echo running from vim-f6

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1
#
PRE_BOUNDARY="(^|\\s)" # \b sucks at 1354586456.2019 would match 2019
POST_BOUNDARY="($|\\s)" # \b sucks at 1354586456.2019 would match 2019
DATE_BOUNDARY="[\\.\\-\\/]?"
TIME_BOUNDARY="[\\.:]"

sed -r \
	-e "s/${PRE_BOUNDARY}[0-9]{4}${DATE_BOUNDARY}[0-9]{2}${DATE_BOUNDARY}[0-9]{2}${POST_BOUNDARY}/ /" \
	-e "s/${PRE_BOUNDARY}[0-9]{2}${DATE_BOUNDARY}[0-9]{2}${DATE_BOUNDARY}[0-9]{2}${POST_BOUNDARY}/ /" \
	-e "s/${PRE_BOUNDARY}[0-9]{2}${DATE_BOUNDARY}[0-9]{2}${DATE_BOUNDARY}[0-9]{4}${POST_BOUNDARY}/ /" \
	-e "s/${PRE_BOUNDARY}[0-9]{1,2}${TIME_BOUNDARY}[0-9]{2}(${TIME_BOUNDARY}[0-9]{2})?${POST_BOUNDARY}/ /" \


