#!/usr/bin/env bash

set -e
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR 
function cleanup() {
	echo cleanup
	sudo rm -f $DIR/*.retry &>/dev/null
}
trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
if [[ $# -eq 0 ]]; then
	sudo true # ask password early
	for i in *.yml; do
		$0 $i
	done
else
	for pb in "$@"; do
		if grep -wq become $pb &>/dev/null; then
			#ansible-playbook $pb --ask-become-pass --diff -l 127.0.0.1
			sudo -E ~/bin/ansible-playbook $pb --diff -l 127.0.0.1
		else
			ansible-playbook $pb                   --diff -l 127.0.0.1
		fi
	done
fi
cleanup
