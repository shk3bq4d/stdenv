#!/usr/bin/env bash

set -e
cd /tmp
#ln -fs $(which true) /tmp/urxvt
#export PATH=/tmp:$PATH
export MRURXVT_EXIT_EARLY=1
nice -n 19 bash -c 'while :; do mrurxvt; sleep 1; done'
