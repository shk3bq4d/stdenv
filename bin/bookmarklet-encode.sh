#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

content() {
    cat </dev/null << EOF
(function() {
try {
$(grep -vE '^#!' "$@")
}
catch (__) { alert('exception'); }})()
EOF
}


{
    echo -n "javascript:"
    content "$@" | yui-compressor --type js | sed -r -e 's/;$//' | url_encode_bookmarklet.py
} | xclip-tee.sh

echo ""
echo "bookmarklet-encode success"

exit 0
