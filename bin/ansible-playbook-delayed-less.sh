#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# i=$(ls -1tr ~/.tmp/log/ansible-playbook-delayed-color-* | tail -n 1); { echo $i; cat $i; } | less
mtime() {
    if [[ -n "${NB_DAYS:-}" ]]; then
        echo -n "$NB_DAYS"
        return 0
    fi
    case $(date +%w) in \
    0) echo -n 2;; # Sunday includes Friday and Saturday
    1) echo -n 3;; # Monday includes Friday, Saturday and Sunday
    *) echo -n 1;;
    esac
    return 0
}

files() {
    find . -maxdepth 1 -type f -mtime -$(mtime) -name 'ansible-playbook-delayed-color-*.log*' -not -name '*gz' | xargs --no-run-if-empty ls -1tr
}

list_files() {
    files | xargs --no-run-if-empty ls -ltr | cat -n
}

go() {
    local nb_files
    cd ~/.tmp/log
    nb_files="$(files | wc -l)"
    if [[ "$nb_files" -eq 0 ]]; then
        echo -e "No files within $(mtime) days, try:\nNBDAYS=365 $0 $@"
        exit 1
    fi
    if [[ $# -eq 0 ]]; then
        list_files
    else
        if [[ $nb_files -lt "$1" ]]; then
            echo "No such file A corresponding to: $1"
            exit 1
        fi
        f="$(files | head -n "$1" | tail -1)"
        if [[ -z "$f" ]]; then
            list_files
            echo "No such file B corresponding to: $1"
            exit 1
        fi
        source ~/bin/dot.bashfunctions
        { echo $f; cat $f; echo $f; } | mrless
    fi
}

go "$@"
