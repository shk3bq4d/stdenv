# stop incoming ping
iptables -I INPUT 1 -p ICMP --icmp-type 8 -j DROP
# restore it
iptables -D INPUT   -p ICMP --icmp-type 8 -j DROP


#!/bin/bash
# forbid access to facebook
ACTION="DROP"
FACEBOOK_AS="AS32934"
# flush (clear) the tables and clear the counters
     iptables -F
     iptables -Z
     ip6tables -F
     ip6tables -Z
for AS in ${FACEBOOK_AS}
do
  IPs=`whois -h whois.radb.net \!g${AS} | grep /`
  for IP in ${IPs}
  do
    for TARGET in INPUT OUTPUT FORWARD
    do
           iptables  -A ${TARGET} -p all -d ${IP} -j ${ACTION}
    done
  done
  IPs=`whois -h whois.radb.net \!6${AS} | grep /`
  for IP in ${IPs}
  do
    for TARGET in INPUT OUTPUT FORWARD
    do
           ip6tables  -A ${TARGET} -p all -d ${IP} -j ${ACTION}
    done
  done
done
