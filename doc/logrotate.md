
```sh
/var/log/zabbix/zabbix_servicenow.py.log {
    weekly
    rotate 12
    compress
    delaycompress
    missingok
    notifempty
    create 0644 zabbix zabbix
}

/etc/logrotate.d/hehe
/home/hehe/.tmp/log/*.log {
	shred
	weekly
	maxsize 200M
	rotate 5
	compress
	delaycompress
	missingok
	notifempty
	nocreate
	su hehe hehe
}
```

# create
**create mode owner group**
**create      owner group**
Immediately after rotation (before the postrotate script is run) the log file is created (with the same name as the log file just rotated).

# su
**su user group**
Rotate  log  files  set under this user and group instead of using most likely root

# test
/usr/sbin/logrotate -ds /var/lib/logrotate/logrotate.status /etc/logrotate.conf
/usr/sbin/logrotate -ds /dev/null /etc/logrotate.d/syslog
