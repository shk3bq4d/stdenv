#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# a) global replace of each IP with "newline + IP"
# b) print only lines that start with IP + swallows content after IP adress 
# c) sort and keep unique

sed -r   -e 's/(((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5]))/\n\1/g' "$@" |
   sed -r -n -e 's/(((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])).*/\1/p' | 
   sort -u
