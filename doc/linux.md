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
```bash
sudo apt-get upgrade # system update
sudo useradd -d /home/testuser -m testuser # user create
sudo useradd -d /home/myhomedir --createhome --uid 990 --gid 992 testuser # user create
sudo usermod -a -G group username # add existing user to existing group
sudo gpasswd -d user group # remove existing user from existing group
id username # list group of existing user
cut -d: -f1 /etc/passwd # list all users on system
cut -d: -f1 /etc/group # list all groups on system
(echo body text; uuencode ~/path_to_file.jpg attachment_name.jpg ) | mailx -S smtp=MYSMTPSERVER -s "email prive $i" -t 123r4p+doclinux87f90a32@gmail.com # email with attachment
dhclient -r; sleep 10; dhclient # renew dhcp
ln -is TARGET LINKNAME
sudo strace -ff -o /tmp/mreclipse -p3266 #trace file access of process and child processes 3266
grep ^processor /proc/cpuinfo | wc -l # CPU count
```


## Debian versions
```bash
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
```

```bash
dmesg

ifconfig eth0 10.19.29.54 netmask 255.255.255.0 # ifconfig route gateway
route add default gw 10.19.29.1 #                 ifconfig route gateway
route del -net 192.168.20.0 netmask 255.255.255.0 gw 192.168.56.103
route add -net 192.168.20.0 netmask 255.255.255.0 gw 192.168.56.103
route add -net 192.168.20.0 netmask 255.255.255.0 gw 192.168.56.103 dev enp8s0 onlink
ip route add 192.168.1.2 via 192.168.0.1
ip route add 100.64.0.0/16 via 10.0.0.103
ip route del 100.64.0.0/16 via 10.0.0.103 dev eth1
sudo ip route flush default # removes default gw

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
sudo date +%s --set $(date -d "-6min" +%s) # set system date 6 min earlier


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


systctl -w net.ipv4.tcp_keepalive_time=1800
systctl -w net.ipv4.tcp_tw_reuse=1
systctl -w net.ipv4.tcp_tw_recycle=1
cat /proc/sys/net/ipv4/tcp_keepalive_time
cat /proc/sys/net/ipv4/tcp_tw_reuse
cat /proc/sys/net/ipv4/tcp_tw_recycle


# routing (router if: tun0 is 192.168.20.19, enp0s8 is 192.168.56.103. client if:  on 192.168.56.0 network)
# on router
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -A FORWARD -i enp0s8 -j ACCEPT
sysctl -w net.ipv4.ip_forward=1
cat  /proc/sys/net/ipv4/ip_forward # sysctl
# on client
route add -net 192.168.20.0 netmask 255.255.255.0 gw 192.168.56.103 metric 99
route add -net 192.168.0.0 netmask 255.255.255.0 metric 1 dev eno2

# network config
vi /etc/sysconfig/network-scripts/ifcfg-ens32 # centos or systemd https://www.centos.org/docs/5/html/5.2/Deployment_Guide/s1-networkscripts-static-routes.html
```sh
NEWIP=10.101.6.197; sed -r -i -e "s/^IPADDR=.*/IPADDR=$NEWIP/" /etc/sysconfig/network-scripts/ifcfg-eth0
```


```ini
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
```
```sh
vi /etc/network/interfaces #ubuntu14
```
```ini
auto eth1
iface eth1 inet static
    address 10.3.28.2
    gateway 10.3.28.1
    netmask 255.255.255.0
    network 10.3.28.0
    broadcast 10.3.28.255
    dns-search mydomain.local
    dns-nameservers 10.3.28.13 6.1.0.33
```


```sh
route add -net 10.0.0.0 netmask 255.0.0.0 gw 172.172.29.4.1 dev eth1
NEWHOSTNAME=sonarqube3 && sudo hostnamectl hostname $NEWHOSTNAME && sudo sed -i -r -e '/^127.0.1.1 / d' /etc/hosts && echo "127.0.1.1 ${NEWHOSTNAME}.pamo.local ${NEWHOSTNAME}" | sed -r -e 's/\.pa(mo\.)/.ru\1/' | sudo tee -a /etc/hosts;

