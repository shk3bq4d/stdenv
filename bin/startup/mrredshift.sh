#!/usr/bin/env bash

set -e

. ~/bin/dot.lockfunctions

exlock_now || { echo "$(date) can't start as flock'ed" && exit 1; } 
echo "$(date) Startup $0 $@"
redshift -l 46.57:7.27  -v  | while read line; do echo "$(date) $line"; done | tee -a ~/log/startup/$(basename $0 .sh).log
echo "$(date) end $0 $@"
