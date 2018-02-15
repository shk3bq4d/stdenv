#!/usr/bin/env bash

set -e

. ~/bin/dot.lockfunctions

exlock_now || { echo "$(date) can't start as flock'ed" && exit 1; } 
echo "$(date) Startup $0 $@"
d=~/.tmp/log/
test -d $d || mkdir -p $d
case $(hostname -f) in \
dec17.ly.lan|apr16.ly.lan)
	b=1:0.35
	t=6500:3500
	;;
*)
	b=1:1
	t=6500:3500
	;;
esac
redshift -l 46.57:7.27  -b $b -t $t -v  | while read line; do echo "$(date) $line"; done | tee -a $d/$(basename $0 .sh).log
echo "$(date) end $0 $@"
