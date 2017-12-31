#!/usr/bin/env bash

##
## jar-signature FILENAME...
##
##

function usage() { sed -r -n -e '/^##/s/^..// p' $0 ; }
[[ $# -lt 1 ]] && usage && exit 1
for arg in "$@"; do [[ ! -f $arg ]] && echo "FATAL: not a file $arg" && exit 1; done
set -eu
which 7z &>/dev/null || { echo "FATAL: 7z not in PATH" && exit 1; }

MAN_FP=META-INF/MANIFEST.MF

for arg in "$@"; do 
	if ! 7z l $arg | grep -Fq $MAN_FP; then
		echo "WARN: not a signed jar $arg"
		continue
	fi
	count=$(7z x -so $arg $MAN_FP | grep Digest: | wc -l)
	echo "jar $arg has $count signed files"
done

