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
apt purge postfix\* # erase
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
yum history info last
yum history info 331
yum reinstall glibc openssl-libs dbus linux-firmware gnutls systemd
yum-complete-transaction # compares /var/lib/yum-transaction-all-* and /var/lib/yum-transaction-done-* and finishes work

yum list updates -q | awk 'NR>1 {print $1}' | xargs -rtn 1 yum -y update # install updates one by one

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
DEBIAN_FRONTEND=noninteractive apt install -y postfix
DEBIAN_FRONTEND=noninteractive dpkg --configure postfix

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

sudo apt -oDebug::pkgAcquire::Worker=1 update # verbose loglevel debug
```


# ubuntu sources list
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

# apt unattended upgrade
sudo apt update && sudo unattended-upgrade --verbose --dry-run
sudo apt update && sudo unattended-upgrade --verbose
systemctl status unattended-upgrades.service
/var/log/unattended-upgrades
## /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
## /etc/apt/apt.conf.d/50unattended-upgrades
// Automatically upgrade packages from these (origin:archive) pairs
//
// Note that in Ubuntu security updates may pull in new dependencies
// from non-security sources (e.g. chromium). By allowing the release
// pocket these get automatically pulled in.
Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}";
    "${distro_id}:${distro_codename}-security";
    // Extended Security Maintenance; doesn't necessarily exist for
    // every release and this system may not have it installed, but if
    // available, the policy for updates is such that unattended-upgrades
    // should also install from here by default.
    "${distro_id}ESMApps:${distro_codename}-apps-security";
    "${distro_id}ESM:${distro_codename}-infra-security";
//  "${distro_id}:${distro_codename}-updates";
//  "${distro_id}:${distro_codename}-proposed";
//  "${distro_id}:${distro_codename}-backports";
};

// Python regular expressions, matching packages to exclude from upgrading
Unattended-Upgrade::Package-Blacklist {
    // The following matches all packages starting with linux-
//  "linux-";

    // Use $ to explicitely define the end of a package name. Without
    // the $, "libc6" would match all of them.
//  "libc6$";
//  "libc6-dev$";
//  "libc6-i686$";

    // Special characters need escaping
//  "libstdc\+\+6$";

    // The following matches packages like xen-system-amd64, xen-utils-4.1,
    // xenstore-utils and libxenstore3.0
//  "(lib)?xen(store)?";

    // For more information about Python regular expressions, see
    // https://docs.python.org/3/howto/regex.html
};

// This option controls whether the development release of Ubuntu will be
// upgraded automatically. Valid values are "true", "false", and "auto".
Unattended-Upgrade::DevRelease "auto";

// This option allows you to control if on a unclean dpkg exit
// unattended-upgrades will automatically run
//   dpkg --force-confold --configure -a
// The default is true, to ensure updates keep getting installed
//Unattended-Upgrade::AutoFixInterruptedDpkg "true";

// Split the upgrade into the smallest possible chunks so that
// they can be interrupted with SIGTERM. This makes the upgrade
// a bit slower but it has the benefit that shutdown while a upgrade
// is running is possible (with a small delay)
//Unattended-Upgrade::MinimalSteps "true";

// Install all updates when the machine is shutting down
// instead of doing it in the background while the machine is running.
// This will (obviously) make shutdown slower.
// Unattended-upgrades increases logind's InhibitDelayMaxSec to 30s.
// This allows more time for unattended-upgrades to shut down gracefully
// or even install a few packages in InstallOnShutdown mode, but is still a
// big step back from the 30 minutes allowed for InstallOnShutdown previously.
// Users enabling InstallOnShutdown mode are advised to increase
// InhibitDelayMaxSec even further, possibly to 30 minutes.
//Unattended-Upgrade::InstallOnShutdown "false";

// Send email to this address for problems or packages upgrades
// If empty or unset then no email is sent, make sure that you
// have a working mail setup on your system. A package that provides
// 'mailx' must be installed. E.g. "user@example.com"
//Unattended-Upgrade::Mail "";

// Set this value to one of:
//    "always", "only-on-error" or "on-change"
// If this is not set, then any legacy MailOnlyOnError (boolean) value
// is used to chose between "only-on-error" and "on-change"
//Unattended-Upgrade::MailReport "on-change";

// Remove unused automatically installed kernel-related packages
// (kernel images, kernel headers and kernel version locked tools).
//Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";

// Do automatic removal of newly unused dependencies after the upgrade
//Unattended-Upgrade::Remove-New-Unused-Dependencies "true";

// Do automatic removal of unused packages after the upgrade
// (equivalent to apt-get autoremove)
//Unattended-Upgrade::Remove-Unused-Dependencies "false";

// Automatically reboot *WITHOUT CONFIRMATION* if
//  the file /var/run/reboot-required is found after the upgrade
//Unattended-Upgrade::Automatic-Reboot "false";

// Automatically reboot even if there are users currently logged in
// when Unattended-Upgrade::Automatic-Reboot is set to true
//Unattended-Upgrade::Automatic-Reboot-WithUsers "true";

// If automatic reboot is enabled and needed, reboot at the specific
// time instead of immediately
//  Default: "now"
//Unattended-Upgrade::Automatic-Reboot-Time "02:00";

// Use apt bandwidth limit feature, this example limits the download
// speed to 70kb/sec
//Acquire::http::Dl-Limit "70";

// Enable logging to syslog. Default is False
// Unattended-Upgrade::SyslogEnable "false";

// Specify syslog facility. Default is daemon
// Unattended-Upgrade::SyslogFacility "daemon";

// Download and install upgrades only on AC power
// (i.e. skip or gracefully stop updates on battery)
// Unattended-Upgrade::OnlyOnACPower "true";

// Download and install upgrades only on non-metered connection
// (i.e. skip or gracefully stop updates on a metered connection)
// Unattended-Upgrade::Skip-Updates-On-Metered-Connections "true";

// Verbose logging
// Unattended-Upgrade::Verbose "false";

// Print debugging information both in unattended-upgrades and
// in unattended-upgrade-shutdown
// Unattended-Upgrade::Debug "false";

// Allow package downgrade if Pin-Priority exceeds 1000
// Unattended-Upgrade::Allow-downgrade "false";

// When APT fails to mark a package to be upgraded or installed try adjusting
// candidates of related packages to help APT's resolver in finding a solution
// where the package can be upgraded or installed.
// This is a workaround until APT's resolver is fixed to always find a
// solution if it exists. (See Debian bug #711128.)
// The fallback is enabled by default, except on Debian's sid release because
// uninstallable packages are frequent there.
// Disabling the fallback speeds up unattended-upgrades when there are
// uninstallable packages at the expense of rarely keeping back packages which
// could be upgraded or installed.
// Unattended-Upgrade::Allow-APT-Mark-Fallback "true";
