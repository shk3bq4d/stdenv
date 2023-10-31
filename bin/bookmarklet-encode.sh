#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp);   function cleanup() { [[ -n "${_tempfile:-}" ]] && [[ -f "$_tempfile" ]] && rm  -f "$_tempfile" || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
content() {
    cat </dev/null << EOF
(function() {
try {
$(grep -vE '^#!' "$@")
}
catch (__) { alert('exception'); }})()
EOF
}
#    yui-compressor --type js
#
{
echo -n "javascript:"
content "$@" | yui-compressor --type js | url_encode_bookmarklet.py
}
> $_tempfile

cat $_tempfile
xclip < $_tempfile
echo ""
exit 0
