#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

_tempdir=$(mktemp -d); function cleanup() { [[ -n ${_tempdir:-} ]]  && [[ -d $_tempdir ]]  && rm -rf $_tempdir  || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

flags() {
    cat << 'EOF'
avx
avx2
fma
bmi1
bmi2
abm
movbe
popcnt
sse4_1|sse4_2
EOF
}

file=$_tempdir/f
grep flags "$@" | head -n 1 > $file || true
#cat $file

for f in $(flags); do
    echo -n "$f "
    grep -qwE "$f" "$file" && echo ok || echo KO
done
