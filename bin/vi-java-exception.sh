#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ STACKTRACE_LINE
## opens vi at the right line of the right file
##    STACKTRACE_LINE: something like com.tensorsys.sd2.other.ErrorCodes.process2019ExtractRelatedMt(ErrorCodes.java:249)
##
## Author: Jeff Malone, 12 May 2021
##

set -euo pipefail
umask 027

function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }

if [[ -n ${VIMF6:-} ]]; then
    ARGS="com.haha.sd2.other.ErrorCodes.process2019ExtractRelatedMt(ErrorCodes.java:249)"
    VI_BIN=echo
else
    [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

    [[ $# -lt 1 ]] && echo "FATAL: incorrect number of args" && usage && exit 1
    ARGS="$@"
    VI_BIN=vi
fi

echo "$ARGS" |
    sed -r -e 's/(.* )?([a-zA-Z0-9_.]+)\.([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+)\(([a-zA-Z0-9_.]+):([0-9]+).*/\2 \3 \4 \5 \6/' |
    while read package classname function classfile linenumber; do
        package=$(echo "$package" | tr . /)
        if [[ -z "$classfile" ]]; then
            continue
        fi
        files=$(find $PWD -type f -path "*/$package/$classfile")
        if [[ $( echo "$files" | wc -l ) -eq 1 ]]; then
            #cat >/dev/null # finishes to consume stdin
            bash -c "</dev/tty vim \"$files\" +$linenumber"
            exit $?
        else
            echo close enough!
            echo "$files"
        fi
        #echo "package is $package"
        #echo "classname is $classname"
        #echo "function is $function"
        #echo "classfile is $classfile"
        #echo "linenumber is $linenumber"
    done

exit 1
    sed -r -e 's/.*?([a-zA-Z0-9_.]+)\.([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+)\(([a-zA-Z0-9_]+):([0-9]+)\).*/ppp\1 \2 \3 \4/' |
    sed -r -e 's/([a-zA-Z0-9_.]+)\.([a-zA-Z0-9_]+)\..*/ppp\1 \2/' |
