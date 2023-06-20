#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

mycurl() {
    curl \
        -H "accept: application/json" \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.9,de;q=0.8,fr;q=0.7,lb;q=0.6,pl;q=0.5,nl;q=0.4' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Cookie: FLAG_CONSOLIDATION=true; OptanonAlertBoxClosed=2022-09-16T08:40:31.991Z; OptanonConsent=isGpcEnabled=0&datestamp=Tue+Jun+20+2023+11%3A04%3A30+GMT%2B0200+(Central+European+Summer+Time)&version=202209.1.0&isIABGlobal=false&hosts=&consentId=84626cae-de8e-4f74-b4a5-7a0b16aed506&interactionCount=1&landingPath=NotLandingPage&groups=C0003%3A1%2CC0001%3A1%2CC0002%3A1%2CC0004%3A1&AwaitingReconsent=false&geolocation=NL%3BNH' \
  -H 'Pragma: no-cache' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.134 Safari/537.36' \
  -H 'X-DOCKER-API-CLIENT: docker-hub/v2781.0.0' \
  -H 'sec-ch-ua: "Chromium";v="111", "Not(A:Brand";v="8"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --compressed \
  "$@"
  #-H 'Referer: https://hub.docker.com/r/zabbix/zabbix-proxy-sqlite3/tags' \
}

# https://forums.docker.com/t/how-can-i-list-tags-for-a-repository/32577/8
function listAllTags() {
    local repo=${1}
    local page_size=${2:-100}
    [ -z "${repo}" ] && echo "Usage: listTags <repoName> [page_size]" 1>&2 && return 1
    local base_url="https://registry.hub.docker.com/api/content/v1/repositories/public/library/${repo}/tags"
    local namespace="public"
    local base_url="https://hub.docker.com/v2/namespaces/${namespace}/repositories/${repo}/images-summary"
    local base_url="https://hub.docker.com/v2/repositories/${repo}/tags/"

    local page=1
    local res=$(mycurl "${base_url}?page_size=${page_size}&page=${page}&name&ordering" 2>/dev/null)
    local tags=$(echo ${res} | jq --raw-output '.results[].name')
    local all_tags="${tags}"

    if true; then
        echo "${all_tags}" | sort
        # paginate if you feel like it
        return
     fi

    local tag_count=$(echo ${res} | jq '.count')

    ((page_count=(${tag_count}+${page_size}-1)/${page_size}))  # ceil(tag_count / page_size)

    for page in $(seq 2 $page_count); do
        tags=$(mycurl "${base_url}?page_size=${page_size}&page=${page}&name&ordering" 2>/dev/null | jq --raw-output '.results[].name')
        all_tags="${all_tags}${tags}"
    done

    echo "${all_tags}" | sort
}

listAllTags "$@"
