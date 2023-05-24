
# kubedns debug, add
- --log-queries=extra

      - args:
        - -v=2
        - -logtostderr
        - -configDir=/etc/k8s/dns/dnsmasq-nanny
        - -restartDnsmasq=true
        - --
        - -k
        - --cache-size=1000
        - --dns-forward-max=250
        - --log-queries=extra   # <--- in *here*
        - --no-negcache
        - --log-facility=-
        - --server=/cluster.local/127.0.0.1#10053
        - --server=/in-addr.arpa/127.0.0.1#10053
        - --server=/in6.arpa/127.0.0.1#10053


# openwrt --log-queries=extra
/usr/sbin/dnsmasq -C /var/etc/dnsmasq.conf.cfg01411c -d -x /var/run/dnsmasq/dnsmasq.cfg01411c.pid --log-queries=extra 2>&1 | grep 10.19.29.83

# jumphost at work
```sh
# a) on jump start a DNSmasq server on non-protected port
dnsmasq -p 5353 --log-queries=extra --no-resolv --server=8.8.4.4 --dns-loop-detect --stop-dns-rebind --no-daemon 2>&1 | ts | grep --color=always -i -E 'my|domains|of|interest'
# b) openit for everyone by either adding an iptable rule for it or flushing everything
iptables -A INPUT -p udp -m udp --dport 5353 -j ACCEPT
# c) play the voodoo iptables on target machine (you may need to adapt, the example worked for me once)
iptables -t nat -I OUTPUT 0 -p udp --dport 53 -j LOG --log-prefix "grepme output "      --log-level 6 # this is NOOP, but allows to grep dmesg or /var/log/messages for rule HIT
iptables -t nat -A OUTPUT   -p udp --dport 53 -j DNAT --to 10.202.10.69:5353


Option 3—Router option. It specifies the gateway address.
Option 6—DNS server option. It specifies the DNS server's IP address.
Option 33—Static route option. It specifies a list of classful static routes (the destination network addresses in these static routes are classful) that a client should add into its routing table. If both Option 33 and Option 121 exist, Option 33 is ignored.
Option 51—IP address lease option.
Option 53—DHCP message type option. It identifies the type of the DHCP message.
Option 55—Parameter request list option. It is used by a DHCP client to request specified configuration parameters. The option contains values that correspond to the parameters requested by the client.
Option 60—Vendor class identifier option. It is used by a DHCP client to identify its vendor, and by a DHCP server to distinguish DHCP clients by vendor class and assign specific IP addresses to the DHCP clients.
Option 66—TFTP server name option. It specifies a TFTP server to be assigned to the client.
Option 67—Boot file name option. It specifies the boot file name to be assigned to the client.
Option 121—Classless route option. It specifies a list of classless static routes (the destination network addresses in these static routes are classless) that the requesting client should add to its routing table. If both Option 33 and Option 121 exist, Option 33 is ignored.
Option 150—TFTP server IP address option. It specifies the TFTP server IP address to be assigned to the client.
