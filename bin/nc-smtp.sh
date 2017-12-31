#!/usr/bin/env bash

set -ue
F=/tmp/$(basename $0 .sh).bin
find $F -mtime +1 -delete 2>/dev/null || true
SESS=$(cat $F 2>/dev/null || echo 0) 
SESS=$(( $SESS + 1 ))
echo "SESS is $SESS"
echo "$SESS" > $F

SERVER=mail.mydomain.local
PORT=25
FROM_DOMAIN="local.domain.name" #$ - dont worry too much about your local domain name although you really should use your exact fully qualified domain name as seen by the outside world the mail server has no choice but to take your word for it as of RFC822-RFC1123.
FROM_MAIL="mail@domain.ext"
TO="test4324@mailinator.com"
TO="$GIT_AUTHOR_EMAIL"
SUBJECT="Test #${SESS} sent from $(hostname -f) on $(date +'%Y.%m.%d %H:%M:%S')"


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
#nc -Cv -q 3 -i 3 $SERVER $PORT < $_tempfile # doesn't work
#(sleep 5; cat $_tempfile; sleep 5) | telnet -C $SERVER $PORT  # workds
cat $_tempfile | while read line; do 
	sleep 1
	echo $line >&2
	echo $line
done | nc -C $SERVER $PORT 
