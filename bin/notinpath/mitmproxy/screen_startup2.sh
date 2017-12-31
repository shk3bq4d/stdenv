#!/usr/bin/env bash

set -e
set -x
date
DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
command -v mitmdump &>/dev/null || export PATH=$PATH:~/.local/bin/
#mgetty
screen -wipe || true
pkill -9 tail || true
pkill -9 python || true
pkill -9 screen || true
sleep 3
screen -wipe || true

if ! screen -ls bonjour | grep -q bonjour; then
	screen -dmS bonjour bash
	sleep 1
	screen -S bonjour -p 0 -X title explicit_run
	sleep 1
fi
list=$(screen -S bonjour -Q windows)
echo "list is $list"
#for i in explicit_run explicit_log transparent_run transparent_log; do
for i in explicit_run; do
	if [[ $list != *${i}* ]]; then
		sleep 1
		screen -S bonjour -X screen
		sleep 1
		screen -S bonjour -X title $i
	fi
done
sleep 1
screen -S bonjour -p explicit_run    -X stuff "mitmdump --host --port 8080 -w explicit_proxy\n"

echo EOF
