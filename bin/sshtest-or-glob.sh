#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 21 Jan 2018
##

set -euo pipefail

exec > >(tee -a ~/.tmp/sshtest-or-glob.log)
exec 2>&1

ARG1="$1"
shift
#set -f # disable bash shell expansion
for arg in "$@"; do
	[[ "$ARG1" = $arg ]] && exit 0
done
exit 1

