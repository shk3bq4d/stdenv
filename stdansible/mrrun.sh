#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
	set -x
	ansible-playbook *.yml --ask-become-pass --diff -l 127.0.0.1
	set +x
else
	set -x
	ansible-playbook "$@" --ask-become-pass --diff -l 127.0.0.1
	set +x
fi
