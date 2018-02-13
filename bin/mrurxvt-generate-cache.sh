#!/usr/bin/env bash

set -e
cd /tmp
ln -f $(which true) /tmp/mrurxt
export PATH=/tmp:$PATH
nice -n 19 bash -c 'while :; do mrurxvt; sleep 1; done'
