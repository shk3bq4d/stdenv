#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin


do_pst_file() {
    write_base64 pst "IUJETgAAAAA="
}

write_base64() {
    local b64 ext tmp_file
    ext="$1"
    b64="$2"

    tmp_file=$HOME/tmp/new-mimetype-file.$ext

    echo "$tmp_file"
    echo "$b64" | base64 -d > "$tmp_file"
    ls -l "$tmp_file"
    file "$tmp_file"
}

case "$1" in \
"pst") do_pst_file;;
*)
    >&2 echo "FATAL: unsupported case for $# args $@"
    exit 1
esac

exit 0
