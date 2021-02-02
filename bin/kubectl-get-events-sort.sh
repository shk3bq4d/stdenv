#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

kubectl get events --sort-by=.metadata.creationTimestamp "$@"
