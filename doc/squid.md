http://stafwag.github.io/blog/blog/2015/06/23/using-squid-to-cache-freebsd-packages/
tail -f /var/log/squid/access.log


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

