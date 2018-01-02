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

while :; do
	worktree=$(git rev-parse --show-toplevel)
	[[ -n $worktree ]] && break
	cd ..
done
gitdir="$(readlink -f "$(git rev-parse --git-dir)")"
curbranch=$(git rev-parse --abbrev-ref HEAD)
mrgit_dir=$worktree/.mrgit/$curbranch
if [[ -d $mrgit_dir ]]; then
	cd $mrgit_dir
	find . -type f | while read f; do
		</dev/tty ln -fs $mrgit_dir/${f:2} $gitdir/${f:2}
	done
fi
	

echo EOF
exit 0

