#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

#COMMIT_HOME=e59212f734c59df2d10b27d4872a3a6d12b359e7
#COMMIT_ENV=fd45cb44be9601681633478ed5ed0a748798e222

STDHOME_DIRNAME=$(stdhome-dirname.sh)
for i in \
    /. \
    ; do
    j=$STDHOME_DIRNAME/$i
    cd $j
    pwd
    test -d .git || continue
    git fetch --all
    git reset --hard $(git remote | head -n 1)/stdhome
done

for i in \
    $STDHOME_DIRNAME/../stdenv* \
    ; do
    cd $i
    pwd
    test -d .git || continue
    git fetch --all
    git reset --hard $(git remote | head -n 1)/stdenv
done
