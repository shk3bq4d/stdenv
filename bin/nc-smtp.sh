#!/usr/bin/env bash
# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */

set -ue
F=/tmp/$(basename $0 .sh).bin
find $F -mtime +1 -delete 2>/dev/null || true
SESS=$(cat $F 2>/dev/null || echo 0)
SESS=$(( $SESS + 1 ))
echo "SESS is $SESS"
echo "$SESS" > $F

p() {
    local default
    default="$1"
    shift
    >&2 echo -n "$@? ($default): "
    read _r
    echo -n "$_r"
    case $_r in \
    "") echo -n "$default";;
    *) >&2 echo "";;
    esac
}

SERVER="$(p "mail.mydomain.local" "what SMTP to connect to")"
PORT="$(p "25" "what destination TCP port to use")"
STARTTLS="$(p "no" "would you like to starttls ?")"

FROM_DOMAIN="$(p "$(hostname -f)" "what HELO value to use")"
FROM_MAIL="$(p "$(id -un)@$(hostname -f)" "What from value to use")"
TO="test4324@mailinator.com"
TO="$(id -un)@$(hostname -f)"
TO="$(p "${GIT_AUTHOR_EMAIL:-$TO}" "Who to send to")"
SUBJECT="Test #${SESS} sent from $(hostname -f) on $(date +'%Y.%m.%d %H:%M:%S')"


_connect() {
    local starttls h p
    starttls="$1"
    h="$2"
    p="$3"
    case "${starttls}" in \
    y*|Y*)
        set -x
        openssl s_client -connect $h:$p -crlf -starttls smtp
        set +x
        ;;
    *)
        set -x
        nc -vC $h $p
        set +x
        ;;
    esac
}


_tempfile=$(mktemp); function cleanup() { [[ -f "$_tempfile" ]] && rm -f $_tempfile; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
echo \
"HELO $FROM_DOMAIN
MAIL FROM: $FROM_MAIL
RCPT TO: $TO
DATA
Subject: $SUBJECT
Body start
hehe
hoho
.
QUIT
" > $_tempfile
cat $_tempfile
cat $_tempfile | while read line; do
    sleep 1
    echo $line >&2
    echo -n "$line"
    echo     $'\r' # RFC 5321 mandates \r\n, though "nc -C" takes care of that already
done | _connect $STARTTLS $SERVER $PORT
echo EOF
exit 0
