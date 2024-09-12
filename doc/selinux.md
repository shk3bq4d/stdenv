sestatus
cat /etc/sysconfig/selinux
think of rebooting if changing mode
restorecon -r / # reapply on each file
$ ls -lZ /data

sestatus -b
sestatus -b | grep httpd_can_network_connect

# to not do as untested
getsebool -a | grep zabbix
setsebool -P zabbix_can_network on
setsebool -P httpd_can_network_connect on


https://www.mangeek.com/2017/03/using-zabbix-3-2-with-centos-and-selinux/
Edit your zabbix systemd startup because it’s currently broken and the PID file is pointing at /run instead of /var/run: vi /usr/lib/systemd/system/zabbix-agent.service
```bash
yum install policycoreutils-python
systemctl start zabbix-agent.service
grep "denied.*zabbix_agent" /var/log/audit/audit.log | audit2allow -M zabbix_agent
semodule -i zabbix_agent.pp
systemctl start zabbix-agent.service

getsebool -a # list all options


semanage port -a -t syslogd_port_t -p tcp 10514 # rsyslog

semanage export #  print local deviation
```


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


```sh
restorecon -FRvv ~/.ssh
chcon -Rv -t ssh_home_t ~/.ssh
chcon -Rv -t httpd_sys_content_t /var/www/
chcon -Rv -t httpd_sys_content_t /data/www/html/manual_uploads
chcon     -t httpd_tmp_t /mnt/resource/nginx
chcon     -t net_conf_t /etc/sysconfig/network-scripts/ifcfg-*

chcon -Rv -t ssh_home_t /var/www/.ssh
chcon  -v -t user_home_dir_t /var/www # system_u:object_r:unlabeled_t:s0 beforehande


$ ls -ldZ .ssh/ .ssh/authorized_keys
drwx------. zabbix-mysql-backup zabbix-mysql-backup system_u:object_r:ssh_home_t:s0  .ssh/
-rw-------. zabbix-mysql-backup zabbix-mysql-backup system_u:object_r:ssh_home_t:s0  .ssh/authorized_keys


# https://mgrepl.fedorapeople.org/man_selinux/Fedora18/zabbix.html
chcon -t zabbix_agent_exec_t     $(which zabbix_agent2) # couldn't listen to 10050 anymore
#chcon -t unconfined_exec_t $(which zabbix_agent2) # does not work for restoring
restorecon $(which zabbix_agent2 ) # cancel changes
ps -eZ | grep unconfined_service_t
```



system_u: User identity, indicating the SELinux user associated with the process or file. In this case, it's a system user.
object_r: Role identity, indicating the SELinux role associated with the process or file. This specifies the role within the system that the user is assigned when accessing the resource.
ssh_home_t: Type identity, indicating the SELinux type context. It defines the type of object the process or file is. In this case, it might refer to a file or directory related to SSH home directories.
s0: Sensitivity level, indicating the SELinux sensitivity label. In SELinux, sensitivity labels define the level of sensitivity or confidentiality associated with the resource. s0 typically represents the default sensitivity level.


semodule --build  --disable_dontaudit # show hidden denies nolog no log

# temporary disable
setenforce 0 # disable
setenforce 1 # reenable

## loadable policy
```sh
echo 'avc:  denied  { name_bind } for  pid=736591 comm="nginx" src=514 scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:http_port_t:s0 tclass=udp_socket permissive=0' | audit2allow  -r -m coucou

module coucou 1.0;

require {
	type http_port_t;
	type httpd_t;
	class udp_socket name_bind;
}

#============= httpd_t ==============
allow httpd_t http_port_t:udp_socket name_bind;
```
