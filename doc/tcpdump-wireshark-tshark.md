```sh
https://danielmiessler.com/study/tcpdump/
tcpdump -i vtnet0 -X host 10.50.219.121 and not dst port 65530 and not dst port 443
/usr/sbin/tcpdump -i vtnet0 -c 100 -s 0 -w /root/packetcapture.cap ip and tcp and ( host 10.19.29.220 and host 10.19.29.58)
/usr/sbin/tcpdump -i vtnet0 -c 100 -s 0 ip and tcp and ( host 10.19.29.58)
/usr/sbin/tcpdump -i eth0 -c 100 -s 0 ip and tcp and "( host 195.94.110.221)"
/usr/sbin/tcpdump -i eth0 -c 100 -s 0 -w /root/packetcapture.cap ip and tcp and "( host $(dig +short inTouch2 ) )"
/usr/sbin/tcpdump -i eth0 -c 100 -s 0 -w /root/packetcapture.cap ip and tcp and "( host inTouch2 )"
tcpdump -i ens160 -nn port 67 and port 68 # dhcp
tcpdump -i ens160 -nn port 69 # tftp
tcpdump ip6 # ipv6
tcpdump -i ens160 arp | grep 10.101.6.85 | ts
tcpdump -i eth0 -en  | grep 40:a8:f0:75:d3:f7 # track mac address
tcpdump -i any dst port 443 and dst net 100.64.0.0/16 # CIDR, all interfaces
tcpdump -e # <-- see ARP destination which helps debug routing information
wireshark -i enp0s25 -k -f "tcp port 389 and host 10.3.28.13"
wireshark -i lo -k -f "tcp port 65389" # 1) Right click on line, decode AS "LDAP", 2) display filter: "ldap" , 3) profit!
a=5; for i in $(seq 90000); do ssh myrouter tcpdump -i eth1 -nn -w - 'ip and not net 10.1.1.0/24 and not net 10.1.2.0/24' >wrt-$a-$i.cap; done

tcpdump host 10.0.0.218 | grep -iE '> .*\.53:' DNS queries on openwrt
sudo tcpdump -s0 -n port 53 # DNS queries and answer
```

# writes and rotates 10 files of max 1Mb
tcpdump -i ens160 -C 1 -W 10 -w /tmp/salut host 10.36.220.10 and dst port 443

/usr/sbin/tcpdump -i any -s 0 -w /root/arp.cap arp
rsync-remote-root.sh pi@pi-chambrecharlotte:/root/arp.cap ~/tmp
wireshark ~/tmp/arp.cap &

# rsyslog
tcpdump -i eth0 -X port 514

# TCP reset
## understanding expression
tcp[13] & 4 != 0
* tcp[13]: Refers to the 14th byte of the TCP header. In TCP headers, the 13th byte is the flags field, and each bit in this byte represents a different flag (e.g., SYN, ACK, RST).
* & 4: Performs a bitwise AND operation with 4. In TCP, the RST (Reset) flag is represented by the 4th bit in the flags field. This part of the filter checks if the RST bit is set.
* != 0': Checks if the result of the previous operation is not equal to 0. This ensures that the RST bit is set, indicating a TCP reset.

## actual commands
```sh
tcpdump -nn 'tcp[13] & 4 != 0' # tracks TCP reset
tcpdump -nn '(host 172.31.20.100) and (port 443) and (tcp[13] & 4 != 0)' # tracks TCP reset

tcpdump -nn 'not ip6'  # exclude ipv6
tcpdump -nn 'not arp'  # exclude arp
tcpdump -nn 'not icmp' # exclude ping
tcpdump -nn 'not igmp' # exclude igmp
tcpdump -i any -nn ifname eth0 # need packet filter, doesn't work on centos7
```




#imap JP
/usr/sbin/tcpdump -i vtnet0 -c 100 -s 0 -vv -w jpimap "ip and tcp and ( host 10.19.29.231 and port 143 )"
file jpimap
jpimap: tcpdump capture file (little-endian) - version 2.4 (Ethernet, capture length 65535)
sudo apt install tcpick
tcpick -C -yP -r jpimap

# SSH corp
/usr/sbin/tcpdump -i eth0 -c 10 -s 0 -vv -w myfile "ip and tcp and ( host 196.0.66.249 and port 22 )"

# gpg search keys
sudo tcpdump -i lo -c 100 -s 0 -vv -w - "ip and tcp and host 127.0.12.12"

# wireshark display filter
https://wiki.wireshark.org/DisplayFilters
Show only SMTP (port 25) and ICMP traffic:

ip.dst == 10.10.24.0/24 # cidr
dns or ip.dst == 100.64.0.0/16

 tcp.port eq 25 or icmp
Show only traffic in the LAN (192.168.x.x), between workstations and servers -- no Internet:

ip.src==192.168.0.0/16 and ip.dst==192.168.0.0/16
TCP buffer full -- Source is instructing Destination to stop sending data

 tcp.window_size == 0 && tcp.flags.reset != 1
Filter on Windows -- Filter out noise, while watching Windows Client - DC exchanges

 smb || nbns || dcerpc || nbss || dns
