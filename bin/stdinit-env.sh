#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, March 6 2018
##

set -euo pipefail
set -x
unset GIT_DIR
unset GIT_WORK_TREE

github=github
githuburl=https://github.com/shk3bq4d/
githubpushurl=https://github.com/shk3bq4d/

addremote() {
	if git remote | grep -q $1; then
		git remote set-url $1 $2
		if [[ $# -eq 2 ]]; then
			git remote set-url --push $1 $2
		else
			git remote set-url --push $1 $3
		fi
	else
		if ! git remote add -f $1 $2; then
			git remote rm $1 || true
			return 0
		fi
	fi
	if git fetch $1; then
		set +e
		git remote show | grep -vw $1 | while read line; do
			git remote rm $line
		done
		set -e
	else
		git remote rm $1
	fi
}
sudo=SUDO
hash sudo 2>/dev/null || SUDO=""
hash git 2>/dev/null || { $SUDO apt update && $SUDO apt install -y git; }

case $HOSTNAME in \
	"")
		if hash ips &>/dev/null; then
			domain=$(ips | grep -vE '^(lo\>|docker|internet)' | head -n 1 | awk '{ print $2 }')
		else
			domain=nodomainset
		fi
		;;
	*)
		domain=$HOSTNAME
		;;
esac
git_name="Jeff Malone"
git_email="jeff@$domain"

git_init() {
	local checkout_dir
	local i
	local r
	local n
	local m
	i=$1
	n=$2
	m=$3

	cd $i

	if (( $m )) && [[ $n != stdhome ]]; then
		r=${n}noexternalcheckout
	else
		r=${n}
	fi

	proceed=1
	if [[ -d $r ]]; then
		proceed=0
		if false; then
		read -p "rm -rf $(readlink -f $r) ?? Ctr-C to abort all, y to confirm $r or other to skip: " a
		if [[ "$a" == y ]]; then
			proceed=1
			rm -rf $r
		fi
		fi
	fi
	if (( $proceed )); then
		git init $r
	fi
	
	cd $r

	git config user.name "$git_name"
	git config user.email "$git_email"
	git config branch.autosetupmerge always
	if (( $m )); then
		git config --unset-all status.showuntrackedfiles || true
		git config --unset-all core.worktree || true
		checkout_dir=$PWD
	else
		git config status.showuntrackedfiles  no
		git config core.worktree ~
		checkout_dir=$HOME
	fi
	case "$n" in \
	stdenv|stdhome) addremote $github    ${githuburl}${n}.git    ${githubpushurl}${n}.git ;;
	*)
		echo "FATAL: unhandled case $n"
		exit 1
	esac

	for remote in $(git remote); do
		git checkout -fb $n $remote/$n || continue
		break
	done
	git branch -D master || true
	#git --git-dir=$PWD/.git submodule update --init --recursive
}

s=/dev/null
if hash stdhome-dirname.sh 2>/dev/null; then
	STDHOME_DIRNAME=$(stdhome-dirname.sh)
	s=$STDHOME_DIRNAME/..
	cd $STDHOME_DIRNAME
	git config user.name "$git_name"
	git config user.email "$git_email"
	git config branch.autosetupmerge always
	git config --unset-all status.showuntrackedfiles || true
	git config --unset-all core.worktree || true
fi

for i in \
	$s \
	~/git/$USER \
	; do
	if [[ -d $i ]]; then
		break
	fi
done
[[ ! -d $i ]] && mkdir -p $i
git_init $i stdhome 1 && $i/stdhome/bin/stdhome-install.sh

for r in env; do

	n=std$r

	git_init $i $n 0 
done
for r in env; do
	cd $i/std${r}                   && ~/bin/stdinit-single.sh
done
r=home
	cd $i/std${r}                   && ~/bin/stdinit-single.sh

set -x
echo EOF
exit 0

