#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ "date -d expression" playbook arguments
##executes a delayed ansible run
##
## Author: Jeff Malone, 10 Mar 2022
##

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

_script_id() {
    echo "$@" | sed -r -e "s/[ .&_]+/-/g" -e "s/^-+|-+$//g"
}

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

! date -d "$1" &>/dev/null && echo "FATAL: not a valid time specification $1" && exit 1
T="$1"
shift
while [[ "$1" == "ap" ]] || [[ "$1" == "ansible-playbook" ]]; do
    shift
done

! ansible-playbook --syntax-check "$@" &>/dev/null && echo "FATAL: can execute ansible-playbook --syntax-check $@" && exit 1

ID="$(_script_id "$@")"
flagfile="$HOME/.tmp/ansible-playbook-delayed-$ID"
logfile1="$HOME/.tmp/log/ansible-playbook-delayed-black-${ID}.log"
logfile2="$HOME/.tmp/log/ansible-playbook-delayed-color-${ID}.log"

test -f $flagfile && echo "FATAL: flagfile already exists" && ls -l "$flagfile" && exit 1

echo "flagfile is $flagfile"
{
    date
    echo "T is $T"
    echo "args are $@"
} > $flagfile

{
    set -euo pipefail
    exec > >(stdbuf -o0 ts | tee $logfile2 | sed-remove-ansi-colors.sh | tee $logfile1)
    exec 2>&1
    trap "rm $flagfile &>/dev/null || true" SIGHUP SIGINT SIGQUIT SIGTERM EXIT

    wait-until.sh "$T"
    ! test -f "$flagfile" && echo "FATAL: flagfile no longer exists" && ls -l "$flagfile" && exit 1
    export ANSIBLE_FORCE_COLOR=true
    set +e
    echo ansible-playbook "$@"
    ansible-playbook "$@"
    echo "exit code is $?"
    rm "$flagfile" &>/dev/null || true
    exit $?
} >/dev/null &

disown

sleep 3
cat $logfile1

exit 0
