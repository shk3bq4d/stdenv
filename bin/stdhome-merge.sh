#!/usr/bin/env bash

set -e
source ~/bin/dot.lockfunctions
exlock_now || { echo "Couldn't aquire exclusive lock" && exit 1; }
unset GIT_DIR
unset GIT_WORK_TREE

set -x
~/bin/stdothers.sh | while read repo; do
	git remote show | grep -q . && \
		git merge -m automerge $(git remote show | sed -r -e "s/$/\\/$branch/")
	set +x
done
exit 0
