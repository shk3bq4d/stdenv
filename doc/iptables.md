# stop incoming ping
iptables -I INPUT 1 -p ICMP --icmp-type 8 -j DROP # stop incoming ping
# restore it
iptables -D INPUT   -p ICMP --icmp-type 8 -j DROP # restore stopped incoming ping

# stop outpust
sudo iptables -I INPUT 1 -p tcp --src 91.216.32.0/24 -j DROP


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
iptables -I INPUT 1 -p tcp -m multiport --dports 5044,10514,12201 -j DROP #nginx
iptables -I INPUT 1 -p tcp -m multiport --dports 5045,10515,12202 -j DROP #graylog
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

# snapserver k8s
iptables -I FORWARD 1 -p tcp -m tcp --destination 10.19.29.0/24 -j ACCEPT
iptables -I FORWARD 1 -p udp --destination 10.19.29.0/24 -j ACCEPT

# transparent redirection
well there's a bunch of different scenario and the web show various cases that unlikely apply on your
specific use case. There's a bunch of copy paste here. Your best course of action if you don't
know much what your are doing is pre-pend each rule you'd like to issue with an identical filtering
rule that jumps to a LOG that you can then tail -f | grep (either on dmesg or /var/log/messages or
equivalent). And maybe first issue a
sudo iptables -F; sudo iptables -F -t nat; # flush
```sh

# case with two interface
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j DNAT --to 192.168.1.1:3128
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3128

iptables -t nat -A PREROUTING -p tcp --dport [port] -j DNAT --to [home-ip]:[port]
iptables -t nat -A POSTROUTING -d [home-ip] -j MASQUERADE

iptables -t nat -I PREROUTING  0 -p udp --dport 53 -j LOG --log-prefix "grepme prerouting "  --log-level 6
iptables -t nat -I POSTROUTING 0 -p udp --dport 53 -j LOG --log-prefix "grepme postrouting " --log-level 6
iptables -t nat -I OUTPUT      0 -p udp --dport 53 -j LOG --log-prefix "grepme output "      --log-level 6

iptables -t nat -I OUTPUT 0 -p udp --dport 53 -j LOG --log-prefix "grepme output "      --log-level 6
iptables -t nat -A OUTPUT   -p udp --dport 53 -j DNAT --to 10.202.10.69:5353 # <-- this redirect to dnsmasq worked for me
```


TABLES
       There  are currently five independent tables (which tables are present at any time depends on the kernel configuration options and which mod‐
       ules are present).

       -t, --table table
              This option specifies the packet matching table which the command should operate on.  If the kernel is configured with automatic  mod‐
              ule loading, an attempt will be made to load the appropriate module for that table if it is not already there.

              The tables are as follows:

              filter:
                  This  is the default table (if no -t option is passed). It contains the built-in chains INPUT (for packets destined to local sock‐
                  ets), FORWARD (for packets being routed through the box), and OUTPUT (for locally-generated packets).

              nat:
                  This table is consulted when a packet that creates a new connection is encountered.  It consists of  three  built-ins:  PREROUTING
                  (for  altering  packets  as soon as they come in), OUTPUT (for altering locally-generated packets before routing), and POSTROUTING
                  (for altering packets as they are about to go out).  IPv6 NAT support is available since kernel 3.7.

              mangle:
                  This table is used for specialized packet alteration.  Until kernel 2.4.17 it had two built-in chains:  PREROUTING  (for  altering
                  incoming  packets  before routing) and OUTPUT (for altering locally-generated packets before routing).  Since kernel 2.4.18, three
                  other built-in chains are also supported: INPUT (for packets coming into the box itself),  FORWARD  (for  altering  packets  being
                  routed through the box), and POSTROUTING (for altering packets as they are about to go out).

              raw:
                  This  table  is used mainly for configuring exemptions from connection tracking in combination with the NOTRACK target.  It regis‐
                  ters at the netfilter hooks with higher priority and is thus called before ip_conntrack, or any other IP tables.  It provides  the
                  following built-in chains: PREROUTING (for packets arriving via any network interface) OUTPUT (for packets generated by local pro‐
                  cesses)

              security:
                  This table is used for Mandatory Access Control (MAC) networking rules, such as those enabled by the SECMARK and CONNSECMARK  tar‐
                  gets.   Mandatory Access Control is implemented by Linux Security Modules such as SELinux.  The security table is called after the
                  filter table, allowing any Discretionary Access Control (DAC) rules in the filter table to take effect before MAC rules.  This ta‐
                  ble provides the following built-in chains: INPUT (for packets coming into the box itself), OUTPUT (for altering locally-generated
                  packets before routing), and FORWARD (for altering packets being routed through the box).
