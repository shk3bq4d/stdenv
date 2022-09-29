#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

yq '.contexts[].name' ~/.kube/config | while read context_name; do
  echo -e "\n==== context $context_name"
  ! kubectl get nodes --context  $context_name && echo "error"
done
