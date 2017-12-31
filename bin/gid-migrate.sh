#!/usr/bin/env bash

set -e
set -u

function usage()  {
	echo "$(basename $0) [GROUPNAME|CURGID] NEWGID"
}

function group_names() {
	cut -d: -f1 /etc/group
}
function group_gids() {
	cut -d: -f3 /etc/group
}
function get_group_gid() {
	local r
	[[ $# -ne 1 ]] && return 1
	r="$(cut -d: -f1,3 /etc/group | grep -w "$1" | cut -d: -f 2)"
	[[ -z $r ]] && return 1
	echo "$r"
}
function get_group_name() {
	local r
	[[ $# -ne 1 ]] && return 1
	r="$(cut -d: -f1,3 /etc/group | grep -w "$1" | cut -d: -f 1)"
	[[ -z $r ]] && return 1
	echo "$r"
}
function group_exists() {
	get_group_gid "$@" &>/dev/null && return 0
	return 1
}

if [[ $# -ne 2 ]]; then
	echo "FATAL: incorrect number of args"
	usage
	exit 1
fi

if [[ $EUID -ne 0 ]]; then
	echo "FATAL: this script should be run with root permission"
	exit 1
fi

if ! group_exists "$1"; then
	echo "FATAL: unknown current group $1"
	usage
	exit 1
fi
CURGID=$(get_group_gid "$1")
CURNAME=$(get_group_name "$CURGID")
if [[ "$CURGID" -le 1 ]]; then
	echo "FATAL: can't remap GID <= 1"
	exit 1
fi

NEWGID="$2"
if [[ "$CURGID" -eq "$NEWGID" ]]; then
	echo "FATAL: old gid and new gid are the same $1 == $NEWGID"
	usage
	exit 1
fi

if group_exists	"$NEWGID"; then
	echo "FATAL: destination gid alreay taken $2 by group $(get_group_name $2)"
	usage
	exit 1
fi

groupmod -g $NEWGID $CURNAME 
find / -gid $CURGID -print0 | xargs -0 --no-run-if-empty chgrp --verbose --changes --no-dereference $NEWGID
#/usr/bin/chgrp --changes --no-dereference --recursive --from=$CURGID $NEWGID /
echo "full success OK"
exit 0
