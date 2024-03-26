#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
target_file="$PWD/$(date +'%Y.%m.%d-%H.%M.%S')-$(basename "$0" .sh).txt"
echo "$(date) Writing test file in $target_file"
echo -n 'X5' >$target_file
echo -n 'O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' >>$target_file
ls -l $target_file
echo "$(date) done"
exit 0
