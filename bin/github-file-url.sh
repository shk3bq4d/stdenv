#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';


if [[ ! -f "$1" ]]; then
    >&2 echo "FATAL: not a file $1"
    exit 1
fi
FILE="$(readlink -f "$1")"

source ~/bin/dot.gitfunctions

root_dir="$(git_root_dir)"
#echo FILE is $FILE
#echo root_dir is $root_dir
relative_file=${FILE:${#root_dir}+1}
#echo $relative_file

git remote | while read remote; do
    url="$(git config remote.$remote.url)"
    remote_branch=$(git_current_branch_s_remote | grep -Po '(?<=/).*')
    case "$url" in \
    https://github.com/*)
        echo "$url/blob/$remote_branch/$relative_file"
        # https://github.com/zabbix/zabbix/blob/00cece2e8251f309bc2220bab71c10e1a7fec357/src/go/plugins/systemd/systemd.go
        echo "$url/blob/$(git_current_rev)/$relative_file"

        # https://raw.githubusercontent.com/zabbix/zabbix/refs/heads/master/src/go/plugins/systemd/systemd.go
        echo "${url//github.com/raw.githubusercontent.com}/refs/heads/$remote_branch/$relative_file"

        # https://raw.githubusercontent.com/zabbix/zabbix/00cece2e8251f309bc2220bab71c10e1a7fec357/src/go/plugins/systemd/systemd.go
        echo "${url//github.com/raw.githubusercontent.com}/$(git_current_rev)/$relative_file"
        ;;
    esac
done
