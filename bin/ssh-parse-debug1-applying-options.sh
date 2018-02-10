#!/usr/bin/env bash                                            
# ex: set filetype=sh expandtab :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 10 Feb 2018
##

set -euo pipefail

ssh -v "$@" 2> >(cat - | \
    sed -u -r -n -e 's/^debug1: (.+) line ([0-9]+): Applying options for .*/\1 \2/ p' | \
    while read f line; do
        #echo -n -e "\n$f:$line "
        sed -r -n -e "$line,/^[ \t]*(Host|Match) / p" $f | \
            tail -n +2 | \
            head -n -1 | \
            sed -e 's/#.*//' | \
            sed -e '/^\s*$/ d' | \
            while read command options; do
                printf "%-30s %-40s # %s:%d\n" "$command" "$options" "$f" $line
            done
    done | \
python -u -c "
#@begin=python@
import fileinput
import sys
a = []
for line in fileinput.input():
    line = line.strip()
    if line == '': continue
    first_arg = line.split()[0]
    if first_arg in a: continue
    a.append(first_arg)
    #print('coucou {}'.format(line))
    print(line)
    sys.stdout.flush()
#@end=python@
" )
