# APT
apt-get changelog pkgname
sudo apt-get --only-upgrade install zabbix*
dpkg -s docker-ce # test if package is installed
dpkg -S /bin/ls # whatprovides
apt-file search date # apt-get install apt-file && apt-file update
apt-file search /sbin/ip | grep -Ew ip                                                2" 360
iproute2: /sbin/ip
apt list --upgradable
apt list --installed
/etc/apt/sources.list
/etc/apt/sources.list.d/
echo 'Acquire::http:Proxy "http://172.17.0.1:3142"' > /etc/apt/apt.conf.d/93-mr-httproxy

# YUM
yum provides PROG
yum --showduplicates list httpd | expand # http://unix.stackexchange.com/questions/151689/how-can-i-instruct-yum-to-install-a-specific-version-of-package-x
yum list installed 'http*'
yum info elasticsearch # show version
yum whatprovides ack
yum whatprovides dig    # bind-utils
yum whatprovides locate # mlocate
apk: dig => bind-tools

rpm -qa | grep rsyslog
rpm -q kernel # list versions


# APK
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

sudo yum install -y nmap-ncat
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


# FreeBSD PKG
pkg info -D zoneminder
