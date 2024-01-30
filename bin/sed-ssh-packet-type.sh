#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

# https://www.javadoc.io/doc/org.pcap4j/pcap4j/1.7.4/org/pcap4j/packet/namednumber/Ssh2MessageNumber.html

raw_data() {
    cat << EOF
    SSH_MSG_CHANNEL_CLOSE
SSH_MSG_CHANNEL_CLOSE: 97
static Ssh2MessageNumber    SSH_MSG_CHANNEL_DATA
SSH_MSG_CHANNEL_DATA: 94
static Ssh2MessageNumber    SSH_MSG_CHANNEL_EOF
SSH_MSG_CHANNEL_EOF: 96
static Ssh2MessageNumber    SSH_MSG_CHANNEL_EXTENDED_DATA
SSH_MSG_CHANNEL_EXTENDED_DATA: 95
static Ssh2MessageNumber    SSH_MSG_CHANNEL_FAILURE
SSH_MSG_CHANNEL_FAILURE: 100
static Ssh2MessageNumber    SSH_MSG_CHANNEL_OPEN
SSH_MSG_CHANNEL_OPEN: 90
static Ssh2MessageNumber    SSH_MSG_CHANNEL_OPEN_CONFIRMATION
SSH_MSG_CHANNEL_OPEN_CONFIRMATION: 91
static Ssh2MessageNumber    SSH_MSG_CHANNEL_OPEN_FAILURE
SSH_MSG_CHANNEL_OPEN_FAILURE: 92
static Ssh2MessageNumber    SSH_MSG_CHANNEL_REQUEST
SSH_MSG_CHANNEL_REQUEST: 98
static Ssh2MessageNumber    SSH_MSG_CHANNEL_SUCCESS
SSH_MSG_CHANNEL_SUCCESS: 99
static Ssh2MessageNumber    SSH_MSG_CHANNEL_WINDOW_ADJUST
SSH_MSG_CHANNEL_WINDOW_ADJUST: 93
static Ssh2MessageNumber    SSH_MSG_DEBUG
SSH_MSG_DEBUG: 4
static Ssh2MessageNumber    SSH_MSG_DISCONNECT
SSH_MSG_DISCONNECT: 1
static Ssh2MessageNumber    SSH_MSG_GLOBAL_REQUEST
SSH_MSG_GLOBAL_REQUEST: 80
static Ssh2MessageNumber    SSH_MSG_IGNORE
SSH_MSG_IGNORE: 2
static Ssh2MessageNumber    SSH_MSG_KEXDH_INIT
SSH_MSG_KEXDH_INIT: 30
static Ssh2MessageNumber    SSH_MSG_KEXDH_REPLY
SSH_MSG_KEXDH_REPLY: 31
static Ssh2MessageNumber    SSH_MSG_KEXINIT
SSH_MSG_KEXINIT: 20
static Ssh2MessageNumber    SSH_MSG_NEWKEYS
SSH_MSG_NEWKEYS: 21
static Ssh2MessageNumber    SSH_MSG_REQUEST_FAILURE
SSH_MSG_REQUEST_FAILURE: 82
static Ssh2MessageNumber    SSH_MSG_REQUEST_SUCCESS
SSH_MSG_REQUEST_SUCCESS: 81
static Ssh2MessageNumber    SSH_MSG_SERVICE_ACCEPT
SSH_MSG_SERVICE_ACCEPT: 6
static Ssh2MessageNumber    SSH_MSG_SERVICE_REQUEST
SSH_MSG_SERVICE_REQUEST: 5
static Ssh2MessageNumber    SSH_MSG_UNIMPLEMENTED
SSH_MSG_UNIMPLEMENTED: 3
static Ssh2MessageNumber    SSH_MSG_USERAUTH_BANNER
SSH_MSG_USERAUTH_BANNER: 53
static Ssh2MessageNumber    SSH_MSG_USERAUTH_FAILURE
SSH_MSG_USERAUTH_FAILURE: 51
static Ssh2MessageNumber    SSH_MSG_USERAUTH_INFO_REQUEST
SSH_MSG_USERAUTH_INFO_REQUEST: 60
static Ssh2MessageNumber    SSH_MSG_USERAUTH_INFO_RESPONSE
SSH_MSG_USERAUTH_INFO_RESPONSE: 61
static Ssh2MessageNumber    SSH_MSG_USERAUTH_REQUEST
SSH_MSG_USERAUTH_REQUEST: 50
static Ssh2MessageNumber    SSH_MSG_USERAUTH_SUCCESS
SSH_MSG_USERAUTH_SUCCESS: 52
EOF
}

regex() {
    # debug3: send packet: type 80
    # debug3: receive packet: type 82
    raw_data | sed -r -n -e  's/^(SSH_MSG_)?([A-Z_]+): ([0-9]+)$/\3 \2/ p' | sort -V |
        while read a b; do
            echo "s/( type $a\\>)/\1 ($b)/"
        done
}

if [[ -n "${VIMF6:-}" ]]; then
    regex
else
    sed -u -r -e "$(regex)" "$@"
fi
