#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 21 Feb 2020
##

set -euo pipefail

# function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

#   h - check for option -h without parameters; gives error on unsupported options;
#   h: - check for option -h with parameter; gives errors on unsupported options;
#   abc - check for options -a, -b, -c; gives errors on unsupported options;
#   :abc - check for options -a, -b, -c; silences errors on unsupported options;
#      Notes: In other words, colon in front of options allows you handle the errors in your code. Variable will contain ? in the case of unsupported option, : in the case of missing value.
# OPTARG - is set to current argument value,
# OPTERR - indicates if Bash should display error messages.
# usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; }
# while getopts ":s:p:h" o; do
#     case "${o}" in
#         s)
#             s=${OPTARG}
#             ! ((s == 45 || s == 90)) && usage && exit 1
#             ;;
#         p)
#             p=${OPTARG}
#             ;;
#         h)
#             usage
#             exit 0
#             ;;
#         *)
#             usage
#             exit 1
#             ;;
#     esac
# done
# shift $((OPTIND-1)) || true
# if [ -z "${s:-}" ] || [ -z "${p:-}" ]; then
#     usage
#     exit 1
# fi
# echo "s = ${s}"
# echo "p = ${p}"
# echo "rest = $@"

# for i in sed which grep; do ! command -v "$i" &>/dev/null && echo "FATAL: unexisting dependency $i in path: $PATH" && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

#[[ -n ${VIMF6:-} ]] && echo running from vim-f6

# exec > >(tee -a ~/.tmp/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)

#echo -n "Are you sure you want to proceed (yN): "
#read _read
#echo
#case "${_read,,}" in #y|yes) true ;;
#*)   false;;
#esac

PORT=$(random-free-tcp-port.sh)
LO=127.0.0.1
LOP=$LO:$PORT
export http_proxy=http://$LOP
export https_proxy=http://$LOP
env | grep -i http
set -x
#/usr/bin/chromium-browser --parent-profile=r4p --new-window --proxy-server="socks5://$LOP" --temp-profile http://whatismyip.akamai.com/
echo "
if you need your profile and not a container, close all you chromium-browser window and start
chromium-browser --proxy-server="socks5://$LOP" http://whatismyip.akamai.com/
"
{ sleep 2;
  docker-chromium-browser.sh --proxy-server="socks5://$LOP" http://whatismyip.akamai.com/;
} >/dev/null 2>&1 </dev/null &
ssh -D $LOP "$@"


echo EOF
exit 0

