#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp);   function cleanup() { [[ -n "${_tempfile:-}" ]] && [[ -f "$_tempfile" ]] && rm  -f "$_tempfile" || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
if [[ $# -eq 0 ]]; then
    cat > $_tempfile
    g="$_tempfile"
else
    g="$@"
fi
for g2 in $g; do
    echo "file $g2"
    ! test -f "$g2" && echo "FATAL: not a file $g2" && exit 1
    for e in MD5 SHA256; do
        ssh-keygen -lf "$g2" -E $e
    done
done
cleanup
exit 0
