# APT
```sh
apt-get changelog pkgname
sudo apt-get --only-upgrade install zabbix*
dpkg -s docker-ce # test if package is installed
dpkg -S /bin/ls # whatprovides in installed packages
dpkg -S $(which tail) # whatprovides core-utils
dpkg -L python # list files that were installed per package
apt install ncurses-term # 'rxvt-256color': unknown terminal type.
apt-file search date # apt-get install apt-file && apt-file update
apt-file search /sbin/ip | grep -Ew ip
apt-file search ts | grep -E '/ts$' # moreutils: whatprovides in all packages
apt-file search apt-file # apt-file: whatprovides in all packages
apt-file search if-config | grep -E '/sbin/ifconfig' # net-tools
apt-file search ldapwhoami| grep -E '/ldapwhoami$' # ldap-utils
iproute2: /sbin/ip
apt list --upgradable
apt list --installed
apt purge
apt list --installed | grep PACKAGE # current version info
/etc/apt/sources.list
/etc/apt/sources.list.d/
echo 'Acquire::http:Proxy "http://172.17.0.1:3142"' > /etc/apt/apt.conf.d/93-mr-httproxy

netstat : apt install net-tools
apt update && apt install -y netcat-traditional curl wget net-tools; curl http://localhost; nc -v localhost 80 # netcat
dpkg -S $(which dig) # dnsutils: /usr/bin/dig

aptitude why PACKAGE # describe why package was installed

/var/log/apt/history.log
```

## APT security updates
```sh
apt-get upgrade -s | grep -i security # list security updates
/usr/lib/update-notifier/apt-check --human-readable # count security updates
sudo unattended-upgrade # apt implicitely applies security updates
```

# YUM
https://linux.die.net/man/5/yum.conf
```sh
yum provides PROG
yum --showduplicates list httpd | expand # http://unix.stackexchange.com/questions/151689/how-can-i-instruct-yum-to-install-a-specific-version-of-package-x available
yum erase 'zabbix*' # purge
yum list installed 'http*'
yum info elasticsearch # show version
yum whatprovides */ldapsearch && yum clean all
yum whatprovides ldapwhoami  && yum clean all # openldap-clients
yum whatprovides ack       && yum clean all
yum whatprovides uuencode  && yum clean all # sharutils
yum whatprovides ack       && yum clean all # moreutils
yum whatprovides ts       && yum clean all # moreutils
yum whatprovides dig       && yum clean all # bind-utils
yum whatprovides locate    && yum clean all # mlocate
yum whatprovides snmpwalk  && yum clean all # net-snmp-utils
yum whatprovides mongodump && yum clean all # mongodb-org-tools
yum whatprovides dos2unix  && yum clean all # dos2unix
yum whatprovides xmllint  && yum clean all # xmlstarlet
yum clean all # cache purge
yum clean all && yum update # upgrade cache purge
yum history # log
yum history redo force-reinstall TRANSACTION_ID1 TRANSACTION_ID2
yum history undo last # rollback
yum reinstall glibc openssl-libs dbus linux-firmware gnutls systemd
yum-complete-transaction # compares /var/lib/yum-transaction-all-* and /var/lib/yum-transaction-done-* and finishes work

yum-config-manager --disable base,extras,updates

rpm -qa | grep rsyslog
rpm -q kernel # list versions
```

https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/

## YUM pin
```bash
yum install yum-plugin-versionlock # pin
yum versionlock add puppet # pin
yum versionlock list # pin
yum versionlock status # find latest available version (that would not be installed)
yum versionlock delete 0:openldap-2.4.39-8.el6.* # unpin
yum versionlock add # pin ALL PACKAGES
yum versionlock delete '*' # unpin ALL PACKAGES
yum versionlock delete 'rsync*'
yum versionlock clear      # unpin ALL packages

```

# snap
snap install yq

# APK
apk: dig => bind-tools
apk: file => file
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
```sh
dnf provides /bin/find
dnf install neomutt offlineimap notmuch perl-Email-Sender perl-MailTools perl-Mail-Box -y
dnf copr enable flatcap/neomutt -y
dnf install -y  findutils


yum downgrade rsyslog-8.29.0-2.el7.x86_64

rpm -qlp *rpm # list file in .rpm ls extract filelist
dpkg -c ovpc_1.06.94-3_i386.deb # list file in .deb

npm install graylog-cli-dashboard@0.13

/sbin/ip => iproute2 ubuntu 16.04
iputils-ping: /bin/ping
inetutils-ping: /bin/ping


sudo yum reinstall --downloadonly --downloaddir=/home/adminmru zabbix-agent
yum reinstall kernel-3.10.0-1160.11.1.el7

ENV DEBIAN_FRONTEND noninteractive # DockerFile build

```

# FreeBSD PKG
```sh
pkg info -D zoneminder

apt install --reinstall docker-ce
apt-cache madison docker-ce # list available version

needs-restarting -r # yum reboot check if necessary
test -f /var/run/reboot-required # apt check restart necessary

```

# mrhyp
```sh
sed -e '/mirrorlist=.*/d' -e 's/#baseurl=/baseurl=/' -e "s/\$releasever/7.4.1708/g" -e "s/mirror.centos.org\\/centos/vault.centos.org/g" -i /etc/yum.repos.d/CentOS-Base.repo
```



# clean boot
```sh
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | grep -E 'linux-(cloud|headers|image|modules|tools)-' | xargs sudo apt-get -y purge #no space left on device (/boot) on apt-get: here is how to clean
```

# remove old kernel
```sh
sudo package-cleanup -y --oldkernels --count=2
ansible -m shell -vba 'yum list installed kernel'                 jump\*                | grep -E '^changed|^kernel'
ansible -m shell -vba 'package-cleanup -y --oldkernels --count=2' 'azure:&prod:&linux'
```

# extract rpm
```sh
rpm2cpio moxapi-7.10.5-1.x86_64.rpm|cpio -idmv # extract rpm unzip
```

# yum exclude
```sh
yum update --exclude=kernel* # interactively
```

```ini
[main]
cachedir=/var/cache/yum/$basearch/$releasever
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
exclude=kernel* redhat-release* # space separated list excludes in /etc/yum.repo.d file

ubuntu-security-status --unavailable # unsupported packages
apt-mark showhold # show held packages
sudo apt-get purge $(dpkg -l | grep '^rc' | awk '{print $2}') # remove packages with residual config

rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'


rm -f /var/lib/rpm/__db*; rpm --rebuilddb; yum clean all; # error: rpmdb: BDB0113 Thread/process 15549/140539555264576 failed: BDB1507 Thread died in Berkeley DB library # error: db5 error(-30973) from dbenv->failchk: BDB0087 DB_RUNRECOVERY: Fatal error, run database recovery # error: cannot open Packages index using db5 -  (-30973) # error: cannot open Packages database in /var/lib/rpm # CRITICAL:yum.main:
