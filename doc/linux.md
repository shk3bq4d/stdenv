To execute a script at startup of Ubuntu
    Edit /etc/rc.local and add your commands
    The script must always end with exit 0

To execute a script upon rebooting Ubuntu
    Put your script in /etc/rc0.d
    Make it executable (sudo chmod +x myscript)
    Note: The scripts in this directory are executed in alphabetical order
    The name of your script must begin with K99 to run at the right time.


To execute a script at shutdown
    Put your script in /etc/rc6.d
    Make it executable (sudo chmod +x myscript)
    Note: The scripts in this directory are executed in alphabetical order
    The name of your script must begin with K99 to run at the right time.


# oneliners
@begin=sh@
sudo apt-get upgrade # system update
sudo useradd -d /home/testuser -m testuser # user create
sudo usermod -a -G group username # add existing user to existing group
sudo gpasswd -d user group # remove existing uer to existing group
id username # list group of existing user
cut -d: -f1 /etc/passwd # list all users on system
cut -d: -f1 /etc/group # list all groups on system
(echo body text; uuencode ~/path_to_file.jpg attachment_name.jpg ) | mailx -s "email prive $i" -t 123r4p+doclinux87f90a32@gmail.com # email with attachment
dhclient -r; sleep 10; dhclient # renew dhcp
ln -is TARGET LINKNAME
sudo strace -ff -o /tmp/mreclipse -p3266 #trace file access of process and child processes 3266
@end=sh@


Debian versions
1.2 rex        1996-12-12
1.3 bo        1997-06-05
2.0 hamm    1998-07-24
2.1 slink    1999-03-09
2.2 potato    2000-08-15
3.0 woody    2002-07-19
3.1 sarge    2005-06-06
4.0 etch    2007-04-08
5.0 lenny    2009-02-15
6.0 squeeze    2011-02-06
7   wheezy    2013-05-04
8   jessie    TBA

Ubuntu versions
Version     Code name     Release date                                     Supported until
                                          Desktop                                       Server
4.10        Warty Warthog    2004-10-20   Old version, no longer supported: 2006-04-30
5.04        Hoary Hedgehog   2005-04-08   Old version, no longer supported: 2006-10-31
5.10        Breezy Badger    2005-10-13   Old version, no longer supported: 2007-04-13
6.06 LTS    Dapper Drake     2006-06-01   Old version, no longer supported: 2009-07-14 Old version, no longer supported: 2011-06-01
6.10        Edgy Eft         2006-10-26   Old version, no longer supported: 2008-04-25
7.04        Feisty Fawn      2007-04-19   Old version, no longer supported: 2008-10-19
7.10        Gutsy Gibbon     2007-10-18   Old version, no longer supported: 2009-04-18
8.04 LTS    Hardy Heron      2008-04-24   Old version, no longer supported: 2011-05-12 Old version, no longer supported: 2013-05-09
8.10        Intrepid Ibex    2008-10-30   Old version, no longer supported: 2010-04-30
9.04        Jaunty Jackalope 2009-04-23   Old version, no longer supported: 2010-10-23
9.10        Karmic Koala     2009-10-29   Old version, no longer supported: 2011-04-30
10.04 LTS   Lucid Lynx       2010-04-29   Old version, no longer supported: 2013-05-09 Older version, yet still supported: 2015-04
10.10       Maverick Meerkat 2010-10-10   Old version, no longer supported: 2012-04-10
11.04       Natty Narwhal    2011-04-28   Old version, no longer supported: 2012-10-28
11.10       Oneiric Ocelot   2011-10-13   Old version, no longer supported: 2013-05-09
12.04 LTS   Precise Pangolin 2012-04-26   Older version, yet still supported: 2017-04
12.10       Quantal Quetzal  2012-10-18   Older version, yet still supported: 2014-04
13.04       Raring Ringtail  2013-04-25   Older version, yet still supported: 2014-01
13.10       Saucy Salamander 2013-10-17   Current stable version: 2014-07
14.04 LTS   Trusty Tahr      2014-04-17   Future release: 2019-04

dmesg

ifconfig eth0 10.19.29.54
route add default gw 10.19.29.1

# capture short lived process excluding existing the pid that matches the same grep
while :; do ps -eo pid,command | grep java | egrep -vw '542|562|651|21437|grep' >>mrlog; done

########
# time #
########

http://www.cyberciti.biz/faq/howto-set-date-time-from-linux-command-prompt/

