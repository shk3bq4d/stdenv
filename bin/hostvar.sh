#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

if [[ $# -ne 1 ]]; then
    >&2 echo "FATAL: nb args != 1 ($#) $@"
    exit 1
fi

source ~/bin/dot.gitfunctions

all_candidates() {
    cat << EOF
/nonexistent2
git/sf/dcn/iaac-master
git/sf/dcn/iaac
git/sf/dcn/iaac-a
git/sf/dcn/iaac-b
git/$(whoami)/haac
EOF
}

found_git_dir() {
    local d g

    d=/nonexistent
    if git_root_dir &>/dev/null; then
        d="$(git_root_dir)"
    fi

    all_candidates | while read g; do
        #>&2 echo "it g is $g d is $d"
        [[ -d "$d/ans/host_vars" ]] && echo "$d" && return 0
        d="$HOME/$g"
    done
}

d="$(found_git_dir)/ans/host_vars"

case "$(ls -1d $d/* | grep -c "$@")" in \
0)
    >&2 echo "FATAL: found zero hosts matching $@"
    exit 1
    ;;
1) true;;
*)
    ls -1d $d/* | grep "$@" | tail -n 10
    >&2 echo "FATAL: found $(ls -1d $d/* | grep -c "$@") hosts matching $@"
    exit 1
    ;;
esac

h="$(ls -1d $d/* | grep -- "$@")"
#ls -1d $d/*
#echo "arg is $@"
#echo d is $d
#echo h is $h
if [[ -d "$h" ]]; then
    if [[ -f "$h/main.yml" ]]; then
        echo "$h/main.yml"
    else
        if [[ 0 -eq $(ls -1d $h/* | wc -l) ]]; then
            >&2 echo "FATAL not hosts found in dir $h"
            exit 1
        fi
        ls -1d $h/* | head -n 1
    fi
else
    echo "$h"
fi
