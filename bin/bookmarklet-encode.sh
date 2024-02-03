#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_tempfile=$(mktemp);   function cleanup() { [[ -n "${_tempfile:-}" ]] && [[ -f "$_tempfile" ]] && rm  -f "$_tempfile" || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT
munge() {
    case "$1" in
    *nomunge*) echo -n " --nomunge ";;
    esac
    return 0
}

content() {
    cat </dev/null << EOF
(function() {
try {
$(grep -vE '^#!' "$@")
}
catch (__) { alert('exception\n' + __.message); console.log(__);}})()
EOF
}


{
    # 2024.01.30 removing the j in javascript as there seem te be something like windows defender snooping on my data and crashing
    echo -n "avascript:"
    content "$@" | yui-compressor $(munge "$0") --type js | sed -r -e 's/;$//' -e "s/__BOOKMARKLET_DATE__/$(date +'%Y.%m.%d %H:%M:%S')/" | url_encode_bookmarklet.py
} > $_tempfile
cat $_tempfile | xclip-tee.sh

echo ""
# maximum length sources
# * https://support.mozilla.org/en-US/questions/1259005
# * https://stackoverflow.com/a/3413739
echo "bookmarklet-encode success, length is $(stat --printf="%s" $_tempfile) and maximum supported is 65535"

exit 0
