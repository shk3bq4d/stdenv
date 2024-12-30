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

[[ $# -eq 0 ]] && SERVER="$(p "mail.mydomain.local" "what SMTP to connect to")" || { SERVER="$1"; shift; }
[[ $# -eq 0 ]] && PORT="$(p "25" "what destination TCP port to use")" || { PORT="$1"; shift; }
[[ $# -eq 0 ]] && STARTTLS="$(p "no" "would you like to starttls ?")" || { STARTTLS="$1"; shift; }

[[ $# -eq 0 ]] && FROM_DOMAIN="$(p "$(hostname -f)" "what EHLO value to use")" || { FROM_DOMAIN="$1"; shift; }
[[ $# -eq 0 ]] && FROM_MAIL="$(p "$(id -un)@$(hostname -f)" "What from value to use")" || { FROM_MAIL="$1"; shift; }
#TO="test4324@mailinator.com"
#TO="$(id -un)@$(hostname -f)"
TO="$FROM_MAIL"
[[ $# -eq 0 ]] && TO="$(p "${GIT_AUTHOR_EMAIL:-$TO}" "Who to send to")" || { TO="$1"; shift; }
SUBJECT="Test #${SESS} sent from $(hostname -f) on $(date +'%Y.%m.%d %H:%M:%S')"


_connect() {
    local starttls h p
    starttls="$1"
    h="$2"
    p="$3"
    case "${starttls}" in \
    y*|Y*)
        set -x
        sed -u -r -e '/^(EHLO|HELO)/d' | openssl s_client -connect $h:$p -crlf -starttls smtp
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
"EHLO $FROM_DOMAIN
MAIL FROM: $FROM_MAIL
RCPT TO: $TO
DATA
From: $FROM_MAIL
To: $TO
Subject: $SUBJECT
Body start
hehe
hoho
.
QUIT
" > $_tempfile
cat $_tempfile
echo "To repeat your args use"
echo "$0 \"$SERVER\" \"$PORT\" \"$STARTTLS\" \"$FROM_DOMAIN\" \"$FROM_MAIL\" \"$TO\""
cat $_tempfile | while read line; do
    sleep 1
    echo $line >&2
    echo -n "$line"
    echo     $'\r' # RFC 5321 mandates \r\n, though "nc -C" takes care of that already
done | _connect $STARTTLS $SERVER $PORT
echo EOF
exit 0