#timezone non-systemd
cp /usr/share/zoneinfo/America/Chicago /etc/localtime
ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

#timezone systemd
$ timedatectl list-timezones
$ timedatectl list-timezones | more
$ timedatectl list-timezones | grep -i asia
$ timedatectl list-timezones | grep America/New

To set the time zone to ‘Asia/Kolkata’, enter:
# timedatectl set-timezone 'Asia/Kolkata'

#set time systemd
timedatectl set-time "YYYY-MM-DD HH:MM:SS"
#set time non-systemd
date -s "2 OCT 2006 18:00:00"
date --set="2 OCT 2006 18:00:00"
date +%Y%m%d -s "20081128"
date +%T -s "10:13:13"


#########
# /time #
#########

#display dns
nmcli device show enp0s25
nmcli device show eth0


# nslookup
dig -x 6.1.0.159
dig +noall +answer -x 6.1.0.159
dig @6.1.0.33 +noall +answer -x 6.1.0.159


curl http://beyondgrep.com/ack-2.14-single-file > /bin/ack && chmod 0755 !#:3

ip addr sh


# routing (router if: tun0 is 192.168.20.19, enp0s8 is 192.168.56.103. client if:  on 192.168.56.0 network)
# on router
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -A FORWARD -i enp0s8 -j ACCEPT
sysctl -w net.ipv4.ip_forward=1
cat  /proc/sys/net/ipv4/ip_forward
# on client
route add -net 192.168.20.0 netmask 255.255.255.0 gw 192.168.56.103 metric 99
route add -net 192.168.0.0 netmask 255.255.255.0 metric 1 dev eno2

# network config
vi /etc/sysconfig/network-scripts/ifcfg-ens32 # centos or systemd https://www.centos.org/docs/5/html/5.2/Deployment_Guide/s1-networkscripts-static-routes.html
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
IPV6_AUTOCONF=no
IPV6_DEFROUTE=no
IPV6_PEERDNS=no
IPV6_PEERROUTES=no
IPV6_FAILURE_FATAL=no
NAME=ens32
UUID=e352999b-475d-4638-827b-b6732b61dfb2
DEVICE=ens32
ONBOOT=yes
HWADDR=00:50:56:bf:ba:3b
IPADDR=10.103.28.135
NETMASK=255.255.255.0
GATEWAY=10.3.28.1
DOMAIN=mydomain.local
DNS1=10.3.28.13
DNS2=6.1.0.33
# centos gateway to be set in /etc/sysconfig/network like
GATEWAY=213.244.194.1

vi /etc/network/interfaces #ubuntu14
auto eth1
iface eth1 inet static
    address 10.3.28.2
    gateway 10.3.28.1
    netmask 255.255.255.0
    network 10.3.28.0
    broadcast 10.3.28.255
    dns-search mydomain.local
    dns-nameservers 10.3.28.13 6.1.0.33



route add -net 10.0.0.0 netmask 255.0.0.0 gw 172.172.29.4.1 dev eth1
NEWHOSTNAME=sonarqube3 && sudo hostnamectl set-hostname $NEWHOSTNAME && sudo sed -i -r -e '/^127.0.1.1 / d' /etc/hosts && echo "127.0.1.1 ${NEWHOSTNAME}.pamo.local ${NEWHOSTNAME}" | sed -r -e 's/\.pa(mo\.)/.ru\1/' | sudo tee -a /etc/hosts;

yum whatprovides '*bin/dig'


#/etc/dhcp/dhclient.conf
# remove routers from one of the interface when having more than one (two) interfaces
timeout 300;
retry 60;
interface "eth1" {
    request subnet-mask, broadcast-address, time-offset,
        #routers,
                domain-name,
        domain-name-servers,
        host-name;
}
interface "eth0" {
    request subnet-mask, broadcast-address, time-offset,
        routers,
        domain-name,
        #domain-name-servers,
        host-name;
}
# red hat, centos static route
Static route configuration can be stored per-interface in a /etc/sysconfig/network-scripts/route-interface file. For example, static routes for the eth0 interface would be stored in the /etc/sysconfig/network-scripts/route-eth0 file.
et dans le fichier il suffit de mettre par example:
10.36.211.0/24 via 192.168.168.1 dev eth0


xset -dpms; xset s off; # removes energy saving
xset dpms force on # forces turn off screen

sysctl -w net.ipv4.ip_nonlocal_bind = 1 # bind on unassigned ip, useful in case of failover vip


