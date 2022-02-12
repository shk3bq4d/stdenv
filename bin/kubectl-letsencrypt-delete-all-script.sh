#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

{
kubectl get -A --no-headers --show-kind=true orders.acme.cert-manager.io "$@" 
#kubectl get -A --no-headers --show-kind=true certificates.cert-manager.io "$@"
kubectl get -A --no-headers --show-kind=true certificaterequests.cert-manager.io "$@"
} | while read a b c; do
    echo "kubectl delete -n $a $b;"
done
