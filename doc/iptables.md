# stop incoming ping
iptables -I INPUT 1 -p ICMP --icmp-type 8 -j DROP
# restore it
iptables -D INPUT   -p ICMP --icmp-type 8 -j DROP

# list
sudo iptables -L
sudo iptables -L -t nat #sshuttles

# sshuttle add port rule
1) find out your sshuttle listening port
2) insert your sneaky rule
sudo iptables -t nat -A sshuttle-12299 -p tcp --dport 25 -m ttl ! --ttl-eq 42 -j REDIRECT --to-ports 12299


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


iptables -A INPUT -p tcp -m tcp --dport 10050 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 10514 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 12201 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 27017 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 5044 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 9000 -j ACCEPT

# pause graylog processing
iptables -I INPUT 1 -p tcp -m multiport --dports 5044,10514,12201 -j DROP
iptables -I INPUT 1 -p tcp -m tcp --dport 5044,10514,12201 -j DROP # gelf
iptables -I INPUT 1 -p tcp -m tcp --dport 12201 -j DROP # gelf
iptables -I INPUT 1 -p tcp -m tcp --dport 5044  -j DROP # filebeat
iptables -I INPUT 1 -p tcp -m tcp --dport 10514 -j DROP # tcp syslog
iptables -D INPUT 1
iptables -D INPUT   -p tcp -m multiport --dports 5044,10514,12201 -j DROP
iptables -D INPUT   -p tcp -m tcp --dport 12201 -j DROP
iptables -D INPUT   -p tcp -m tcp --dport 5044  -j DROP
iptables -D INPUT   -p tcp -m tcp --dport 10514  -j DROP

# changes default table policy
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
