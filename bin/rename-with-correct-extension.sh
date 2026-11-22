#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
# date '+%a %b %d %H:%M' -d @1747872031
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';


process_all() {
    for f in "$@"; do
        process_file $f
    done
}

process_file() {
    local ext
    ! test -f "$1" && >&2 echo "FATAL: not a file $1" && exit 1
    ext="$(file --separator : --extension "$1" |awk '{print $NF}' | cut -d : -f 1)"
    case "${ext}" in \
    "???")
        true;;
    *)
        rename_file "$1" "$ext"
        return
        ;;
    esac
    case "$(file "$1")" in \
    *)
        >&2 echo "FATAL: unknown extension for $(file "$1")"
        exit 1
        ;;
    esac
}

rename_file() {
    local filename="$1" ext="$2" currentextension target

    currentextension="${filename##*.}"
    if [[ "$ext" == "$currentextension" ]]; then
        >&2 echo "NOOP for $filename"
    else
        if [[ -z "${currentextension}" ]]; then
            target="$filename"."$ext"
        else
            target="$(basename $filename .$currentextension)"."$ext"
        fi
        if [[ -e "$target" ]]; then
            >&2 echo "FATAL: $target already exists"
            exit 1
        fi
        >&2 echo "$filename -> $target"
        mv "$filename" "$target"
    fi
}

process_all "$@"
