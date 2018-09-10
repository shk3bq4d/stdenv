#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 10 Sep 2018
##

set -euo pipefail

cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )"

# https://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html
# Examples
# The following examples show how date and time patterns are interpreted in the U.S. locale. The given date and time are 2001-07-04 12:08:56 local time in the U.S. Pacific Time time zone.
# Date and Time Pattern	Result
# "yyyy.MM.dd G 'at' HH:mm:ss z"	2001.07.04 AD at 12:08:56 PDT
# "EEE, MMM d, ''yy"	Wed, Jul 4, '01
# "h:mm a"	12:08 PM
# "hh 'o''clock' a, zzzz"	12 o'clock PM, Pacific Daylight Time
# "K:mm a, z"	0:08 PM, PDT
# "yyyyy.MMMMM.dd GGG hh:mm aaa"	02001.July.04 AD 12:08 PM
# "EEE, d MMM yyyy HH:mm:ss Z"	Wed, 4 Jul 2001 12:08:56 -0700
# "yyMMddHHmmssZ"	010704120856-0700
# "yyyy-MM-dd'T'HH:mm:ss.SSSZ"	2001-07-04T12:08:56.235-0700
# "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"	2001-07-04T12:08:56.235-07:00
# "YYYY-'W'ww-u"	2001-W27-3
# 

test -f $(basename $0 .sh).class || javac $(basename $0 .sh).java

java $(basename $0 .sh) "$@"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)

echo EOF
exit 0

