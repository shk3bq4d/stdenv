#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

OPENSSL_OPTIONS=""
PORT=443

if [[ $# -gt 1 ]] && [[ -f "$@" ]]; then
    F="$@"
    $0 "$F"
    exit $?
fi
if [[ $# -lt 1 ]]; then
    >&2 echo "FATAL: noargs"
    exit 1
else
    NAME="$1"
    if [[ $# -eq 1 && -f "$NAME" ]]; then
        MODE=file
    else
        MODE=connect
        if [[ $NAME =~ ^[0-9]{1,5}$ ]]; then
            # if name looks
            PORT=$NAME
            NAME=127.0.0.1
        fi
        NAME="$( echo -n $NAME | sed -r \
            -e 's/^#//' \
            -e 's/(^\s+|\s+$)//g' \
            -e 's/^.*(https?:..)([^/ ]+?).*$/\2/'
            )"
        if [[ "$NAME" = *:* ]]; then
            PORT="$( echo -n "$NAME" | sed -r \
                -e 's/.*://' \
                )"
            NAME="$( echo -n "$NAME" | sed -r \
                -e 's/:.*//' \
                )"
        fi
    fi
fi
[[ $# -lt 2 ]] && PORT=$PORT || PORT=$2
if [[ $# -lt 3 ]]; then
       IP="$NAME"
elif [[ $MODE = connect ]]; then
    IP=$(dig -t a +short "$NAME" @$3 | tail -1)
fi

if uname | grep -qx FreeBSD; then
    OPENSSL_OPTIONS=
else
    OPENSSL_OPTIONS="-checkhost $NAME"
fi
{   if [[ $MODE = file ]]; then
        echo "cat $NAME" >&2
        cat "$NAME"
    else
        #echo "echo | /usr/bin/openssl s_client -connect $IP:$PORT -servername '$NAME' -showcerts                2>&1 | less"  >&2
        #echo "echo | /usr/bin/openssl s_client -connect $IP:$PORT -servername '$NAME' -showcerts -starttls smtp 2>&1 | less # for STARTTLS SMTP"  >&2
        echo | \
            /usr/bin/openssl s_client -connect $IP:$PORT -servername "$NAME" 2>&1
    fi
} |
    sed -rne '/-BEGIN (TRUSTED )?CERTIFICATE-/,/-END (TRUSTED )?CERTIFICATE-/p'

exit 0

