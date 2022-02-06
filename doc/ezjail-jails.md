# clone
@begin=sh@
ls -la /usr/local/etc/ezjail/jfw2015
# ensure that the target jail config file is not a symlink. Otherwise restore fails
sudo ezjail-admin archive jfw2015 # creates a .tar.gz on /usr/jails/ezjail_archives
ls -la /usr/jails/ezjail_archives 
sudo ezjail-admin config -n jfw2016 jfw2015 # rename jfw2015 to jfw2016
sudo ezjail-admin restore jfw2015 # recreates jfw2015 from latest snapshot whose pattern matches machine name
# or sudo ezjail-admin restore jfw2015-201609011645.26.tar.gz  # restore from explicit snapshot
cd /usr/local/etc/ezjail
jail_nextip.py # saves this IP subpart in your brain, it'll look like 1.1.125
vi jfw2016
#edit line "export jail_jfw2017_i6="lo1|127.1.1.125,em0|10.1.1.125"
jail_register_ly1_host.py 10.1.1.125 jfw2016 
@end=sh@

# dir
/usr/local/etc/ezjail
/usr/jails/jfwstaging/home/mr_user

jail_stop.sh jzabbix && sudo ezjail-admin config -r norun jzabbix # disables enables

```sh
ezjail-admin update -s 10.3-RELEASE-p10 -U # 10.3 is SOURCE release, not target
ls -1d /usr/jails/* | grep -vE 'basejail' | while read i; do sudo cp /root/pkg-1.17.5_1.txz $i/root/; done
pkg-static add -f /root/pkg-1.17.5_1.txz
pkg-static upgrade
echo "jsmb4 jsslh jexternalssh jexternalhttps jcerts j404 jldap" | xargs -n1 echo | while read i; do yes | sudo ezjail-admin console -e "pkg-static add -f /root/pkg-1.17.5_1.txz" $i; done
yes | sudo ezjail-admin console -e "pkg-static add -f /root/pkg-1.17.5_1.txz" jsquid
sudo ezjail-admin console -e "pkg-static upgrade" jexternalssh
```
