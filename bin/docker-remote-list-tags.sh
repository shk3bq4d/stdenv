#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
#
curl -s -S "https://registry.hub.docker.com/v2/repositories/$@/tags/" | jq -r '."results"[]["name"]' |sort | sed -r -e "s,^,$@:,"
