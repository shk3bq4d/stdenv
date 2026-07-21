Set DNS servers
cat /etc/network/interfaces
# It should look something like this:
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
auto eth0
iface eth0 inet static
address 192.168.X.X
netmask 255.255.255.0
gateway 192.168.X.X
dns-nameservers X.X.X.X Y.Y.Y.Y Z.Z.Z.Z
# then execute
sudo ifdown eth0 && sudo ifup eth0

# change hostname
OLD: edit /etc/hostname and /etc/hosts then execute service hostname restart
NEW: sudo hostnamectl hostname MYHOSTNAME

# add new root certificate, (cert file MUST end with .crt)
sudo cp foo.crt /usr/local/share/ca-certificates/foo.crt
sudo update-ca-certificates

# identify-package-origin-of-binary-on-apt-systems/
apt-file search kvm-img

echo "Acquire::http::Proxy \"http://6.1.0.159:3142\";" | sudo tee -a /etc/apt/apt.conf


# desktop notification receiving
dbus-monitor "interface='org.freedesktop.Notifications'"
dbus-monitor "interface='org.freedesktop.Notifications'"    | grep --line-buffered  "member=Notify\|string"
# desktop notification send
notify-send message


# https://askubuntu.com/questions/15520/how-can-i-tell-ubuntu-to-do-nothing-when-i-close-my-laptop-lid
For 13.10 - 18.04:
To make Ubuntu do nothing when laptop lid is closed:
Open the /etc/systemd/logind.conf file in a text editor as root, for example,
sudo -H gedit /etc/systemd/logind.conf
Add a line HandleLidSwitch=ignore (make sure it's not commented out!),
Restart the systemd daemon with this command:
sudo restart systemd-logind
or, from 15.04 onwards:
sudo service systemd-logind restart

sudo update-alternatives --config x-www-browser # change browser
ls -al /usr/bin/x-www-browser                                                                                                            11:17:04  14"420
lrwxrwxrwx 1 root root 31 Dec 18  2017 /usr/bin/x-www-browser -> /etc/alternatives/x-www-browser
ls -al /etc/alternatives/x-www-browser                                                                                                       11:18:14  12ms
 lrwxrwxrwx 1 root root 25 Sep 26 11:16 /etc/alternatives/x-www-browser -> /usr/bin/chromium-browser


# bionic network
```yaml
# $ sudo cat /etc/netplan/01-netcfg.yaml
# $ sudo netplan apply
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:
      dhcp4: no
      addresses:
      - 10.19.29.62/8
      - 10.19.29.63/8
      nameservers:
        addresses:
          - 10.19.29.1
      routes:
      - to: 0.0.0.0/0
        via: 10.19.29.1
        metric: 100
```


# LTS kernel GA and HWE
The first one is the GA (General Availability) kernel, which is the kernel version that is included with the initial release of the LTS. This kernel will receive security updates and critical bug fixes, but will generally not receive any major feature updates.
The second one is the HWE (Hardware Enablement) kernel, which is a newer kernel version that is introduced during the lifecycle of the LTS release. The HWE kernel is designed to provide updated support for newer hardware and to include additional features that were not available in the GA kernel.

## https://en.wikipedia.org/wiki/Ubuntu_version_history
04.04 Warty Warthog
04.10 Hoary Hedgehog
05.06 Breezy Badger
06.04 Dapper Drake
06.10 Edgy Eft
07.04 Feisty Fawn
07.10 Gutsy Gibbon
08.04 Hardy Heron
08.10 Intrepid Ibex
09.04 Jaunty Jackalope
09.10 Karmic Koala
10.04 Lucid Lynx
10.10 Maverick Meerkat
11.04 Natty Narwhal
11.10 Oneiric Ocelot
12.04 Precise Pangolin
12.10 Quantal Quetzal
13.04 Raring Ringtail
13.10 Saucy Salamander
14.04 Trusty Tahr
14.10 Utopic Unicorn
15.04 Vivid Vervet
15.10 Wily Werewolf
16.04 Xenial Xerus
16.10 Yakkety Yak
17.04 Zesty Zapus
17.10 Artful Aardvark
18.04 Bionic Beaver
18.10 Cosmic Cuttlefish
19.04 Disco Dingo
19.10 Eoan Ermine
20.04 Focal Fossa
20.10 Groovy Gorilla
21.04 Hirsute Hippo
21.10 Impish Indri
22.04 Jammy Jellyfish
22.10 Kinetic Kudu
23.04 Lunar Lobster
23.10 Mantic Minotaur
24.04 LTS Noble Numbat
24.10 Oracular Oriole
25.04 Plucky Puffin
25.10 Questing Quokka
26.04 LTS Resolute Raccoon

3.13 -> 14.04
3.16 -> 14.04, 14.10
3.19 -> 14.04, 15.04
4.2  -> 14.04, 15.10
4.4  -> 14.04, 16.04
4.8  -> 16.04, 16.10
4.10 -> 16.04, 17.04
4.13 -> 16.04, 17.10
4.15 -> 16.04, 18.04
4.18 -> 18.04, 18.10
5.0  -> 18.04, 19.04
5.3  -> 18.04, 19.10
5.4  -> 18.04, 20.04
5.8  -> 20.04, 20.10
5.11 -> 20.04, 21.04
5.13 -> 20.04, 21.10
5.15 -> 20.04, 22.04
5.19 -> 22.04, 22.10
6.2  -> 22.04, 23.04
6.5  -> 22.04, 23.10
6.8  -> 22.04, 24.04
6.11 -> 24.04, 24.10
6.14 -> 24.04, 25.04
6.17 -> 24.04, 25.10
7.0  -> 24.04*, 26.04

14.04 LTS Trusty Tahr       3.13, 3.16, 3.19, 4.2, 4.4
14.10     Utopic Unicorn    3.16
15.04     Vivid Vervet      3.19
15.10     Wily Werewolf     4.2

16.04 LTS Xenial Xerus      4.4, 4.8, 4.10, 4.13, 4.15
16.10     Yakkety Yak       4.8
17.04     Zesty Zapus       4.10
17.10     Artful Aardvark   4.13

18.04 LTS Bionic Beaver     4.15, 4.18, 5.0, 5.3, 5.4
18.10     Cosmic Cuttlefish 4.18
19.04     Disco Dingo       5.0
19.10     Eoan Ermine       5.3

20.04 LTS Focal Fossa       5.4, 5.8, 5.11, 5.13, 5.15
20.10     Groovy Gorilla    5.8
21.04     Hirsute Hippo     5.11
21.10     Impish Indri      5.13

22.04 LTS Jammy Jellyfish   5.15, 5.19, 6.2, 6.5, 6.8
22.10     Kinetic Kudu      5.19
23.04     Lunar Lobster     6.2
23.10     Mantic Minotaur   6.5

24.04 LTS Noble Numbat      6.8, 6.11, 6.14, 6.17, 7.0*
24.10     Oracular Oriole   6.11
25.04     Plucky Puffin     6.14
25.10     Questing Quokka   6.17
26.04 LTS Resolute Raccoon  7.0

sudo apt dist-upgrade # minor release upgrades between 22.04.{1,2}
sudo do-release-upgrade # major dist upgrade

# unattended-upgrade
/var/log/unattended-upgrades/unattended-upgrades.log
systemctl status apt-daily-upgrade.timer
journalctl -eu apt-daily-upgrade.timer
/etc/apt/apt.conf.d/50unattended-upgrades

ubuntu/jammy 	pushed by rapid7 10 months ago
ubuntu/focal 	pushed by rapid7 10 months ago
bionic 	pushed by rapid7 10 months ago
xenial
# apt repository
## 22.04 jammy
deb http://ch.archive.ubuntu.com/ubuntu/ jammy main restricted
deb http://ch.archive.ubuntu.com/ubuntu/ jammy-updates main restricted
deb http://ch.archive.ubuntu.com/ubuntu/ jammy universe
deb http://ch.archive.ubuntu.com/ubuntu/ jammy-updates universe
deb http://ch.archive.ubuntu.com/ubuntu/ jammy multiverse
deb http://ch.archive.ubuntu.com/ubuntu/ jammy-updates multiverse
deb http://ch.archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu jammy-security main restricted
deb http://security.ubuntu.com/ubuntu jammy-security universe
deb http://security.ubuntu.com/ubuntu jammy-security multiverse
