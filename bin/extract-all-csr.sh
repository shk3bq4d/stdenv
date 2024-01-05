#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"
tempdir=$(mktemp -d); function cleanup() { [[ -n ${_tempdir:-} ]]  && [[ -d $_tempdir ]]  && rm -rf $_tempdir  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

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

reconstruct_csr() {
    echo "$a"
    cat $f | sed -r -e 's/^ +//'
    echo "$b"
}
a="-----BEGIN CERTIFICATE REQUEST-----"
b="-----END CERTIFICATE REQUEST-----"

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

go() {
    cat_all "$@" |
        sed_remove_colors.sh |
        awk "/$a/{f=1;s=\"$tempdir/FILE\"++i;next}/$b/{f=0;close(s)}f{print > s}"
#       awk "/$a/,/$b/"'{print > "output_file"++c; next} {print > "output_file"c}'
#       sed -n -e "/$a/,/$b/p"

    remove_non_unique_files $tempdir/*
#   fdupes -N .
    for f in $tempdir/*; do
        reconstruct_csr $f |
          openssl-output-csr.sh |
          grep -EA 1 'Subject:|X509v3 Subject Alternative Name:' |
          grep -E 'Subject:|DNS:|IP:' |
          while read line; do
              case $line in \
              Subject:*) echo -n "$line";;
              *) echo -n ", SAN: $line";;
              esac
          done

      echo ""
      reconstruct_csr $f
      echo ""

    done
    #md5sum * | sort
}

if [[ -n ${VIMF6:-} ]]; then
    cat ~/tmp/csr.log | go

else
    go "$@"
fi
cleanup
exit 0
