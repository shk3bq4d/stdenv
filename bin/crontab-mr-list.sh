#!/usr/bin/env bash

set -e
set -u
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/dot.bashcolors

function userlist() {
	cut -d: -f1 /etc/passwd
}
function printred() {
	echo -ne "$RED$BOLD"
	echo -n "$@"
	echo -e  "$OFF"
}
process_source() {
	source="$1"
	content="$2"
	set +e
	def=$(echo "$content" | grep -E "^\s*[@*0-9]")
	ret=$?
	set -e
	if [[ $ret -eq 0 ]]; then
		echo ""
		printred  "$source"
		echo "$def" 
	fi
}
if [[ $EUID -ne 0 ]]; then
	sudo bash $0 "$@"
	#    ^
	#    |
	#    this bash is for when doing sshrc and this scripts sits on the /tmp mount with noexec option
	exit 0
fi

if which crontab &>/dev/null; then
	for user in $(userlist); do
		process_source "crontab -e -u $user" "$(crontab -l -u $user 2>/dev/null)" 
	done
fi
for fp in $(find /etc/crontab /etc/cron.d/* -type f 2>/dev/null); do
	process_source "$fp" "$(cat $fp)"
done
echo ""
echo -ne "$BLUE"
ls -l /etc/cron.{hourly,daily,weekly,monthly}/* 2>/dev/null| grep -vE '^d' || true
echo -ne "$OFF"
