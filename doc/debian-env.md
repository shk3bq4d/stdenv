* https://www.debian.org/releases/
* https://www.debian.org/releases/stable/
* https://www.debian.org/releases/testing/
* https://www.debian.org/releases/sid/

The current stable distribution of Debian is version 12, codenamed bookworm. It was released on June 10th, 2023.
testing AKA trixie The testing distribution contains packages that haven't been accepted into a stable release yet, but they are in the queue for that. The main advantage of using this distribution is that it has more recent versions of software.
unstable AKA sid The unstable distribution is where active development of Debian occurs. Generally, this distribution is run by developers and those who like to live on the edge. It is recommended that users running unstable should subscribe to the debian-devel-announce mailing list to receive notifications of major changes, for example upgrades that may break.

1.1 Buzz       17 June 1996
1.2 Rex        12 December 1996
1.3 Bo         5 June 1997
2.0 Hamm       24 July 1998
2.1 Slink      9 March 1999
2.2 Potato     14–15 August 2000
3.0 Woody      19 July 2002
3.1 Sarge      6 June 2005
4.0 Etch       8 April 2007
5.0 Lenny      14 February 2009
6.0 Squeeze    6 February 2011
7   Wheezy     4 May 2013  7.11
8   Jessie     25–26 April 2015    8.11
9   Stretch    17 June 2017    9.13
10  Buster     6 July 2019
11  Bullseye   14 August 2021
12  Bookworm   10 June 2023
13  Trixie
14  Forky


# preseed
* https://www.debian.org/releases/stable/i386/apbs02.en.html#preseed-auto
* https://blog.entek.org.uk/notes/2023/08/22/automated-debian-install.html


## dnsmasq
### preseed URL straight from dnsmasq
#### B.2.6. Using a DHCP server to specify preconfiguration files
https://www.debian.org/releases/stable/i386/apbs02.en.html#preseed-bootparms-examples
It's also possible to use DHCP to specify a preconfiguration file to download
from the network. DHCP allows specifying a filename. Normally this is a file to
netboot, but if it appears to be an URL then installation media that support
network preseeding will download the file from the URL and use it as a
preconfiguration file. Here is an example of how to set it up in the dhcpd.conf
for version 3 of the ISC DHCP server (the isc-dhcp-server Debian package).

#### man dnsmasq
 -M,   --dhcp-boot=[tag:<tag>,]<filename>,[<servername>[,<server   address>|<tftp_server‐
       name>]]
              (IPv4 only) Set BOOTP options to be returned by the DHCP server. Server name  and
              address  are  optional:  if not provided, the name is left empty, and the address
              set to the address of the machine running dnsmasq. If dnsmasq is providing a TFTP
              service  (see  --enable-tftp  ) then only the filename is required here to enable
              network booting.  If the optional tag(s) are given, they must match for this con‐
              figuration  to be sent.  Instead of an IP address, the TFTP server address can be
              given as a domain name which is looked up in /etc/hosts. This name can be associ‐
              ated  in /etc/hosts with multiple IP addresses, which are used round-robin.  This
              facility can be used to load balance the tftp load among a set of servers.
