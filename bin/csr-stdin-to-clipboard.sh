#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
tempdir=$(mktemp -d); function cleanup() { [[ -n ${_tempdir:-} ]]  && [[ -d $_tempdir ]]  && rm -rf $_tempdir  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

mkdir $tempdir/orig
mkdir $tempdir/reco

cat_all() {
    if [[ $# -eq 0 ]]; then
        cat -- -
    else
        for arg in "$@"; do
            test -d "$arg" && continue
            cat -- "$arg"
        done
    fi
    return 0
}

remove_non_unique_files() {
    # https://superuser.com/questions/386199/how-to-remove-duplicated-files-in-a-directory
    # https://superuser.com/a/386209
    set +u
    declare -A arr
    shopt -s globstar

    for file in "$@"; do
      [[ -f "$file" ]] || continue

      read cksm _ < <(md5sum "$file")
      if ((arr[$cksm]++)); then
        echo "remove duplicate $file"
        rm "$file"
      fi
    done
    set -u
}

reconstruct_cert() {
    echo "$a"
    cat $f | sed -r -e 's/^ +//'
    echo "$b"
}
a="-----BEGIN CERTIFICATE REQUEST-----"
b="-----END CERTIFICATE REQUEST-----"

p() {
    >&2 echo -n "$@: "
    read _r </dev/tty
    >&2 echo ""
    echo "$_r"
}

e() {
    local cmd msg
    cmd="$1"
    msg="$2"
    while :; do
        eval "$cmd"
        _break="$(p "$msg  is now in clipboard, press enter to continue, or any other key to reset clipboard")"
        test -z "$_break" && break
    done
}


go() {
    cat_all "$@" |
        sed_remove_colors.sh |
        awk "/$a/{f=1;s=\"$tempdir/orig/FILE\"++i;next}/$b/{f=0;close(s)}f{print > s}"

    remove_non_unique_files $tempdir/orig/*
    for f in $tempdir/orig/*; do
        g=$tempdir/reco/$(basename "$f")
        reconstruct_cert $f > $g
        echo "-------------------- $f"
        openssl-output-csr.sh $g | grep -EA1 'Subject:|X509v3 Subject Alternative Name: ' | grep -E 'Subject:|DNS:|IP:'
        cmd="cat $g | xclip"
        e "$cmd" "CSR"
        #cat $f
    done
#   fdupes -N .
#   for f in $tempdir/*; do
#       reconstruct_cert $f |
#         openssl-cert-info.sh 2>/dev/null |
#         grep -EA 1 'subject=|X509v3 Subject Alternative Name:' |
#         grep -E 'subject=|DNS:|IP:' |
#         while read line; do
#             case $line in \
#             subject=*) echo "$line";;
#             DNS:*) echo "SAN: $line";;
#             IP:*) echo "SAN: $line";;
#             esac
#         done

#     reconstruct_cert $f
#     echo ""

#   done
    #md5sum * | sort
}


if [[ -n ${VIMF6:-} ]]; then
    cat /tmp/.7sztlvIeM7U | go
else
    go "$@"
fi
cleanup
exit 0
