#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
kubectl get -A --no-headers certificaterequests.cert-manager.io | grep --color=always -E '^| True '
echo -n "Are you sure you want to proceed (yN): " # read
read _read
echo # read
case "${_read,,}" in \
y|yes) true ;; # read
*)   echo "ABORTING"; exit 1;; # read
esac # read

kubectl get -A --no-headers certificaterequests.cert-manager.io | grep -wv True | while read ns obj time; do
    mask=$(sed -r -e 's/-[a-z0-9]{5,6}$//' <<< "$obj")
    echo "---- $ns $mask"
    kubectl get -n $ns --no-headers certificaterequests.cert-manager.io | grep $mask | while read obj2 leftover; do
      echo "Deleting certreq $ns $obj2"
      kubectl delete -n $ns certificaterequests.cert-manager.io $obj2
    done
    kubectl get -n $ns --no-headers certificate.cert-manager.io | grep $mask | while read obj3 leftover; do
      echo "renewing cert $ns $obj3"
      kubectl cert-manager renew -n $ns $obj3
    done
done

echo DONE
exit 0
