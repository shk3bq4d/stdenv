/bin/ip addr show dev <interface>
/bin/ip -j addr  # json
ip -j link show | jq -r '.[].ifname'
