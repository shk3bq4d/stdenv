#!/usr/bin/env bash

set -e
out=$PWD/$(basename $0 .sh).txt
cd -P "$( dirname "${BASH_SOURCE[0]}" )"
a=$PWD
for i in */; do
	cd $a/$i
	set +e
	remote=$(git remote get-url origin 2>/dev/null)
	[[ $? -gt 0 ]] && continue
	set -e
	printf "%-20s %s\n" $i $remote | tee -a $out
done
f=$(mktemp)
cat $out | sort -u > $f
# out is a symbolic link, can't do rm or overwrite
truncate -s 0 $out
cat $f >> $out
rm -f $f
echo "EOF"
