#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 03 Dec 2017
##

set -euo pipefail
D="$(basename "$0" -add.sh)"
D="${D:3}"
D="$(stdhome-dirname.sh)/../std$D"
[[ ! -d "$D" ]] && echo "FATAL: not a dir $D" && exit 1
D=$(readlink -f "$D")

for f in "$@"; do
	if [[ -h "$f" ]]; then
		echo "FATAL: rejecting symlinks $f"
		exit 1
	fi
	if [[ ! -f "$f" ]]; then
		echo "FATAL: not a file $f"
		exit 1
	fi
	if stdidentify.sh -s "$f" &>/dev/null; then
		echo "FATAL: $f as it belongs to $(stdidentify.sh -s "$f")"
		exit 1
	fi
done
export GIT_DIR="$D/.git"
export GIT_WORK_TREE="$HOME"

git add "$@"
git diff
read -n1 -p "Commit? [y,N]" doit <&0
case $doit in  \
	y|Y)
		stdhome-commit.sh
		;;
esac
