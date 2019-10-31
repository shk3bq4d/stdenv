sestatus
cat /etc/sysconfig/selinux
think of rebooting if changing mode
restorecon -r / # reapply on each file
$ ls -lZ /data


# to not do as untested
getsebool -a | grep zabbix
setsebool -P zabbix_can_network on


https://www.mangeek.com/2017/03/using-zabbix-3-2-with-centos-and-selinux/
Edit your zabbix systemd startup because it’s currently broken and the PID file is pointing at /run instead of /var/run: vi /usr/lib/systemd/system/zabbix-agent.service
yum install policycoreutils-python
systemctl start zabbix-agent.service
grep "denied.*zabbix_agent" /var/log/audit/audit.log | audit2allow -M zabbix_agent
semodule -i zabbix_agent.pp
systemctl start zabbix-agent.service

getsebool -a # list all options


semanage port -a -t syslogd_port_t -p tcp 10514 # rsyslog


# AVC Access Vector Cache
SELinux decisions, such as allowing or disallowing access, are cached. This cache is known as the
Access Vector Cache (AVC). Denial messages are logged when SELinux denies access.  These denials are
also known as "AVC denials", and are logged to a different location, depending on which daemons are
running:

date -d @1465016400 # unix epoch timestamp
python -c "import datetime; print(datetime.datetime.fromtimestamp(1532532080))" # unix epoch timestamp


# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted
