#!/usr/bin/env bash


STDHOMEDIR=$(stdhome-dirname.sh)
find ~ -type l -name "stdhome-templating-*.sh" -and -not -name "stdhome-templating-apply.sh" -print0 2>/dev/null | sort -z | 
	while read -r -d '' f; do
		[[ "$f" == $STDHOMEDIR/* ]] && continue
		$f
	done
