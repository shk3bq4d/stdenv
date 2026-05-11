#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

docker ps &>/dev/null && SUDO="" || SUDO="sudo";
az account list | jq -r '.[].id' | while read subscription; do
    az acr list --subscription $subscription -o json |
        jq -r '.[] | .loginServer + " " + .name + " " + .resourceGroup + " " + .id' |
            while read server name rg id; do
                echo -e "\n$server"
                az acr login --subscription $subscription -n $name --expose-token 2>/dev/null | jq -r .refreshToken | $SUDO docker login $server -u 00000000-0000-0000-0000-000000000000 --password-stdin
            done
    done
