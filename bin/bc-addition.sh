#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# https://stackoverflow.com/questions/35096253/add-numbers-from-file-and-standard-input
{ tr -s ' \t\n' '\n' |
    grep -x -- '-\{0,1\}[0-9][0-9]*' |
      tr '\n' '+'; printf '0\n'; } < "${1-/dev/stdin}"  | bc
