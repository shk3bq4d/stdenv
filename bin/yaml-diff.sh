#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ FILE1 FILE2 [FILES]
##produces a diff of yaml files
##
## Author: Jeff Malone, 12 Oct 2021
##

set -euo pipefail
umask 027

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 1 ]] && echo "FATAL: incorrect number of args" && usage && exit 1


_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" && -d "$_tempdir" ]] && rm -rf $_tempdir || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM EXIT

files0() {
    find "$_tempdir" -type f -print0
}

for file in "$@"; do
    filename="$(basename "$file")"
    orig_dirname="$(realpath "$(dirname "$file")")"
    newdirname="${_tempdir}${orig_dirname}"
    mkdir -p "$newdirname"
    if false; then
        # I've got some differences with
        # key y: and 'y':
        # |- and | multiline strings
        cp -f "$file" "$newdirname"
        yq eval -P -i 'sortKeys(..)' "$newdirname/$filename"
    else
        yq eval --output-format=json 'sortKeys(..)' "$file" |
            yq e -P - >"$newdirname/$filename"
            # replace with cat if you'd like to compare as JSON (helps with white chars)
            # cat >"$newdirname/$filename"
    fi
done


if [[ $(files0 | grep -zc ^) -le 1 ]]; then
    echo "FATAL: could only find one file, did you specify twice the identical file?"
    exit 1
fi

if [[ "$(basename $0)" == *vim* ]]; then
    files0 | xargs -0 bash -c '</dev/tty vim -d $@' ignoreme
else
    files0 | xargs -0 diff
fi

cleanup
exit 0
