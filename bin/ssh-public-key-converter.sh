#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
##
##Usage:  __SCRIPT__ KEYS..
##convert specified keys in the various public form
##
## Author: Jeff Malone, 02 Apr 2019
##

set -euo pipefail

# function usage() { sed -r -n -e "s/__SCRIPT__/$\(basename $0\)/" -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

[[ $# -lt 1 ]] && echo "FATAL: incorrect number of args" && usage && exit 1

#   h - check for option -h without parameters; gives error on unsupported options;
#   h: - check for option -h with parameter; gives errors on unsupported options;
#   abc - check for options -a, -b, -c; gives errors on unsupported options;
#   :abc - check for options -a, -b, -c; silences errors on unsupported options;
#      Notes: In other words, colon in front of options allows you handle the errors in your code. Variable will contain ? in the case of unsupported option, : in the case of missing value.
# OPTARG - is set to current argument value,
# OPTERR - indicates if Bash should display error messages.
# usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; }
# while getopts ":s:p:h" o; do
#     case "${o}" in
#         s)
#             s=${OPTARG}
#             ! ((s == 45 || s == 90)) && usage && exit 1
#             ;;
#         p)
#             p=${OPTARG}
#             ;;
#         h)
#             usage
#             exit 0
#             ;;
#         *)
#             usage
#             exit 1
#             ;;
#     esac
# done
# shift $((OPTIND-1)) || true
# if [ -z "${s:-}" ] || [ -z "${p:-}" ]; then
#     usage
#     exit 1
# fi
# echo "s = ${s}"
# echo "p = ${p}"
# echo "rest = $@"
#
check_are_files() {
    local var
    for var in "$@"; do
        ! test -f "$var" && { echo "FATAL: not a file $var" && exit 1; } || true
    done
}

process_files() {
    local var
    for var in "$@"; do
        process_file "$var"
    done
}

process_file() {
    local FORMATS f format outfile tmpfile reffile tmpfile2

    f="$1"
    reffile=""
    tmpfile=$(mktemp)

    FORMATS="PKCS8 PEM RFC4716"
    for format in $FORMATS; do
        ssh-keygen -i -m $format -f "$f" > "$tmpfile" 2>/dev/null && reffile="$tmpfile" && break
    done
    if [[ -z "$reffile" ]]; then
        tmpfile2=$(mktemp)
        if ssh-keygen -e -f "$f" > "$tmpfile2"; then
            ssh-keygen -i -f "$tmpfile2" > "$tmpfile"
            rm -f "$tmpfile2"
            reffile="$tmpfile"
        else
            rm -f "$tmpfile2" "$tmpfile"
            echo "FATAL: unrecognized format $f"
            exit 1
        fi
    fi
    # openssh format
    outfile="$(dirname "$f")/$(basename $f .pub).pub"
    if [[ -f "$outfile" ]]; then
        echo "skipping already existing openssh file $outfile"
    else
        #ssh-keygen -i -f "$reffile" > "$outfile"
        cp "$reffile" "$outfile"
        echo "Successfully wrote $outfile"
    fi
    for format in $FORMATS; do
        outfile="$(dirname "$f")/$(basename $f .pub).pub.$format"
        if [[ -f "$outfile" ]]; then
            echo "skipping already existing $format file $outfile"
        else
            ssh-keygen -e -m "$format" -f "$reffile" > "$outfile"
            echo "Successfully wrote $outfile"
        fi
    done
    rm -f "$reffile"
}


for i in ssh-keygen; do ! command -v "$i" &>/dev/null && echo "FATAL: unexisting dependency $i in path: $PATH" && exit 1; done

is_private_key() {
    local f
    f="$1"
    grep -qx "-----BEGIN RSA PRIVATE KEY-----" $f || return 1
    grep -qx "-----END RSA PRIVATE KEY-----" $f || return 1
    [[ $(grep -E "^-----" $f | wc -l) -eq 2 ]] || return 1

    return 0
}

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

#[[ -n ${VIMF6:-} ]] && echo running from vim-f6

# exec > >(tee -a ~/.tmp/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)
#
check_are_files "$@"
process_files "$@"

echo EOF
exit 0

