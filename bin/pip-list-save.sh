#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 01 May 2019
##

set -euo pipefail

# function usage() { sed -r -n -e "s/__SCRIPT__/$\(basename $0\)/" -e '/^##/s/^..// p'   $0 ; }

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

D=~/.config/$(hostname -f)/pip-list
test -d $D || mkdir -p $D
cd $D
if [[ ! -d .git ]]; then
    git init
fi
if [ -n "$(git status --porcelain)" ]; then
    echo "working directory not clean"
    exit 1
fi
OPTS="--format freeze"
pip2 list $OPTS        > pip2-list
pip2 list $OPTS --user > pip2-list-user
pip3 list $OPTS        > pip3-list
pip3 list $OPTS --user > pip3-list-user
if [ -n "$(git status --porcelain . )" ]; then
    git diff
    git add pip{2,3}-list{,-user}
    git commit -m "autocommit $@"
    echo "Committed"
else
    echo "No changes"
fi

