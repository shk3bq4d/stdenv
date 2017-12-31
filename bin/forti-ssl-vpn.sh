#!/usr/bin/env bash

cygstart /downloads/FortiClientTools_5.4.3.0870/SSLVPNcmdline/FortiSSLVPNclient.exe connect -h vpn-emea.cyberfusion.center:443 -u adminmru:$(otp-adminmru.sh) -i -m

