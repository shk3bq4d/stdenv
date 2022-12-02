#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ TEMPLATE
##    TEMPLATE: the template to evaluate
##
## Author: Jeff Malone, 02 Dec 2022
##

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 1 || $# -gt 1 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

[[ -t 1 ]] && export ANSIBLE_FORCE_COLOR=true

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" ]]  && [[ -d "$_tempdir" ]]  && rm -rf "$_tempdir"  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
if ! ansible all -i "localhost," -m template -a "src='$1' dest=$_tempdir/out" --connection=local &>$_tempdir/err; then
    cat $_tempdir/err
    exit 1
fi

cat $_tempdir/out

exit 0