Sasser worm: --What sasser really did--

  ls_ads.opnum==0x09
Match packets containing the (arbitrary) 3-byte sequence 0x81, 0x60, 0x03 at the beginning of the UDP payload, skipping the 8-byte UDP header. Note that the values for the byte sequence implicitly are in hexadecimal only. (Useful for matching homegrown packet protocols.)

  udp[8:3]==81:60:03
The "slice" feature is also useful to filter on the vendor identifier part (OUI) of the MAC address, see the Ethernet page for details. Thus you may restrict the display to only packets from a specific device manufacturer. E.g. for DELL machines only:

  eth.addr[0:3]==00:06:5B
It is also possible to search for characters appearing anywhere in a field or protocol by using the contains operator.

Match packets that contains the 3-byte sequence 0x81, 0x60, 0x03 anywhere in the UDP header or payload:

  udp contains 81:60:03
Match packets where SIP To-header contains the string "a1762" anywhere in the header:

  sip.To contains "a1762"
The matches, or ~, operator makes it possible to search for text in string fields and byte sequences using a regular expression, using Perl regular expression syntax. Note: Wireshark needs to be built with libpcre in order to be able to use the matches operator.

Match HTTP requests where the last characters in the uri are the characters "gl=se":

  http.request.uri matches "gl=se$"
Note: The $ character is a PCRE punctuation character that matches the end of a string, in this case the end of http.request.uri field.

Filter by a protocol ( e.g. SIP ) and filter out unwanted IPs:


  ip.src != xxx.xxx.xxx.xxx && ip.dst != xxx.xxx.xxx.xxx && sip
[ Feel free to contribute more ]

Gotchas

Some filter fields match against multiple protocol fields. For example, "ip.addr" matches against both the IP source and destination addresses in the IP header. The same is true for "tcp.port", "udp.port", "eth.addr", and others. It's important to note that

 ip.addr == 10.43.54.65
is equivalent to
 ip.src == 10.43.54.65 or ip.dst == 10.43.54.65
This can be counterintuitive in some cases. Suppose we want to filter out any traffic to or from 10.43.54.65. We might try the following:

 ip.addr != 10.43.54.65
which is equivalent to
 ip.src != 10.43.54.65 or ip.dst != 10.43.54.65
This translates to "pass all traffic except for traffic with a source IPv4 address of 10.43.54.65 and a destination IPv4 address of 10.43.54.65", which isn't what we wanted.

Instead we need to negate the expression, like so:

 ! ( ip.addr == 10.43.54.65 )
which is equivalent to
 ! (ip.src == 10.43.54.65 or ip.dst == 10.43.54.65)


conntrack -E

#wireshark capture filter
https://www.wireshark.org/docs/wsug_html_chunked/ChCapCaptureFilterSection.html
tcp port 23 and host 10.0.0.5
tcp port 23 and not src host 10.0.0.5

A primitive is simply one of the following: [src|dst] host <host>
This primitive allows you to filter on a host IP address or name. You can optionally precede the primitive with the keyword src|dst to specify that you are only interested in source or destination addresses. If these are not present, packets where the specified address appears as either the source or the destination address will be selected.

ether [src|dst] host <ehost>
This primitive allows you to filter on Ethernet host addresses. You can optionally include the keyword src|dst between the keywords ether and host to specify that you are only interested in source or destination addresses. If these are not present, packets where the specified address appears in either the source or destination address will be selected.

gateway host <host>
This primitive allows you to filter on packets that used host as a gateway. That is, where the Ethernet source or destination was host but neither the source nor destination IP address was host.

[src|dst] net <net> [{mask <mask>}|{len <len>}]
This primitive allows you to filter on network numbers. You can optionally precede this primitive with the keyword src|dst to specify that you are only interested in a source or destination network. If neither of these are present, packets will be selected that have the specified network in either the source or destination address. In addition, you can specify either the netmask or the CIDR prefix for the network if they are different from your own.

[tcp|udp] [src|dst] port <port>
This primitive allows you to filter on TCP and UDP port numbers. You can optionally precede this primitive with the keywords src|dst and tcp|udp which allow you to specify that you are only interested in source or destination ports and TCP or UDP packets respectively. The keywords tcp|udp must appear before src|dst.
If these are not specified, packets will be selected for both the TCP and UDP protocols and when the specified address appears in either the source or destination port field.

less|greater <length>
This primitive allows you to filter on packets whose length was less than or equal to the specified length, or greater than or equal to the specified length, respectively.

ip|ether proto <protocol>
This primitive allows you to filter on the specified protocol at either the Ethernet layer or the IP layer.

ether|ip broadcast|multicast
This primitive allows you to filter on either Ethernet or IP broadcasts or multicasts.

<expr> relop <expr>
This primitive allows you to create complex filter expressions that select bytes or ranges of bytes in packets. Please see the pcap-filter man page at http://www.tcpdump.org/manpages/pcap-filter.7.html for more details.



stdbuf -o0 tcpdump # unbuffered IO for piping


pcapfix -d openwrt-1696493214-2.cap # repair broken corrupted

# tshark
tshark -Y http.request.uri -r FILENAME
tshark -qz conv,tcp -r FILENAME
