#!/usr/bin/env bash

##
## jar-remove-signature-in-place.sh FILENAME...
##
##

function usage() { sed -r -n -e '/^##/s/^..// p' $0 ; }
[[ $# -lt 1 ]] && usage && exit 1
for arg in "$@"; do [[ ! -f $arg ]] && echo "FATAL: not a file $arg" && exit 1; done
set -eux
which 7z &>/dev/null || { echo "FATAL: 7z not in PATH" && exit 1; }
_tempdir=$(mktemp -d); function cleanup() { [[ -n "$_tempdir" && -d "$_tempdir" ]] && rm -rf $_tempdir; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
workdir=$PWD
cd $_tempdir
mkdir META-INF
MAN_FP=META-INF/MANIFEST.MF

for arg in "$@"; do 
	narg=$arg
	[[ $narg != /* ]] && narg=$workdir/$narg
	if ! 7z l $narg | grep -Fq $MAN_FP; then
		echo "WARN: not a signed jar $arg"
		continue
	fi
	7z x -so $narg $MAN_FP | sed -r -e '/Digest:/ d' > $_tempdir/$MAN_FP
	cp -n $narg{,-signed}
	7z d $narg $MAN_FP
	7z a $narg $_tempdir/$MAN_FP
	echo "Success for $arg"
done

cleanup
exit 0
