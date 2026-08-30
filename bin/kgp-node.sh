#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -Eeuo pipefail
shopt -s inherit_errexit
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}:${FUNCNAME[0]:-}: ';

if [[ $# -eq 0 ]]; then
    ARG=.
else
    ARG="$@"
fi

kubectl get nodes --no-headers -o custom-columns=name:.metadata.name | grep -E -- "$ARG" | while read node; do
    echo
    echo "=== $node"
    kgp --field-selector=spec.nodeName=$node --all-namespaces
done
