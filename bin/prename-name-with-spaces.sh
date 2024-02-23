#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

filters() {
    cat << 'EOF'
--null
--filename
--unicode
-e s/a/__/g
-
EOF

}

error() {
    echo -ne "\033[0;31m"
    echo "$@"
    echo -ne "\033[m"
}

_prename() {
    prename \
        "$@" \
        --null \
        --filename \
        --unicode \
        -e '
s/[(){} \-]+/-/g;
s/-\././g
';
}

files() {
    if [[ $# -eq 0 ]]; then
        find -maxdepth 1 -print0
    else
         find "$@" -maxdepth 0 -print 0
    fi

}

if false; then
    echo "Filelist:"
    files "$@" | xargs -0 -n 1 echo | sort
    echo "/Filelist"
fi

if ! files "$@" | _prename --nono &>/dev/null; then
    error "FATAL: exited with error"
    files "$@" | _prename --nono
    exit 1
fi

if files "$@" | _prename --nono 2>&1 | grep -qE "syntax error|not renamed|already exists"; then
    files "$@" | _prename --nono | grep -E --color=always "^|not renamed" || true
    error "FATAL: some where possibly not renamed"
    exit 1
fi

echo "exit code is $?"
files "$@" | _prename --verbose

#ls -1

echo success
exit 0
-e s/[()\s]+/-/g
-e s/-{2,}/-/g
        -e 's/-{2,}/-/g' \
