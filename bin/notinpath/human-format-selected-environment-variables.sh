#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 05 Nov 2018
##

set -eo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)
_inner() {
    key="$1"
    [[ -z "$key" ]] && return
    shift
    humankey="$@"
    value="${!key}"
    if [[ -z "$value" || $value == "$"*"$" ]]; then
        return
    fi
    if [[ -z "$humankey" ]]; then
        humankey=$key
        humankey=${humankey##NOTIFY_}
        humankey=${humankey,,}
        humankey=${humankey//_/ }
        humankey="$(sed -e "s/\b\(.\)/\u\1/g" <<< "$humankey")"
    fi
    printf "%-15s %s\n" "${humankey}:" "${value}"
}
text() {
    echo "
        HOSTNAME my host name
        PWD
        TERM terminal
        PATH
        NOTIFY_SHORTDATETIME time
        NOTIFY_HOSTSTATE        State
        NOTIFY_HOSTADDRESS      Ip
        NOTIFY_HOSTNAME
        NOTIFY_HOSTCHECKCOMMAND Check
        NOTIFY_HOSTOUTPUT       Result
        NOTIFY_SERVICEDESC      Service
        NOTIFY_SERVICESTATE     State
        NOTIFY_SERVICEOUTPUT    Status
        " | while read line; do
        _inner $line
    done
}
text

echo EOF
exit 0

