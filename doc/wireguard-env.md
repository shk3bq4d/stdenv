* https://gist.github.com/marvin-marvin/34347e118e3f9f62e22eec6d6cead5fa # centos7
* https://forums.centos.org/viewtopic.php?t=75586 # centos7
* https://github.com/githubixx/ansible-role-wireguard

```sh
man wg
man wg-quick


wg genkey | wg pubkey # create a dummy public key 9yRg/5yupXqZ9OtriRiCc5hBloH22N8AmtuRhBPNcm0=

grep -n -R ^PrivateKey /etc/wireguard/*.conf  | while read fileandline equal key leftover; do echo "$fileandline -> Public: $(echo $key | wg pubkey)"; done


systemctl stop wg-quick@wg0

wg show
wg showconf wg0

# share config, hiding private keys and comment
for i in /etc/wireguard/*conf; do echo "# ====== $i ======"; sed-remove-comment.sh $i | sed -r -e 's/(PrivateKey[^a-z]+)([a-zA-Z0-9=/+]{30,60})/\1__________________________________________/gi' -e 's/^\[/\n\[/'; echo; done

# activate IP forwarding
echo 1 | tee /proc/sys/net/ipv4/ip_forward

# check IP forwarding
cat /proc/sys/net/ipv4/ip_forward

# add kernel debugging
modprobe wireguard && echo "module wireguard +p"  |tee  /sys/kernel/debug/dynamic_debug/control

# add kernel debugging + follow logs one liner
modprobe wireguard && echo "module wireguard +p"  |tee  /sys/kernel/debug/dynamic_debug/control; dmesg -wL=always | grep wireguard

# follow logs one liner
dmesg -wL always | grep wireguard # centos
dmesg -wL=always | grep wireguard # debian

tcpdump -i wg0 -nn
tcpdump -i wg0 -nn host MYHOST

```


Yeah, basically, the .conf files contain two kinds of parameters:

"Native" Wireguard parameters

Additional parameters that only wg-quick interprets and understands.

# private key to public key (GPT)
```python
from cryptography.hazmat.primitives.asymmetric import x25519
from base64 import b64decode, b64encode

# Replace this with your base64-encoded private key
private_key_b64 = "your_base64_encoded_private_key"

# Decode the private key from base64
private_key_bytes = b64decode(private_key_b64)

# Generate the private key object
private_key = x25519.X25519PrivateKey.from_private_bytes(private_key_bytes)

# Derive the public key
public_key = private_key.public_key()

# Get the public key in raw bytes
public_key_bytes = public_key.public_bytes()

# Encode the public key to base64
public_key_b64 = b64encode(public_key_bytes).decode()

print("Public Key:", public_key_b64)
```
