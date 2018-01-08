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
if ! git rev-parse --abbrev-ref HEAD &>/dev/null; then
	echo "ABORTING with exit code 0 as repo likely has no revision due to impossibly to have fetched remote?"
	exit 0
fi
curbranch=$(git rev-parse --abbrev-ref HEAD)
gitdir="$(readlink -f "$(git rev-parse --git-dir)")"
mrgit_dir=$worktree/.mrgit/$curbranch
if [[ -d $mrgit_dir ]]; then
	cd $mrgit_dir
	find . -type f | while read f; do
		</dev/tty ln -fs $mrgit_dir/${f:2} $gitdir/${f:2}
	done
fi

repo_file=$worktree/.mrgit/${curbranch}-repo.txt
if [[ -f $repo_file ]]; then
	cat $repo_file | while read dir url; do
		dir="$worktree/$dir"
		[[ -d "$dir" ]] && continue
		parentdir="$(dirname "$dir")"
		[[ -d "$parentdir" ]] || mkdir -p "$parentdir"
	    git clone $url "$dir"
	done
fi
	
if false; then
module_file=$worktree/.mrgit/${curbranch}.modules
if [[ -f $module_file ]]; then
	cd $worktree
	git config -f $module_file --get-regexp '^submodule\..*\.path$' |
		while read path_key path
		do
			url_key=$(echo $path_key | sed 's/\.path/.url/')
			url=$(git config -f $module_file --get "$url_key")
			git --git-dir=$gitdir submodule status $path &>/dev/null || \
				git --git-dir=$gitdir submodule add $url $path
		done
	[[ -f $worktree/.gitmodules ]] && git --git-dir=$gitdir rm --force $worktree/.gitmodules
fi
fi
	

echo EOF
exit 0

