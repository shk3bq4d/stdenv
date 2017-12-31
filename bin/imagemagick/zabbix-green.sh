#!/usr/bin/env bash


# wget https://objects.ksnet.nagra.com/swift/v1/pub-static-files/icon_zabbix.png
#

o=/tmp/out.png
VIOLET=100,100,270
TURQUOISE=100,100,200
GREEN=100,80,180

convert icon_zabbix.png -modulate $GREEN $o
identify $o
feh $o
