#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

kubectl get --show-kind=true ingress.extensions "$@"
kubectl get --show-kind=true ingresses.networking.k8s.io "$@"
kubectl get --show-kind=true orders.acme.cert-manager.io "$@" | grep -E --color=always "^|invalid"
kubectl get --show-kind=true certificates.cert-manager.io "$@"
kubectl get --show-kind=true certificaterequests.cert-manager.io "$@"
kubectl get --show-kind=true certificatesigningrequests.certificates.k8s.io "$@"

echo "
kubectl delete certificaterequest XYZ
# https://cert-manager.io/docs/usage/kubectl-plugin/
kubectl cert-manager renew ABC
"
