http://stafwag.github.io/blog/blog/2015/06/23/using-squid-to-cache-freebsd-packages/
tail -f /var/log/squid/access.log
tail -f /var/log/squid/access.log | perl -p -e 's/^([0-9]*)/"[".localtime($1)."]"/e'


https://serverfault.com/questions/610232/how-to-setup-client-for-squid-transparent-proxy
http_port 3129
http_port 3128 intercept


#
## symptoms
WARNING! Your cache is running out of filedescriptors
in /var/log/squid/cache.log

## measurement
```sh
squidclient mgr:info | grep 'file descri';
ls -l /proc/$(pgrep -u squid squid)/fd | wc -l;
```

## fix
in /etc/squid/squid.conf
```ini
max_filedescriptors 16384
```
and possibly, if /usr/lib/systemd/system/squid.service has a smaller than desired value
```sh
systemctl edit squid
```
```ini
[Service]
LimitNOFILE=65536
```



squid -k parse # validate test config
squid -k parse && systemctl restart squid
/sbin/squid -v | grep -i version
Squid Cache: Version 6.13 # trixie debian13
Squid Cache: Version 5.7  # bookworm debian12

#keepalive

systemctl stop squid
ls -l /run/faillock/squidsync
