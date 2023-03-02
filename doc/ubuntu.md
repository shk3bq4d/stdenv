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
NEW: sudo hostnamectl MYHOSTNAME

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
22.04 jammy
