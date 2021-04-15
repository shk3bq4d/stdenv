
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