# netstat replacement
nmap -sT -O localhost
lsof -i -P
ss -l

setxkbmap -option ctrl:nocaps   # Caps Lock as Ctrl
setxkbmap -option caps:capslock # Caps Lock toggles normal capitalization of alphabetic characters
caps:none             =       +capslock(none)
caps:ctrl_modifier    =       +capslock(ctrl_modifier)
ctrl:nocaps           =       +ctrl(nocaps)
ctrl:lctrl_meta       =       +ctrl(lctrl_meta)
ctrl:swapcaps         =       +ctrl(swapcaps)
xmodmap -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock"   #this will make Esc to act as Caps Lock
xmodmap -e "keycode 66 = Escape NoSymbol Escape"        #this will make Caps Lock to act as Esc


# xinitrc
[ ! -d ~/.touch ] && mkdir ~/.touch
touch ~/.touch/touch.xinitrc
xrandr --dpi 120
exec i3

sudo dd if=~/Downloads/DietPi_v148_RPi-armv6-\(Jessie\).img of=/dev/sde && sudo sync

http://www.computerworld.com/article/2693438/unix-how-to-the-linux-etc-inittab-file.html

sudo mount -o loop path/to/iso/file/YOUR_ISO_FILE.ISO /media/iso # mount iso
sudo mount -o rw,uid=$(id -u) /dev/sde1 /mnt/sde1  # mount sdcard as current user

# setuid from python script
# https://stackoverflow.com/questions/24541427/setuid-setgid-wrapper-for-python-script
$ cat scriptwrap.c
@begin=c@
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char *argv[]) {
    setuid(geteuid());
    setgid(getegid());
    return execv("/home/user/tmp/bip.py", argv);
}
@end=sh@
$ cat /home/user/tmp/bip.py
#!/usr/bin/env python2
import os

print "uid: %s" % os.getuid()
print "euid: %s" % os.getgid()
print "gid: %s" % os.geteuid()
print "egid: %s" % os.getegid()
gcc scriptwrap.c -o scriptwrap && sudo chown root scriptwrap && sudo chmod u+s scriptwrap

# wireless
nm-applet

mount / -o rw,remount

ifconfig eth0 mtu 1350

https://access.redhat.com/articles/1519843 # bcrypt support for passwords in /etc/shadow

pavucontrol # volume adjustement

getent passwd USERNAME | cut -d: -f6 # retrieve home directory

loadkeys -d # restore keyboard to default
loadkeys us-dvp

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1734147 # bios corruption laptop ubuntu 17.10


http://repo.or.cz/w/retty.git Terminal attaching without screen


# undelete
https://linuxconfig.org/data-recovery-of-deleted-files-from-the-fat-filesystem
https://unix.stackexchange.com/questions/80270/unix-linux-undelete-recover-deleted-files
apt install testdisk
testdisk /dev/mmcblk0

sudo locale | sudo tee /etc/default/locale                                                                                                      3ms


# upowerd full CPU
unplug your iphone or trust the computer, https://askubuntu.com/questions/818965/upowerd-hogging-cpu

dd if=/dev/zero of=file.txt count=1024 bs=1048576 # create One 1Gb gigabyte file

date -d @1532532080

echo bip > /dev/tcp/172.18.13.142/1514 # netcat replacement


kill -SIGQUIT $(pgrep ping) # ping status statistics withou quitting


wall "my message" # How to Send a Message to Logged Users in Linux Terminal broadcast

https://www.reddit.com/r/linuxadmin/comments/9h3x84/ubuntu_vs_centos_should_i_stay_or_should_i_go/

lspci | grep VGA # find out graphical card nvidia amd intel

nice -n 15 clamscan && clamscan --stdout -v -ir /chroot/ # renice


ssh blabla sudo shutdown -r 04:10 # reboot reset remote overnight business hours
date -d "@$( awk -F '=' '/USEC/{ $2=substr($2,1,10); print $2 }' /run/systemd/shutdown/scheduled )"
systemctl status systemd-shutdownd.service

# udev
sudo udevadm monitor --environment --udev # follow udev events
kazam # screen capture video -- record

https://www.osetc.com/en/centos-7-rhel-7-how-to-change-the-system-keyboard-layout.html
localectl list-keymaps | grep us
localectl set-keyp ch-fr

pulseaudio -k # restart pulse audio (will kill the service and system will restart it)

# ipv6

#disable ipv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
