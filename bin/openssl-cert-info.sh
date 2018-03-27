#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ HOST [PORT [DNSSERVER]]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 27 Mar 2018
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

[[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0
NAME=$1
[[ $# -lt 2 ]] && PORT=443 || PORT=$2
if [[ $# -lt 3 ]]; then
   	IP=$NAME
	echo "$NAME -> $(dig -t a +short $NAME | tail -1)"
else
	IP=$(dig -t a +short $NAME @$3 | tail -1)
	echo "$NAME @$3 -> $IP"
fi

echo "/usr/bin/openssl s_client -connect $IP:$PORT -servername $NAME" 
echo '' | \
    /usr/bin/openssl s_client -connect $IP:$PORT -servername $NAME 2>/dev/null | \
    /bin/sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | \
    /usr/bin/openssl x509 -noout -text -extensions SAN -issuer -subject -alias -dates -email -checkhost $NAME 2>&1| \
	grep -EA1 '^[^ ]|Subject Alternative Name' | grep -vE '^--$|^Certificate:$|^Data: *$' | sed -r -e 's/^ +//g'
exit 0

