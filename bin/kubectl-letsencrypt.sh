#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

kubectl get ingress.extensions "$@"
kubectl get ingresses.networking.k8s.io "$@"
kubectl get orders.acme.cert-manager.io "$@"
kubectl get certificates.cert-manager.io "$@"
kubectl get certificaterequests.cert-manager.io "$@"
kubectl get certificatesigningrequests.certificates.k8s.io "$@"
