#!/usr/bin/env bash

set -e
set -x
DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
#mgetty
screen -wipe || true
command -v mitmdump &>/dev/null || export PATH=~/.local/bin/:$PATH

if ! screen -ls bonjour | grep -q bonjour; then
	screen -dmS bonjour bash
	sleep 1
	screen -S bonjour -p 0 -X title explicit_run
fi
list=$(screen -S bonjour -Q windows)
#for i in explicit_run explicit_log transparent_run transparent_log; do
for i in explicit_run; do
	if [[ $list != *${i}* ]]; then
		screen -S bonjour -X screen
		screen -S bonjour -X title $i
	fi
done
screen -S bonjour -p explicit_run    -X stuff "mitmdump --host --port 8080 -w explicit_proxy\n"
exit 0
screen -S bonjour -p explicit_run    -X stuff "mitmdump -s $DIR/mr.py --host --port 8080 -w explicit_proxy\n"
screen -S bonjour -p transparent_run -X stuff "mitmdump -T --host --port 8081 -w transparent_proxy\n"


screen -S bonjour -p explicit_log    -X stuff "tail -f explicit_proxy\n"
screen -S bonjour -p transparent_log -X stuff "tail -f transparent_proxy\n"
