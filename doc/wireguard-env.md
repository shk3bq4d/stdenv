* https://gist.github.com/marvin-marvin/34347e118e3f9f62e22eec6d6cead5fa # centos7
* https://forums.centos.org/viewtopic.php?t=75586 # centos7


grep -n -R ^PrivateKey /etc/wireguard/  | while read fileandline equal key leftover; do echo "$fileandline -> Public: $(echo $key | wg pubkey)"; done


echo 1 | tee /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/ip_forward
modprobe wireguard && echo "module wireguard +p"  |tee  /sys/kernel/debug/dynamic_debug/control; dmesg -w | grep wireguard

tcpdump -i wg0 -nn
tcpdump -i wg0 -nn host MYHOST
