* https://gist.github.com/marvin-marvin/34347e118e3f9f62e22eec6d6cead5fa # centos7
* https://forums.centos.org/viewtopic.php?t=75586 # centos7

wg genkey | wg pubkey # create a dummy public key 9yRg/5yupXqZ9OtriRiCc5hBloH22N8AmtuRhBPNcm0=

grep -n -R ^PrivateKey /etc/wireguard/  | while read fileandline equal key leftover; do echo "$fileandline -> Public: $(echo $key | wg pubkey)"; done


```sh
# share config, hiding private keys and comment
for i in /etc/wireguard/*conf; do echo "# ====== $i ======"; sed-remove-comment.sh $i | sed -r -e 's/(privatekey[^a-z]+)([a-z0-9=/]{30,60})/\1__________________________________________/gi' -e 's/^\[/\n\[/'; echo; done

# activate IP forwarding
echo 1 | tee /proc/sys/net/ipv4/ip_forward

# check IP forwarding
cat /proc/sys/net/ipv4/ip_forward

# add kernel debugging
modprobe wireguard && echo "module wireguard +p"  |tee  /sys/kernel/debug/dynamic_debug/control

# add kernel debugging + follow logs one liner
modprobe wireguard && echo "module wireguard +p"  |tee  /sys/kernel/debug/dynamic_debug/control; dmesg -wLalways | grep wireguard

# follow logs one liner
dmesg -wLalways | grep wireguard

tcpdump -i wg0 -nn
tcpdump -i wg0 -nn host MYHOST

