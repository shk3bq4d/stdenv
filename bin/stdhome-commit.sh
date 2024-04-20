#!/usr/bin/env bash

set -e
if [[ $# -gt 0 ]]; then
    case "$1" in \
    feb22*|may19*|shaz*|apr16*|charlotte)
		# not readay yet as I need to load the ssh-agent
        ssh "$1" bin/stdhome-commit.sh
        ;;
    *)
        echo sleep "$@"
        sleep "$@"
        ;;
    esac
fi
unset GIT_DIR
unset GIT_WORK_TREE
~/bin/stdothers.sh | grep -vE 'stdks' | while read repo; do
    if [[ "$repo" == *stdtsys ]]; then
        continue
    fi
    cd $repo
    git commit -am "auto commit $(date)" || true
done
~/bin/stdhome-pull.sh
~/bin/stdhome-push.sh
