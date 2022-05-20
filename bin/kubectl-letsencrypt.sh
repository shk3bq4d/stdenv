#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027

#kubectl get -A --show-kind=true ingress.extensions "$@"
kubectl get -A --show-kind=true ingress "$@"
kubectl get -A --show-kind=true ingresses.networking.k8s.io "$@"
kubectl get -A --show-kind=true orders.acme.cert-manager.io "$@" | grep -E --color=always "^|invalid"
kubectl get -A --show-kind=true certificates.cert-manager.io "$@"| grep -E --color=always "^|True"
kubectl get -A --show-kind=true certificaterequests.cert-manager.io "$@"| grep -E --color=always "^|True"
kubectl get -A certificates.cert-manager.io -o jsonpath='{range .items[*]}{.metadata.namespace} {.metadata.name} {.spec.secretName}{"\n"}{end}' | while read namespace name secretname; do
    printf '%-20s certificates.cert-manager.io/%-85s ' $namespace $name
    set +e
    ! { kubectl get -n $namespace secret $secretname -o jsonpath="{.data.tls\\.crt}" | base64 -d | openssl-cert-info.sh 2>/dev/null | grep notAfter; } && echo ""
    set -e
done
kubectl get -A --show-kind=true certificatesigningrequests.certificates.k8s.io "$@"| grep -E --color=always "^|True" || true

echo "
kubectl delete certificaterequest XYZ
# https://cert-manager.io/docs/usage/kubectl-plugin/
kubectl cert-manager renew -n namespace letsencrypt-prod.blabla.bip.bop.com # certificate.cert-manager.io/
"
