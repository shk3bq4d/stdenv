# APT
apt-get changelog pkgname
sudo apt-get --only-upgrade install zabbix*
dpkg -s docker-ce # test if package is installed
dpkg -S /bin/ls # whatprovides in installed packages
dpkg -S $(which tail) # core-utils
dpkg -L python # list files that were installed per package
apt-file search date # apt-get install apt-file && apt-file update
apt-file search /sbin/ip | grep -Ew ip                                                2" 360
apt-file search ts | grep -E '/ts$' # whatprovides in all packages
iproute2: /sbin/ip
apt list --upgradable
apt list --installed
/etc/apt/sources.list
/etc/apt/sources.list.d/
echo 'Acquire::http:Proxy "http://172.17.0.1:3142"' > /etc/apt/apt.conf.d/93-mr-httproxy

netstat : apt install net-tools
apt update && apt install -y netcat curl wget net-tools; curl http://localhost; nc -v localhost 80
dpkg -S $(which dig) # dnsutils: /usr/bin/dig
 

# YUM
yum provides PROG
yum --showduplicates list httpd | expand # http://unix.stackexchange.com/questions/151689/how-can-i-instruct-yum-to-install-a-specific-version-of-package-x
yum list installed 'http*'
yum info elasticsearch # show version
yum whatprovides ack       && yum clean all
yum whatprovides ack       && yum clean all # moreutils
yum whatprovides ts       && yum clean all # moreutils
yum whatprovides dig       && yum clean all # bind-utils
yum whatprovides locate    && yum clean all # mlocate
yum whatprovides snmpwalk  && yum clean all # net-snmp-utils
yum whatprovides mongodump && yum clean all # mongodb-org-tools
yum clean all

yum-config-manager --disable base,extras,updates

rpm -qa | grep rsyslog
rpm -q kernel # list versions

https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/

## YUM pin
```bash
yum install yum-plugin-versionlock # pin
yum versionlock add puppet # pin
yum versionlock list # pin
yum versionlock delete 0:openldap-2.4.39-8.el6.* # pin
```

# snap
snap install yq

# APK
apk: dig => bind-tools
# cat /etc/alpine-release
3.3.3
# echo 'http://dl-cdn.alpinelinux.org/alpine/v3.2/main' >> /etc/apk/repositories
# apk update
fetch http://dl-cdn.alpinelinux.org/alpine/v3.3/community/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.3/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.2/main/x86_64/APKINDEX.tar.gz

# apk add bash==4.3.33-r0
(1/1) Updating pinning bash (4.3.33-r0)
	OK: 13 MiB in 17 packages

# apk add bash==4.3.42-r3
	(1/2) Upgrading bash (4.3.33-r0 -> 4.3.42-r3)
	Executing bash-4.3.42-r3.post-upgrade
	(2/2) Purging ncurses5-libs (5.9-r1)
	Executing busybox-1.24.1-r7.trigger
	OK: 13 MiB in 16 packages


apk update && apk add python2 py2-pip

sudo apt install -y mlocate   # updatedb
sudo yum install -y mlocate   # updatedb
sudo apt install -y netcat    #nc ncat
sudo yum install -y nmap-ncat #nc netcat 
sudo yum install -y which

# Fedora DNF
dnf provides /bin/find
dnf install neomutt offlineimap notmuch perl-Email-Sender perl-MailTools perl-Mail-Box -y 
dnf copr enable flatcap/neomutt -y
dnf install -y  findutils


yum downgrade rsyslog-8.29.0-2.el7.x86_64

rpm -qlp *rpm # list file in .rpm
dpkg -c ovpc_1.06.94-3_i386.deb # list file in .deb

npm install graylog-cli-dashboard@0.13

/sbin/ip => iproute2 ubuntu 16.04
iputils-ping: /bin/ping
inetutils-ping: /bin/ping


sudo yum reinstall --downloadonly --downloaddir=/home/adminmru zabbix-agent

# FreeBSD PKG
pkg info -D zoneminder

apt install --reinstall docker-ce
apt-cache madison docker-ce # list available version

needs-restarting -r # yum reboot check if necessary
test -f /var/run/reboot-required # apt check restart necessary

aptitude why PACKAGE # describe why package was installed

/var/log/apt/history.log

# mrhyp
sed -e '/mirrorlist=.*/d' -e 's/#baseurl=/baseurl=/' -e "s/\$releasever/7.4.1708/g" -e "s/mirror.centos.org\\/centos/vault.centos.org/g" -i /etc/yum.repos.d/CentOS-Base.repo
