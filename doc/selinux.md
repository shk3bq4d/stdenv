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
