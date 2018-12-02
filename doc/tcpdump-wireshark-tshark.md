https://danielmiessler.com/study/tcpdump/
tcpdump -i vtnet0 -X host 10.50.219.121 and not dst port 65530 and not dst port 443
/usr/sbin/tcpdump -i vtnet0 -c 100 -s 0 -w /root/packetcapture.cap ip and tcp and ( host 10.19.29.220 and host 10.19.29.58)
/usr/sbin/tcpdump -i vtnet0 -c 100 -s 0 ip and tcp and ( host 10.19.29.58)
/usr/sbin/tcpdump -i eth0 -c 100 -s 0 ip and tcp and "( host 195.94.110.221)"
wireshark -i enp0s25 -k -f "tcp port 389 and host 10.3.28.13"
wireshark -i lo -k -f "tcp port 65389" # 1) Right click on line, decode AS "LDAP", 2) display filter: "ldap" , 3) profit!

# writes and rotates 10 files of max 1Mb
tcpdump -i ens160 -C 1 -W 10 -w /tmp/salut host 10.36.220.10 and dst port 443

# rsyslog
tcpdump -i eth0 -X dst port 514




#imap JP
/usr/sbin/tcpdump -i vtnet0 -c 100 -s 0 -vv -w jpimap "ip and tcp and ( host 10.19.29.231 and port 143 )"
file jpimap 
jpimap: tcpdump capture file (little-endian) - version 2.4 (Ethernet, capture length 65535)
sudo apt install tcpick
tcpick -C -yP -r jpimap

# gpg search keys
sudo tcpdump -i lo -c 100 -s 0 -vv -w - "ip and tcp and host 127.0.12.12"

# wireshark display filter
https://wiki.wireshark.org/DisplayFilters
Show only SMTP (port 25) and ICMP traffic:

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
