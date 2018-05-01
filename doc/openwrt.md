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
