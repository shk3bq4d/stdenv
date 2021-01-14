#!/usr/bin/env bash

function usage() {
	echo "$(basename $0) FILE
Makes a guess as to what crypto file you have
	"
}

if [[ $# -ne 1 ]]; then
	echo "FATAL: wrong number of args"
	usage
	exit 1
fi
if [[ ! -f "$@" ]]; then
	echo "FATAL: not a file $@"
	usage
	exit 1
fi

function mrtest()
{	local RESPONSE
	local CMD
	RESPONSE="$1"
	shift
	CMD="$@"

	sh -c "$CMD" &>/dev/null && echo "mrtest: $RESPONSE"

}

F="$@"
echo "file:   $(file $F)"
if grep -qE "^-----BEGIN RSA PRIVATE KEY-----$" "$F"; then
	# PKCS#1
	mrtest "RSA PKCS#1 private key 2048 in pem format"  "openssl rsa  -inform pem -in $F -noout -text | grep 'Private-Key: (2048 bit)'"
	mrtest "RSA PKCS#1 private key 4096 in pem format"  "openssl rsa  -inform pem -in $F -noout -text | grep 'Private-Key: (4096 bit)'"
else
	mrtest "x509 in PEM format" openssl x509 -inform pem -in "$F" -noout -text
	mrtest "x509 in DER format" openssl x509 -inform der -in "$F" -noout -text
	mrtest "RSA x.509 private key 2048 in pem format"  "openssl rsa  -inform pem -in $F -noout -text | grep 'Private-Key: (2048 bit)'"
	mrtest "RSA x.509 private key 4096 in pem format"  "openssl rsa  -inform pem -in $F -noout -text | grep 'Private-Key: (4096 bit)'"
fi
# keytool -list -v -keystore /etc/pki/java/cacerts 