yum whatprovides '*bin/dig'
```


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


xset -dpms; xset s off; # removes energy saving screensaver power
xset dpms force on # forces turn off screen screensaver power saving
xset q # query current status screensaver dpms power saving energy

sysctl -w net.ipv4.ip_nonlocal_bind = 1 # bind on unassigned ip, useful in case of failover vip

fuser -mv /dev/mapper/vgroot-lvdocker
lsof | grep docker

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
```js
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char *argv[]) {
    setuid(geteuid());
    setgid(getegid());
    return execv("/home/user/tmp/bip.py", argv);
}
```
$ cat /home/user/tmp/bip.py

```python
#!/usr/bin/env python2
import os

print "uid: %s" % os.getuid()
print "euid: %s" % os.getgid()
print "gid: %s" % os.geteuid()
print "egid: %s" % os.getegid()
```
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
     nice -n +18 openssl dhparam -out /tmp/low-priority-process.pem 4096
sudo nice -n -18 openssl dhparam -out /tmp/high-priority-requires-sudo-with-nice.pem 4096
renice +2 $(pgrep blobfuse) # lower priority of process
renice -2 $(pgrep blobfuse) # higher priority of process


ssh blabla sudo shutdown -r 04:10 # reboot reset remote overnight business hours
date -d "@$( awk -F '=' '/USEC/{ $2=substr($2,1,10); print $2 }' /run/systemd/shutdown/scheduled )"
systemctl status systemd-shutdownd.service

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

# systctl
cat /proc/sys/net/ipv4/{tcp_keepalive_time,tcp_tw_reuse,tcp_tw_recycle}

# umask
+ umask 007
+ umask -S
u=rwx,g=rwx,o=
+ touch umask-f-007
+ mkdir umask-d-007
+ umask 027
+ umask -S
u=rwx,g=rx,o=
+ touch umask-f-027
+ mkdir umask-d-027
+ ls -ld umask-d-007 umask-d-027 umask-f-007 umask-f-027
drwxrwx--- umask-d-007
-rw-rw---- umask-f-007
drwxr-x--- umask-d-027
-rw-r----- umask-f-027



IFNAME=enp0s31f6
sudo ip address flush dev $IFNAME
sudo ip address add 192.168.1.254/24 dev $IFNAME

# battery
```sh
# method 1)
cat /sys/class/power_supply/BAT0/capacity
# method 2)
find /sys/class/power_supply/BAT0/ -type f | xargs -tn1 cat
# method 3)
upower -i /org/freedesktop/UPower/devices/battery_BAT0
# method 4)
upower -i `upower -e | grep 'BAT'`
# further methods -> https://ostechnix.com/how-to-check-laptop-battery-status-in-terminal-in-linux/
```

vi /var/mail/$(whoami) # read cron outputs or other local mails

echo -e "\n$(date) hellot" | sudo tee -a /dev/console

sudo systemctl reboot --firmware-setup # reboot to bios uefi

linux /boot/vmlinuz-3.2.0-24-generic root=UUID=bc6f8146-1523-46a6-8b\
6a-64b819ccf2b7 ro  quiet splash
initrd /boot/initrd.img-3.2.0-24-generic init=/bin/bash # to append to grub single user
sudo mount -o remount,rw /partition/identifier /mount/point
sudo mount -o remount,rw /dev/mapper/centos-root /

/sbin/reboot --force

shutdown -r 23:00
shutdown -c # cancels a planned shutdown

kill -STOP 1234 # pause, interrupt programme resume continue
kill -CONT 1234 # pause, interrupt programme resume continue



tc qdisc add    dev eth0 root netem loss 25% # start simulate ping loss
tc qdisc change dev eth0 root netem loss 0%  # stop  simulate ping loss

sudo systemd-resolve --interface wlp0s20f3 --set-dns 8.8.4.4
sudo vi /etc/systemd/resolved.conf # dns


pcmanfm # lightweight GUI file manager explorer
dolphin # GUI file manager explorer
thunar # GUI file manager explorer
double commander # GUI file manager explorer
nemo # GUI file manager explorer
duc # recursive directory size calculator

chage -l       myuser # check human status if password expired How to check the account status in Linux https://www.howtouselinux.com/post/how-to-fix-warning-your-password-has-expired-in-linux
chage -M 99999 myuser # set user password to never expire
chage -E -1    myuser # set user account  to never expire

mytr # my traceroute
journalctl -o short-precise -k -b -1 # last boot dmesg https://unix.stackexchange.com/questions/181067/how-to-read-dmesg-from-previous-session-dmesg-0

find $(find / -maxdepth 1 | grep -Evx '/(|lost+found|mnt|proc|sys)')              # find /
find $(find / -maxdepth 1 | grep -Evx '/(|lost+found|mnt|proc|sys)') -type f      # find /
echo b > /proc/sysrq-trigger | violent reboot
echo b | sudo tee /proc/sysrq-trigger

ps -aef --forest # tree process list

upstart sysv service init init.d update-rc.d # https://askubuntu.com/a/20347


# software
~/bin/mr-shutter.sh # screenshot shutter or flameshot
shutter   # screenshot
flameshot # screenshot

ssh -t myhost sudo date -us @$(date -u +%s) # set remote system time easily

who -b # uptime last boot time

sudo groupadd user1user2; sudo usermod -a -G user1user2 user1; sudo usermod -a -G user1user2 user2; sudo chgrp user1user2 myfile; sudo chmod g+x myfile

/proc/acpi/button/lid/LID/state # laptop lid state

# gnome keyring
sudo apt install libsecret-tools # secret-tool CLI
sudo apt install seahorse        # GUI tool
secret-tool search --all xdg:schema org.freedesktop.Secret.Generic
~/.local/share/keyrings/user.keystore
~/.local/share/keyrings/login.keyring
pgrep gnome-keyring-daemon

kill -TSTP PID # ask to pause politely
kill -STOP PID # hard pause stop
kill -CONT PID # unpause, resume process

SIGHUP (1): Hang up detected on controlling terminal or death of controlling process.
SIGINT (2): Interrupt from keyboard (Ctrl+C).
SIGQUIT (3): Quit from keyboard (produces core dump).
SIGILL (4): Illegal Instruction (usually indicates a corrupted executable or bad hardware).
SIGABRT (6): Abort signal from abort(3) (indicates an abort or crash of a program).
SIGFPE (8): Floating-point exception (e.g., division by zero).
SIGKILL (9): Kill signal that immediately terminates the process. Cannot be caught or ignored.
SIGSEGV (11): Segmentation fault (invalid memory reference).
SIGPIPE (13): Broken pipe (writing to a pipe with no readers).
SIGALRM (14): Timer signal from alarm(2) (used for timing).
SIGTERM (15): Termination signal, requesting graceful shutdown. This is the default signal for kill.
SIGUSR1 (10): User-defined signal 1 (used by applications for custom handling).
SIGUSR2 (12): User-defined signal 2 (another custom user-defined signal).
SIGCHLD (17): Child stopped or terminated (sent to a parent process when a child terminates or stops).
SIGCONT (18): Continue if stopped (resumes a paused process, like with SIGSTOP).
SIGSTOP (19): Stop process (cannot be caught or ignored).
SIGTSTP (20): Stop typed at terminal (Ctrl+Z), similar to SIGSTOP but can be caught or ignored.
SIGTTIN (21): Background process attempting read from TTY (sent when a background process tries to read input).
SIGTTOU (22): Background process attempting write to TTY (sent when a background process tries to write output).
SIGBUS (7): Bus error (generally, misaligned memory access).
SIGPOLL (29): Pollable event (Sys V). Synonym for SIGIO on most platforms.
SIGPROF (27): Profiling timer expired.
SIGSYS (31): Bad argument to routine (invalid system call argument).
SIGTRAP (5): Trace/breakpoint trap (used for debugging).
SIGURG (23): Urgent condition on socket (used for out-of-band data on sockets).
SIGVTALRM (26): Virtual alarm clock (for processes' virtual time).
SIGXCPU (24): CPU time limit exceeded.
SIGXFSZ (25): File size limit exceeded.

			  /var/run/reboot-required # debian ubuntu
