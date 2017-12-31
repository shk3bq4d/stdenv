#!/usr/bin/env bash

set -eu

echo "
EXAMPLE
$0 ~/certs/mitmproxy-ca-cert.pem ~/.virtualenvs/ldap3/

"

CA_FILEPATH=$1
PYTHON_ROOT_DIR=$2

set -x
[[ ! -f $CA_FILEPATH ]] && exit 1
[[ ! -d $PYTHON_ROOT_DIR ]] && exit 1
find $PYTHON_ROOT_DIR -type f -name cacert.pem -o -name cacerts.txt | \
	while read f
	do
		if ! is_file_in_other.py $CA_FILEPATH $f
		then
			cat $CA_FILEPATH >> $f
		fi
	done
