#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
	set -x
	ansible-playbook *.yml --ask-become-pass --diff -l 127.0.0.1
	set +x
else
	for pb in "$@"; do
		if grep -wq become $pb &>/dev/null; then
			ansible-playbook $pb --ask-become-pass --diff -l 127.0.0.1
		else
			ansible-playbook $pb                   --diff -l 127.0.0.1
		fi
	done
fi
