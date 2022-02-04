#!/usr/bin/env bash
# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

set -euo pipefail

 function cleanup() { [[ -n "${_tempfile:-}" && -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
_tempfile=""
if [[ $# -eq 0 ]]; then
    _tempfile=$(mktemp);
    cat - |
        sed -r \
          -e '/^\s*$/ d' \
          -e 's/^\s+|\s+$//g'  \
        > $_tempfile
    ARG=$_tempfile
else
    ARG="$@"
fi

test -t 1 && tty_ouput=1 || tty_ouput=0
colorize() {
    if (( $tty_ouput )); then
        grep --color=always -E '^|CN = [^,]+|X509v3 Subject Alternative Name|IP Address:.*|DNS:.*' -
    else
        cat -
    fi
}

openssl req -text -noout -verify -in "$ARG" 2>&1 |
    sed -r -e '/(:[a-f0-9]{2}){5,}/ d' |
    colorize |
    less -M --raw-control-chars --quit-if-one-screen --ignore-case --status-column --no-init

cleanup
exit 0
