#!/usr/bin/env bash


SCRIPT="$1"
LOG="$2"
exec > >(tee "$LOG")
exec 2>&1

if [[ -x "$SCRIPT" ]]; then
	$SCRIPT
else
	FIRSTLINE=$(head -n 1 $SCRIPT)
	if [[ $FIRSTLINE =~ ^#!.* ]]; then
		CMD=$(echo "$FIRSTLINE" | sed -r -e 's/^..//')
		$CMD $SCRIPT
	else
		case "$SCRIPT" in \
		*sh)  bash $SCRIPT;;
		*py)  python2 $SCRIPT;;
		*pl)  perl $SCRIPT;;
		*php) php $SCRIPT;;
		*md)  
			f=~/.local/bin/grip
			if [[ ! -x "$f" ]]; then
				echo "$0 FATAL $f, run pip install --user grip"
				exit 1
			fi
			if pgrep grip &>/dev/null; then
				echo "$0 INFO killing current existing grip session with PID $(pgrep grip)"
				pkill -9 grip
			fi
			echo "$0 starting background grip preview should starting in new browser tab"
			nohup ~/.local/bin/grip --quiet --title "$SCRIPT" -b $SCRIPT &>/dev/null &
			;;
		*txt)
			echo "($(basename $0)): ignored for filetype $SCRIPT"
			exit 0
			;;
		*)
			echo "($(basename $0)): unimplemented case for script $SCRIPT"
			exit 1
			;;
		esac
	fi
fi
