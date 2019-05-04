# reread /etc/ethers and /etc/hosts
ps | grep -v grep | grep dnsmasq | awk '{print $1'} | xargs kill -SIGHUP


# may 2018 tp-link archer c2600 v1.0
https://openwrt.org/toh/tp-link/tp-link_archer_c2600_v1
https://openwrt.org/docs/guide-user/installation/generic.flashing.tftp
wget http://downloads.lede-project.org/releases/17.01.4/targets/ipq806x/generic/lede-17.01.4-ipq806x-C2600-squashfs-factory.bin
cp -p lede-17.01.4-ipq806x-C2600-squashfs-factory.bin ArcherC2600_1.0_tp_recovery.bin
sudo systemctl stop NetworkManager
sudo killall dnsmasq
@begin=sh@
#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 01 May 2018
##

set -euo pipefail

USER=$(whoami )
IFNAME=eno2
sudo ip address flush dev $IFNAME
sudo ip address add 192.168.0.66/24 dev $IFNAME
sudo dnsmasq -i $IFNAME --dhcp-range=192.168.0.86,192.168.0.155 \
--dhcp-boot=ArcherC2600_1.0_tp_recovery.bin \
--enable-tftp --tftp-root=$(pwd) -d -u $USER -p0 -K --log-dhcp --bootp-dynamic \
--dhcp-leasefile=./leases

echo EOF
exit 0
@end=sh@
sudo ifconfig eno2 192.168.1.89
browser to http://192.168.1.1
# current version is Powered by LuCI lede-17.01 branch (git-17.290.79498-d3f0685) / LEDE Reboot 17.01.4 r3560-79f57e422d
wget wget http://downloads.lede-project.org/releases/17.01.4/targets/ipq806x/generic/lede-17.01.4-ipq806x-C2600-squashfs-sysupgrade.bin
browser to http://192.168.1.1 upgrade
slow and version appears to be the same # Powered by LuCI lede-17.01 branch (git-17.290.79498-d3f0685) / LEDE Reboot 17.01.4 r3560-79f57e422d

# wifi failing
with error message "Wireless is disabled or not associated"
went to https://www.reddit.com/r/openwrt/comments/6afbxh/wireless_is_disabled_or_not_associated/ 
and
ssh to box and run "iw phy0 info", then reenable interface on GUI

curl 'http://10.19.29.251/cgi-bin/luci/?status=1&_=0.8997745715767451' -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.9,fr;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/73.0.3683.86 Chrome/73.0.3683.86 Safari/537.36' -H 'Accept: */*' -H 'Referer: http://10.19.29.251/cgi-bin/luci/' -H 'Cookie: sysauth=ac182ba23a11f1fb6fcfc74596be7d61' -H 'Connection: keep-alive' --compressed
```json
{
    "conncount": 11,
    "connmax": 16384,
    "leases": [],
    "leases6": [],
    "loadavg": [
        81568,
        48256,
        23200
    ],
    "localtime": "Thu May  2 13:33:40 2019",
    "memory": {
        "buffered": 2764800,
        "free": 444407808,
        "shared": 458752,
        "total": 493223936
    },
    "swap": {
        "free": 0,
        "total": 0
    },
    "uptime": 10597523,
    "wan": {
        "dns": [
            "10.19.29.1"
        ],
        "expires": -1,
        "gwaddr": "10.19.29.1",
        "ifname": "br-lan",
        "ipaddr": "10.19.29.251",
        "link": "/cgi-bin/luci/admin/network/network/lan",
        "netmask": "255.0.0.0",
        "proto": "static",
        "uptime": 10597497
    },
    "wifinets": [
        {
            "device": "radio0",
            "name": "Generic 802.11ac Wireless Controller (radio0)",
            "networks": [
                {
                    "assoclist": [],
                    "country": "US",
                    "disabled": true,
                    "encryption": "-",
                    "ifname": "radio0.network1",
                    "link": "/cgi-bin/luci/admin/network/wireless/radio0.network1",
                    "mode": "Unknown",
                    "name": "Unknown \"njsfjlk FDS354\"",
                    "noise": 0,
                    "quality": 0,
                    "signal": 0,
                    "ssid": "njsfjlk FDS354",
                    "txpower": 0,
                    "txpoweroff": 0,
                    "up": false
                },
                {
                    "assoclist": [],
                    "country": "US",
                    "disabled": true,
                    "encryption": "-",
                    "ifname": "radio0.network2",
                    "link": "/cgi-bin/luci/admin/network/wireless/radio0.network2",
                    "mode": "Unknown",
                    "name": "Unknown \"Olivia\"",
                    "noise": 0,
                    "quality": 0,
                    "signal": 0,
                    "ssid": "Olivia",
                    "txpower": 0,
                    "txpoweroff": 0,
                    "up": false
                },
                {
                    "assoclist": [],
                    "country": "US",
                    "disabled": true,
                    "encryption": "-",
                    "ifname": "radio0.network3",
                    "link": "/cgi-bin/luci/admin/network/wireless/radio0.network3",
                    "mode": "Unknown",
                    "name": "Unknown \"Olivia151\"",
                    "noise": 0,
                    "quality": 0,
                    "signal": 0,
                    "ssid": "Olivia151",
                    "txpower": 0,
                    "txpoweroff": 0,
                    "up": false
                }
            ],
            "up": false
        },
        {
            "device": "radio1",
            "name": "Generic 802.11bgn Wireless Controller (radio1)",
            "networks": [
                {
                    "assoclist": [],
                    "country": "US",
                    "disabled": true,
                    "encryption": "-",
                    "ifname": "radio1.network1",
                    "link": "/cgi-bin/luci/admin/network/wireless/radio1.network1",
                    "mode": "Unknown",
                    "name": "Unknown \"njsfjlk FDS354\"",
                    "noise": 0,
                    "quality": 0,
                    "signal": 0,
                    "ssid": "njsfjlk FDS354",
                    "txpower": 0,
                    "txpoweroff": 0,
                    "up": false
                },
                {
                    "assoclist": [],
                    "country": "US",
                    "disabled": true,
                    "encryption": "-",
                    "ifname": "radio1.network2",
                    "link": "/cgi-bin/luci/admin/network/wireless/radio1.network2",
                    "mode": "Unknown",
                    "name": "Unknown \"Olivia\"",
                    "noise": 0,
                    "quality": 0,
                    "signal": 0,
                    "ssid": "Olivia",
                    "txpower": 0,
                    "txpoweroff": 0,
                    "up": false
                },
                {
                    "assoclist": [],
                    "country": "US",
                    "disabled": true,
                    "encryption": "-",
                    "ifname": "radio1.network3",
                    "link": "/cgi-bin/luci/admin/network/wireless/radio1.network3",
                    "mode": "Unknown",
                    "name": "Unknown \"Olivia-124\"",
                    "noise": 0,
                    "quality": 0,
                    "signal": 0,
                    "ssid": "Olivia-124",
                    "txpower": 0,
                    "txpoweroff": 0,
                    "up": false
                }
            ],
            "up": false
        }
    ]
}
```
