#!/usr/bin/env bash

set -eu
#DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
source ~/bin/dot.bashfunctions
DIR=$PWD
exec() {
	cd $DIR
	if [[ -d $1 ]]; then
		cd $1
		FILE=$PWD
	else
		cd $(dirname $1)
		FILE=$PWD/$(basename $1)
	fi
	#DIR2="$( cd -P "$( dirname "$(readlink -f ".")" )" && pwd )"
	#echo $DIR2
	ROOT=$(git_root_dir)
	GITBRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	URL=$(git config remote.origin.url)
	H=$(git log -1 --format='%H' $FILE)
	if [[ $URL == http* ]]; then
		true
	elif [[ $URL == *git.burp.com* ]]; then
		URL=$(echo "$URL" | sed -r -e '/^git@git.burp.com/s/^([^@]+@)?([^:]+):([^\/]+)\/(.*).git/https:\/\/gitlab.burp.com\/\3\/\4/')
	else
		URL=$(echo "$URL" | sed -r -e 's/^([^@]+@)?([^:]+):([^\/]+)\/(.*).git/https:\/\/\2\/\3\/\4/')
	fi
	COMMIT_URL="$URL/commit/$H"
	echo $URL
	OUT="$URL/blob/$GITBRANCH/${FILE:${#ROOT}+1}"
	name=$(basename $FILE)
	echo ""
	echo "jira sd:       [$name|$OUT]"
	echo ""
	echo "gitlab:        [$name]($OUT)"
	echo "markdown:      [$name]($OUT)"
	echo "mattermost:    [$name]($OUT)"
	echo ""
	echo "commit:        $COMMIT_URL"
	echo "jira commit:   [${H:0:8}|$COMMIT_URL"]
	echo "raw:           $OUT"
	echo ""
}
if [[ $# -eq 0 ]]; then
	exec .
else
	for var in "$@"; do
		exec $var
	done
fi

