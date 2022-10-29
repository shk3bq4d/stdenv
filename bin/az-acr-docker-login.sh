#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

az account list | jq -r '.[].id' | while read subscription; do
    az acr list --subscription $subscription | jq -r '.[].name' | while read name; do
      echo az acr login --subscription $subscription --name $name
           az acr login --subscription $subscription --name $name
   done
done
