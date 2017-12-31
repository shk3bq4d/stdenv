# reread /etc/ethers and /etc/hosts
ps | grep -v grep | grep dnsmasq | awk '{print $1'} | xargs kill -SIGHUP

