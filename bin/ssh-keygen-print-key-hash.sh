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
! test -f "$g" && echo "FATAL: not a file $g" && exit 1
for e in MD5 SHA256; do
    ssh-keygen -lf "$g" -E $e 
done
cleanup
exit 0
