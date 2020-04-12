#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8

echo "FATAL: not redshift for you"
exit 1

set -e

d=~/.tmp/log/
test -d $d || mkdir -p $d
f=$d/$(basename $0 .sh).log
touch $f
log() {
	echo "$(date) $@" >> $f
}

onsuspend() {
	log "onsuspend noop"
}
SLEEP=0
onresume() {
	log "onresume"
	SLEEP=0 # no sure that's going to work
	pkill -9 ^redshift$ || true
}

trap onsuspend TSTP
trap onresume  CONT

. ~/bin/dot.lockfunctions

exlock_now || { echo "$(date) can't start as flock'ed" && exit 1; } 
echo "$(date) Startup $0 $@"
case $(hostname -f) in \
dec17.ly.lan)
	b=1:0.60
	t=6000:3500
	;;
apr16.ly.lan)
	b=1:0.75
	t=6500:3500
	;;
acer2011.ly.lan)
	echo disabled for your host
	exit 1
	;;
*)
	b=1:1
	t=6500:3500
	;;
esac
while :; do
	log "sleeping $SLEEP"
	sleep $SLEEP
	SLEEP=3
	#redshift -l 46.57:7.27  -b $b -t $t -v  | while read line; do echo "$(date) $line"; done | tee -a $d/$(basename $0 .sh).log
	redshift -l 46.57:7.27  -b $b -t $t -v  | while read line; do log "$line"; done 
done
echo "$(date) end $0 $@"
