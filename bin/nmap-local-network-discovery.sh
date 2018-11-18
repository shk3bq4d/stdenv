#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 17 Nov 2018
##

set -euo pipefail

set -x
echo Ping discovery
nmap -v -sn 192.168.0.0/16 10.0.0.0/8
echo 
#echo Ping + Port
#nmap -sn -PS22,80,443 192.168.0.0/16 10.0.0.0/8
echo Seleceted ports only
nmap -v -Pn -PS22,80,443 192.168.0.0/16 10.0.0.0/8
