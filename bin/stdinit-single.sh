#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 22 Dec 2017
##

set -euxo pipefail
unset GIT_DIR
unset GIT_WORK_TREE

c=$(git rev-parse --show-toplevel)
g=$(git rev-parse --git-dir)
curbranch=$(git rev-parse --abbrev-ref HEAD)
d=$c/.mrgit/$curbranch
if [[ -d $d ]]; then
	cd $d
	find . -type f | while read f; do
		ln -is $d/${f:2} $g/${f:2}
	done
fi
	

echo EOF
exit 0

