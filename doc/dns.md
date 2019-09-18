dig -x 195.94.108.9 # reverse DNS lookup

dig +short mail.microsoft.com @10.8.92.180


https://www.madboa.com/geek/dig/

```sh
python -c 'import socket; print socket.gethostbyname("www.example.com")'
ping -q -c 1 -t 1 your_host_here | grep PING | sed -e "s/).*//" | sed -e "s/.*(//"
getent hosts unix.stackexchange.com | cut -d' ' -f1 # 
host unix.stackexchange.com | awk '/has address/ { print $4 }' # directly to DNS server
nslookup unix.stackexchange.com | awk '/^Address: / { print $2 }' # directly to DNS server
dig unix.stackexchange.com | awk '/^;; ANSWER SECTION:$/ { getline ; print $5 }' # directly to DNS server
dig +tcp   +short unix.stackexchange.com
dig +notcp +short unix.stackexchange.com
```



# A Records
A Records are the most basic type of DNS record and are used to point a domain or
subdomain to an IP address. Assigning a value to an A record is as simple as providing
your DNS management panel with an IP address to where the domain or subdomain
should point and a TTL.

# AAAA IP Version 6 Address records (AAAA)
The record AAAA (also quad-A record) specifies IPv6 address for given host. So it
works the same way as the A record and the difference is the type of IP address.

# CNAME
The CNAME record specifies a domain name that has to be queried in order to resolve
the original DNS query. Therefore CNAME records are used for creating aliases of domain
names. CNAME records are truly useful when we want to alias our domain to an external
domain. In other cases we can remove CNAME records and replace them with A records and
even decrease performance overhead.

# MX Record
Mail Exchanger (MX) records are used to help route email according the domain owners
preference. The MX record itself specifies which server(s) to attempt to use to deliver
mail to when this type of request is made to the domain. They differ from A Records and
CNAMEs in the way that they also require a “priority” value as a part of their entry.
The priority number is used to indicate which of the servers listed as MX records it
should attempt to use first.

# TXT Record
A TXT record is used to store any text-based information that can be grabbed when
necessary. We most commonly see TXT records used to hold SPF data and verify domain
ownership.

# HINFO Host Information records (HINFO)
HINFO records are used to acquire general information about a host. The record specifies
type of CPU and OS. The HINFO record data provides the possibility to use operating system
specific protocols when two hosts want to communicate. For security reasons the HINFO
records are not typically used on public servers.
Note: Standard values in RFC 1010

# ISDN Integrated Services Digital Network records (ISDN)
The ISDN resource record specifies ISDN address for a host. An ISDN address is a telephone
number that consists of a country code, a national destination code, a ISDN Subscriber number
and, optionally, a ISDN subaddress. The function of the record is only variation of the A
resource record function.


# NS Name Server records (NS)
The NS record specifies an authoritative name server for given host.

# PTR Reverse-lookup Pointer records (PTR)
As opposed to forward DNS resolution (A and AAAA DNS records), the PTR record is used to look
up domain names based on an IP address.

# SOA Start of Authority records (SOA)
The record specifies core information about a DNS zone, including the primary name server, the
email of the domain administrator, the domain serial number, and several timers relating to
refreshing the zone.


blablawhatever.192.168.1.1.nip.io # nip.io is free service to have a hostname for any IPv4
