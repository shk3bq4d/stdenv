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

echo "FATAL FATAL doesn't parse exec command yet, need to iterate on (multiline) debug3 commands"

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
    cat

exit 0
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



exit 0

# step 0 output
#

User                           hehe                                     # /home/hehe/.ssh/config:48
Port                           23417                                    # /home/hehe/.ssh/config:161
ControlMaster                  auto                                     # /home/hehe/.ssh/config:486
ControlPersist                 12h                                      # /home/hehe/.ssh/config:486
ControlPath                    ~/.ssh/c/%h_%p_%r                        # /home/hehe/.ssh/config:492
ServerAliveInterval            30                                       # /home/hehe/.ssh/config:494
ServerAliveCountMax            5                                        # /home/hehe/.ssh/config:496
SendEnv                        LANG LC_*                                # /home/hehe/.ssh/config:543
HashKnownHosts                 yes                                      # /home/hehe/.ssh/config:543
GSSAPIAuthentication           yes                                      # /home/hehe/.ssh/config:543
GSSAPIDelegateCredentials      no                                       # /home/hehe/.ssh/config:543
AddressFamily                  inet                                     # /home/hehe/.ssh/config:543
ServerAliveInterval            1                                        # /home/hehe/.ssh/config:650
TcpKeepAlive                   yes                                      # /home/hehe/.ssh/config:650
SendEnv                        LANG LC_*                                # /etc/ssh/ssh_config:19
HashKnownHosts                 yes                                      # /etc/ssh/ssh_config:19
GSSAPIAuthentication           yes                                      # /etc/ssh/ssh_config:19
