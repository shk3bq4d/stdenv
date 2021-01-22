#!/usr/bin/env bash

set -e

if [[ -n "$STDHOME_DIRNAME" ]]; then
	echo "$STDHOME_DIRNAME"
else
	test -z "${USER:-}" && USER=$(whoami)
	for i in \
		~/git/$USER/stdhome \
		~/git/ly.abc1.ch/stdhome \
		~/git/github/shk3bq4d/stdhome \
		~/git/shk3bq4d/stdhome \
	; do
		[[ -d "$i" ]] && echo "$i" && exit 0
	done
	for i in \
		~/git/$USER/stdenv \
		~/git/ly.abc1.ch/stdenv \
		~/git/github/shk3bq4d/stdenv \
		~/git/shk3bq4d/stdenv \
	; do
		[[ -d "$i" ]] && echo "$(dirname "$i")/stdhome" && exit 0
	done
	find ~ -type d -name stdhome -or -name stdenv -print -quit | while read i; do
		echo "$(dirname "$i")/stdhome"
		exit 0
	done
	>&2 echo "stdhome-dirname.sh not found"
	exit 1
fi
