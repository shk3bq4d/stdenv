#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

type start_agent_if_not_started >/dev/null 2>&1 || source ~/bin/dot.bashfunctions
start_agent_if_not_started
_tempdir=$(mktemp -d); function cleanup() { [[ -n ${_tempdir:-} ]]  && [[ -d $_tempdir ]]  && rm -rf $_tempdir  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

ongoing=$_tempdir/ongoing
ansible-playbook-delayed-ongoing.sh > $_tempdir/ongoing

candidate_flag_files() {
    ls -1 $HOME/.tmp/ansible-playbook-delayed-*
}

process_file() {
    local file args TTS args
    file="$1"
    echo -e "\n\n=================== Processing $file"

    if grep -aqE "command rm -f $file"'\s*$' $ongoing; then
        echo "Skipping $file as a matching ongoing process runs"
        return 0
    fi

    CWD="$( grep -Po '(?<=CWD is ).*'   $file || true)"
    TTS="$( grep -Po '(?<=TTS is ).*'   $file || true)"
    args="$(grep -Po '(?<=args are ).*' $file || true)"

    if [[ -z "$TTS" ]]; then
        echo "skipping file due to missing TTS"
        return 0
    fi
    echo "TTS is $TTS"

    if [[ -z "$CWD" ]]; then
        echo "skipping file due to missing CWD"
        return 0
    fi
    echo "CWD is $CWD"

    if [[ "$TTS" -lt "$(date +%s)" ]]; then
        echo "skipping due to TTS in the past"
        return 0
    fi

    if [[ -z "$args" ]]; then
        echo "skipping file due to missing args"
        return 0 # since I have a clean log message, I'm fine with returning zero
    fi
    echo "args are $args"

    cd $CWD
    rm "$file"
    setsid ansible-playbook-delayed-detached.sh "@$TTS" $args
}


go() {
    local file
    candidate_flag_files | while read file; do
        if ! process_file $file; then
            echo "Skipping $file due to failure"
        fi
    done
}

go
