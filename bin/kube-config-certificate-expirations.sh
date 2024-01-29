#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

f=~/.kube/config

all_clusters() {
    yq e '.clusters[].name' $f
}

cluster_cert() {
    test $# -ne 1  && echo "FATAL: use unique argument" && return 1
    yq e ".clusters[]|select(.name==\"$1\").cluster[\"certificate-authority-data\"]" $f | base64 -d

}

all_users() {
    yq e '.users[].name' $f
}

user_cert() {
    test $# -ne 1  && echo "FATAL: use unique argument" && return 1
    yq e ".users[]|select(.name==\"$1\").user[\"client-certificate-data\"]" $f | base64 -d

}

for cluster_name in $(all_clusters); do
    printf \
        "cluster %-50s %s\n" \
        "$cluster_name:" \
        "$(cluster_cert "$cluster_name" | openssl-cert-info.sh |& grep notAfter)"
done


for user_name in $(all_users); do
    printf \
        "user %-80s %s\n" \
        "$user_name:" \
        "$(user_cert "$user_name" | openssl-cert-info.sh |& grep notAfter)"
done

