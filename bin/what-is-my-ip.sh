#!/usr/bin/env bash

echo 'http://unix.stackexchange.com/questions/22615/how-can-i-get-my-external-ip-address-in-a-shell-script'
set -x
curl -s http://whatismyip.akamai.com/
curl -s http://whatismijnip.nl |cut -d " " -f 5
curl -s https://4.ifcfg.me/
dig +short myip.opendns.com @resolver1.opendns.com
