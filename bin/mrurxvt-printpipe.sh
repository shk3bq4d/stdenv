#!/usr/bin/env bash

set -eux
file=$HOME/tmp/urxvt.dump.$(date +'%Y.%m.%d-%H:%M:%S')
cat | 
	cat > $file

[[ -z "$TERMINAL" ]] && TERMINAL=xterm

$TERMINAL -e vim -c "set ft=sh buftype=nofile" -- $file &

exit 0
	sed -r -n -e '/\S/,$p'                | # removes leading empty or blank lines
	sed -r -e 's/\s+$//g'                 | # right trim lines
	sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' | # removes trailing empty lines
