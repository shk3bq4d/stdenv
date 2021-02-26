
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
