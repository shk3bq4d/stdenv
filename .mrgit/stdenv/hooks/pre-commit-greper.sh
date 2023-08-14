#!/usr/bin/env bash
# ex: set filetype=sh :

set -euo pipefail
a="\\<"
b="\\>"
p="\\."
word1=$'\x72\x75\x6d\x6f'
word2=$'\x6b\x73'
word3=$'\x6b\x75\x64\x65\x6c\x73'
word4=$'\x63\x61\x72\x74\x69\x65\x72'
if [[ -n ${VIMF6:-} ]]; then
cat << EOF
word1 is $word1
word2 is $word2
word3 is $word3
word4 is $word4
EOF
	exit 0
fi
grep --color --with-filename -n -i \
	-e ${a}${word1}${b} \
	-e ${a}m${word1}${b} \
	-e ${a}${word1}m${b} \
	-e ${a}${word2}${p}net${b} \
	-e ${a}${word2}${p}dev${p}local${b} \
	-e ${word3} \
	-e ${word4} \
	"$@"
exit $?
