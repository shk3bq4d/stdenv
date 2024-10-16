
https://github.com/ansible-collections/community.zabbix
https://www.zabbix.com/documentation/6.4/en/manual/concepts/server/ha#upgrading-ha-cluster
https://www.zabbix.com/documentation/3.2/manual/api/
https://www.zabbix.com/documentation/2.4/manual/api/reference/maintenance/get
https://www.zabbix.com/documentation/2.4/manual/api/reference_commentary
https://www.zabbix.com/documentation/2.4/manual/appliance
https://www.zabbix.com/documentation/3.0/manual/appliance
https://www.zabbix.com/release_notes # changelog rn

https://github.com/ansible/ansible-modules-extras/blob/482b1a640e95274b1a6f41ec21efc333ac4076b5/monitoring/zabbix_maintenance.py
https://github.com/zabbix/zabbix-docker/
https://github.com/zabbix/zabbix-docker/tree/6.2/Dockerfiles/proxy-sqlite3/alpine

system.hostname
system.hostname[fqdn] 7.0.0 https://support.zabbix.com/browse/ZBXNEXT-7132
system.uname
agent.hostname

Appendix 1. Reference commentary

Notation

Data types

The Zabbix API supports the following data types:

Type    Description
bool    A boolean value, accepts either true or false.
flag    The value is considered to be true if it is passed and not equal to null and false otherwise.
integer A whole number.
float   A floating point number.
string  A text string.
text    A longer text string.
timestamp   A Unix timestamp.
array   An ordered sequence of values, that is, a plain array.
object  An associative array.
query   A value which defines, what data should be returned.

Can be defined as an array of property names to return only specific properties, or as one of the predefined values:
extend - returns all object properties;
count - returns the number of retrieved records, supported only by certain subselects.
Property labels

Some of the objects properties are marked with short labels to describe their behavior. The following labels are used:

readonly - the value of the property is set automatically and cannot be defined or changed by the client;
constant - the value of the property can be set when creating an object, but cannot be changed after.
Common "get" method parameters

The following parameters are supported by all get methods:

Parameter   Type    Description
countOutput flag    Return the number of records in the result instead of the actual data.
editable    boolean If set to true return only objects that the user has write permissions to.

Default: false.
excludeSearch   flag    Return results that do not match the criteria given in the search parameter.
filter  object  Return only those results that exactly match the given filter.

Accepts an array, where the keys are property names, and the values are either a single value or an array of values to match against.

Doesn't work for text fields.
limit   integer Limit the number of records returned.
output  query   Object properties to be returned.

Default: extend.
preservekeys    flag    Use IDs as keys in the resulting array.
search  object  Return results that match the given wildcard search.

Accepts an array, where the keys are property names, and the values are strings to search for. If no additional options are given, this will perform a LIKE “%…%” search.

Works only for string and text fields.
searchByAny boolean If set to true return results that match any of the criteria given in the filter or search parameter instead of all of them.

Default: false.
searchWildcardsEnabled  boolean If set to true enables the use of "\*" as a wildcard character in the search parameter.

Default: false.
sortfield   string/array    Sort the result by the given properties. Refer to a specific API get method description for a list of properties that can be used for sorting. Macros are not expanded before sorting.
sortorder   string/array    Order of sorting. If an array is passed, each value will be matched to the corresponding property given in the sortfield parameter.

Possible values are:
ASC - ascending;
DESC - descending.
startSearch flag    The search parameter will compare the beginning of fields, that is, perform a LIKE “…%” search instead.

echo "select * from zabbix.timeperiods;" | ssh vbox_zabbix24 mysql --table --user root --password=zabbix
echo "select * from zabbix.timeperiods;" | ssh vbox_zabbix30 mysql --table --user root --password=bSLCf3B4kw

sudo nano /etc/php5/apache2/php.ini

date.timezone = America/Kentucky/Louisville||
(use this url to find your correct timezone format: http://us3.php.net/manual/en/timezones.php )


Opened questions:
- timezone problem.

- should we extend Maintenance Active till (and Active since) if time period is outside of it?
  - Or should we reject the creation?

- maintenance and services matching: The script rejects the creation if more than one maintenance matching the pattern is found. Would it help to ignore expired maintenances? (Note: this answer may be incompatible with the question regarding the auto-extending of the maintenance activity duration)

- do we care about overlapping maintenance time periods?

- any interest in canceling?


sudo apt install libssl-dev libyaml-dev libffi-dev; pip install --user ansible
yum install gcc python-devel openssl-devel libyaml-devel libffi-devel libxml2-devel libxslt-devel libpng-devel libjpeg-devel


# appliance https://www.zabbix.com/documentation/3.0/manual/appliance
System: appliance:zabbix
Use “sudo su” command with “appliance” user name password to get root access rights
Database: root:<random> zabbix:<random>
Zabbix frontend: Admin:zabbix

# shell python script trigger hook
/usr/lib/zabbix/alertscripts/
1.) Create a new media type [Admininstration > Media Types > Create Media Type]
Name: ServiceNow API
Type: Script
Script name: zabbix-create-service-now-incident.py
2.) Modify the Media for the Admin user [Administration > Users]
Type: ServiceNow API
Send to: string               <--- this string is not used
When active: 1-7,00:00-24:00
Use if severity: (all)
Status: Enabled
3.) Configure Action [Configuration > Actions > Create Action > Action] Event source: Triggers
Name: Create ServiceNow ticket
Default Subject: {TRIGGER.STATUS}
Default Message:
Trigger: {TRIGGER.NAME}
Trigger description: {TRIGGER.DESCRIPTION}
Trigger severity: {TRIGGER.SEVERITY}
Trigger nseverity: {TRIGGER.NSEVERITY}
Trigger status: {TRIGGER.STATUS}
Trigger URL: {TRIGGER.URL}
Host: {HOST.HOST}
Host description: {HOST.DESCRIPTION}
Event age: {EVENT.AGE}
Current Zabbix time: {DATE} {TIME}
Item values:
1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}
2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}
3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}
Zabbix event ID: {EVENT.ID}
Zabbix web UI: https://zabbix.domain.com/zabbix
For a full list of trigger macros see https://www.zabbix.com/documentation/2.4/manual/appendix/macros/supported_by_location
At the Conditions tab, to only forward PROBLEM events:
(A) Maintenance status not in "maintenance"
(B) Trigger value = "PROBLEM"
Finally, add an operation:
Send to Users: Admin
Send only to: ServiceNow API


{ALERT.SENDTO}
{ALERT.SUBJECT}


# https://www.zabbix.com/documentation/2.2/manual/appendix/items/activepassive
# https://www.zabbix.org/wiki/Docs/protocols/zabbix_agent/2.2
# test passive agent https://www.zabbix.com/documentation/3.2/manual/appendix/items/activepassive
```bash
nc -v 10.63.121.118 10050
agent.version
#or oneliner but probably doesn't wait enough
(echo "agent.version"; sleep 10)   | nc -v 10.63.121.118 10050 | strings
(echo "system.hostname"; sleep 10) | nc -v 10.63.121.118 10050 | strings
(echo 'vfs.file.regexp[/proc/sys/fs/file-nr, "^([0-9]+)",,1,1,\1]'; sleep 10)   | nc -v TARGET_HOSTNAME 10050
export DATA="agent.version"; { printf -v LENGTH '%016x' "${#DATA}"; PACK=""; for i in {14..0..-2}; do PACK="$PACK\\x${LENGTH:$i:2}"; done; printf "ZBXD\1$PACK%s" $DATA; sleep 10; } | nc -v 10.63.121.118 10050 | strings

#test active agent
H=$(hostname -f);D="{\"request\":\"active checks\",\"host\":\"$H\"}";L=$(echo ${#D} | awk '{hex=sprintf("%08X",$1); for (i=7;i>=1;i=i-2) printf "%s%s",substr(hex,i,2),(i>1?"":"\n");}'); echo -ne "ZBXD\x01$L$D\n"
ZBXD
# test active against
Z=zabbixmaster; H=$(hostname -f);D="{\"request\":\"active checks\",\"host\":\"$H\"}";L=$(echo ${#D} | awk '{hex=sprintf("%08X",$1); for (i=7;i>=1;i=i-2) printf "%s%s",substr(hex,i,2),(i>1?"":"\n");}'); echo -ne "ZBXD\x01$L$D\n" | nc -v $Z 10051
Z=zabbixmaster; H=$(hostname -f);D="{\"request\":\"active checks\",\"host\":\"$H\"}";L=$(echo $(( 0 + ${#D})) | awk '{hex=sprintf("%08X",$1); for (i=7;i>=1;i=i-2) printf "%s%s",substr(hex,i,2),(i>1?"\\x":"\n");}'); (echo  -ne "ZBXD\x01\x$L\x00\x00\x00\x00$D"; sleep 10 ) | nc -v $Z 10051


wget http://www.zabbix.com/downloads/3.2.0/zabbix_agents_3.2.0.win.zip && 7za x zabbix_agents_3.2.0.win.zip
p="/cygdrive/c/Program Files/zabbix-agent/"; "$p/bin/win64/zabbix_agentd.exe" --install --config "$(cygpath -wa "$p/conf/zabbix_agentd.win.conf")"
net start "Zabbix Agent"
```

IDEAS
fuzzytime # check drifting machines https://www.zabbix.com/documentation/3.2/manual/appendix/triggers/functions

https://www.zabbix.org/wiki/Start_with_SNMP_traps_in_Zabbix

# custom check
```bash
$ cat /etc/zabbix/zabbix_agentd.d/reboot-needed.conf
UserParameter=kernel.reboot,test $(ls -t1 /boot/vmlinuz-?\.* | head -1) == /boot/vmlinuz-$(uname -r) && echo "NO" || echo "YES"
```


http://cavaliercoder.com/blog/testing-zabbix-actions.html # push item data so as to fire trigger and test subsequent action
- create item of type zabbix trapper
- create corresponding trigger
- push item value:

```bash
zabbix_sender -z localhost -s fakehost_testprefix -k mykey0 -o 0 # use host of zabbix_proxy instead of localhost if relevant
/usr/bin/zabbix_sender -vv -z PROXY -s TARGET_HOST -k MY.ITEM.KEY -o 0
```

# trigger
https://www.zabbix.com/documentation/3.2/manual/appendix/triggers/functions
https://www.zabbix.com/documentation/3.2/manual/config/triggers/expression
```bash
{fakehost_testprefix:mykey0.last(0)} > 0
{10.7.254.1:fgVpnTunEntStatus[VPN-SU-0002-01].last(0)}=1
count(#4, 200, ne)  >= 2
{Template OS security:security.meltdown.regexp(^OK$)}=1
{SFTP-Backup server deadman switch:zsets.mss.watchdog[{#ZFSDATASET},{$SFTP_WATCHDOG_NB_DAYS_EXISTING},{$SFTP_WATCHDOG_NB_DAYS_NONE}].last()}=-2 and {SFTP-Backup server deadman switch:zsets.mss.watchdog[{#ZFSDATASET},{$SFTP_WATCHDOG_NB_DAYS_EXISTING},{$SFTP_WATCHDOG_NB_DAYS_NONE}].delta()}=0
```

# calculated trigger
https://www.zabbix.com/documentation/3.2/manual/config/items/itemtypes/calculated
```bash
last("vpn02.group.local:fgVpnTunEntInOctets[C010DB]")
diff("vpn02.group.local:fgVpnTunEntInOctets[C010DB]")
```

# webscenario
The steps are periodically executed by Zabbix server in a pre-defined order. If a host is monitored by proxy, the steps are executed by the proxy.
https://www.zabbix.com/documentation/3.2/manual/web_monitoring/example
```bash
login POST https://58.81.25.12/login/
input type="hidden" name="csrfmiddlewaretoken" value="blabla"
csrfmiddlewaretoken:WXCy8ZlwsjC3brPSt6kiPU9a7bssAEzQy9J63TDScF1NSOuj7jsVC6g4dyVqvCNJ
username:abcd
password:efgh
next:/
Content-Type:application/x-www-form-urlencoded
Referer: https://58.81.25.12/
Cookie:csrftoken=z6Jj3uib8I0BFx0oN0xmImeyhNnao1MDbiQRYoAxS4plmUFPrdFZvylsnaQ8jZ0w


{user}=ucm-us
{password}=2%3F%2CVpdtb%2Fbo%40Hkd
import urllib; urllib.quote('myp/\ssword', safe='') # escape uricomponent encode

{token}=regex:name=["']?csrfmiddlewaretoken["']?\s+value=["']?([^"']+)
{_csrf_token}=regex:name="_csrf_token" value="([^"]*){43}"

vi /etc/zabbix/zabbix_server.conf
DebugLevel=4 # 0 - basic information about starting and stopping of Zabbix processes
DebugLevel=1 - critical information;
DebugLevel=2 - error information;
DebugLevel=3 - warnings;
DebugLevel=4 - for debugging (produces lots of information);
DebugLevel=5 - extended debugging (produces even more information).
service zabbix-server restart
tail -f /var/log/zabbix/zabbix_server.log | grep -C0 -E 'process_httptest|web scenario'
```



# https://github.com/madchap/graylog-collector-zabbix elegant external process multi-item polling via discovery_rule of type 10 and item_prototype of type 15

# database schema https://www.zabbix.org/mw/images/0/0c/Zabbix_db_schema-2.4.3-MySQL.svg

~/.local/lib/python2.7/site-packages/zabbix_api.py

# test Users
mss_emea_ro_user
mss_emea_rw_user
mss_us_ro_user
mss_us_rw_user

firefox  ~/Documents/zabbix-schema/index.html #schema
java -jar schemaSpy_5.0.0.jar -t pgsql -host localhost:5432 -db zabbix -s public -o /tmp/bip -u zabbix -p myPasswordFSD0.fs8 -dp postgresql-42.1.4.jar

psql -U zabbix -h localhost
myPasswordFSD0.fs8
```sql
select * from rights left join groups on rights.id = groups.groupid;
select usrgrp.name as usrgrp_name, groups.name as hg_name, permission from rights left join groups on rights.id = groups.groupid left join usrgrp on rights.groupid = usrgrp.usrgrpid order by usrgrp.name, groups.name;
```


https://atlassian.hq.k.grp/confluence/pages/viewpage.action?pageId=112557332 # MSS Zabbix template git CI/CD workflow rules merge request

# jmx auto discovery
discovery rule:
type: JMX Agent
key: jmx.discovery

# expressions
{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].diff()}<>0
{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].prev()}<>{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].last()}
{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].delta(55)}=0

```js
javascript:var bA = document._getElementsByXPath("//input[@type='checkbox']"); for (var k = bA.length - 1; k >= 0; --k) {bA[k].checked = true;} // template import select all box
```


yum install zabbix-get

$ /usr/bin/zabbix_get -sMASTER -k 'net.dns.record[,www.google.com,A]'
www.google.com       A        172.217.19.164

$ /usr/bin/zabbix_get -sMASTER -k 'net.dns.record[,www.google.com,SOA]'
ZBX_NOTSUPPORTED: Cannot perform DNS query.


/usr/bin/zabbix_get -s myhostname -k 'system.hostname'
/usr/bin/zabbix_get -s myhostname -k 'agent.version'
/usr/bin/zabbix_get -s myhostname -k 'agent.hostname'


# admin super admin
https://www.zabbix.com/documentation/3.2/manual/config/users_and_usergroups/usergroup
https://www.zabbix.com/documentation/3.2/manual/config/users_and_usergroups/permissions


# Agent trace request/response
```sh
sudo sed -i -r -e 's/^DebugLevel=/DebugLevel=4/' /etc/zabbix/zabbix_agentd.conf && sudo systemctl restart zabbix-agent
sudo tail -f /var/log/zabbix/zabbix_agentd.log | grep -vE '__zbx_zbx_setproctitle|(In|End of) (update_cpustats)'
```

# docker
docker pull zabbix/zabbix-appliance:ubuntu-4.0.17
https://hub.docker.com/r/zabbix/zabbix-appliance
https://hub.docker.com/r/zabbix/zabbix-server-mysql
https://hub.docker.com/r/zabbix/zabbix-proxy-sqlite3
https://hub.docker.com/r/zabbix/zabbix-web-nginx-mysql

docker run --name some-zabbix-appliance -p 80:80 -p 10051:10051 -d zabbix/zabbix-appliance:tag
docker run --name zabbix -p 80:80 -p 10051:10051 -d zabbix/zabbix-appliance:ubuntu-4.0.17

https://www.zabbix.com/documentation/4.0/manual/config/items/item/custom_intervals

# opsgenie action
/etc/opsgenie/zabbix2opsgenie -triggerName='{EVENT.NAME}' -triggerId='{TRIGGER.ID}' -triggerStatus='{TRIGGER.STATUS}' -triggerSeverity='{TRIGGER.SEVERITY}' -triggerDescription='{TRIGGER.DESCRIPTION}' -triggerUrl='{TRIGGER.URL}' -triggerValue='{TRIGGER.VALUE}' -triggerHostGroupName='{TRIGGER.HOSTGROUP.NAME}' -hostName='{HOST.NAME}' -ipAddress='{IPADDRESS}' -eventId='{EVENT.ID}' -date='{DATE}' -time='{TIME}' -itemKey='{ITEM.KEY}' -itemValue='{ITEM.VALUE}' -recoveryEventStatus='{EVENT.RECOVERY.STATUS}' -teams=sfitdn

https://ma.ttias.be/finding-biggest-data-storage-consumers-zabbix/
For the history_uint table (holds all integer values):
```sql
set sql_big_selects=1;
SELECT COUNT(history.itemid), history.itemid, i.name, i.key_, h.host
FROM history_uint AS history
LEFT JOIN items AS i ON i.itemid = history.itemid
LEFT JOIN hosts AS h ON i.hostid = h.hostid
GROUP BY history.itemid
ORDER BY COUNT(history.itemid) DESC
LIMIT 100;
```
For the history table (holds all float & double values):

```sql
set sql_big_selects=1;
SELECT COUNT(history.itemid), history.itemid, i.name, i.key_, h.host
FROM history AS history
LEFT JOIN items AS i ON i.itemid = history.itemid
LEFT JOIN hosts AS h ON i.hostid = h.hostid
GROUP BY history.itemid
ORDER BY COUNT(history.itemid) DESC
LIMIT 100;
```

For the history_text table (holds all text values):

```sql
set sql_big_selects=1;
SELECT COUNT(history.itemid), history.itemid, i.name, i.key_, h.host
FROM history_text AS history
LEFT JOIN items AS i ON i.itemid = history.itemid
LEFT JOIN hosts AS h ON i.hostid = h.hostid
GROUP BY history.itemid
ORDER BY COUNT(history.itemid) DESC
LIMIT 100;

-- https://dev.mysql.com/doc/refman/8.0/en/storage-requirements.html
set sql_big_selects=1;
select _count, _type, i.name, i.key_, h.host,
concat('https://zabbix.group.local/items.php?form=update&hostid=', h.hostid, '&itemid=', i.itemid) as url
from (
SELECT COUNT(1) as _count, 'uint'   as _type,  8 * count(1) as _sort, itemid FROM history_uint GROUP BY itemid UNION
SELECT COUNT(1) as _count, 'double' as _type,  8 * count(1) as _sort, itemid FROM history      GROUP BY itemid UNION
SELECT COUNT(1) as _count, 'text'   as _type, 48 * count(1) as _sort, itemid FROM history_text GROUP BY itemid
) history
LEFT JOIN items AS i ON i.itemid = history.itemid
LEFT JOIN hosts AS h ON i.hostid = h.hostid
ORDER BY _sort DESC
LIMIT 200;
```

# SQL
```sql
select name from hstgrp limit 10; -- host groups hostgroups hostsgroups
```

# zabbix grafana plugin
https://alexanderzobnin.github.io/grafana-zabbix/guides/templating/
```bash
{*} returns list of all available Host Groups
{*}{*} all hosts in Zabbix
{Network}{*} returns all hosts in group Network
{Linux servers}{*}{*} returns all applications from hosts in Linux servers group
{Linux servers}{backend01}{CPU}{*} returns all items from backend01 belonging to CPU application.
{host group}{host}{application}{item name}

/^(?!.*network).*$/i # negate network hostgroup


item units: unixtime (useful for unix timestamps vfs.file.time)
item units: B (byte), Bps (bytes per second)
item units: uptime


last()   is the N   value and same as last(#1)
last(#1) is the N   value and same as last()
last(#2) is the N-1 value
last(#3) is the N-2 value


{$DUMMY_SLOW_TIMEOUT_SECONDS} # macro
```

web.page.regexp["https://127.0.0.1:9192/http-status-code",,,"^[^ ]+ (\d+)",,\1]

# preprocessing javascript web.page.get
```js
function(value) {
// from a web.page.get item, extracts the http body by removing everything before the first \r\n\r\n
var k;
var magic = "\r\n\r\n"; //empty line
var magic2 = "\n\n"; // HTTP says cr lf, but well if anybody messages

k = value.indexOf(magic);
if (k >= 0)
{   value = value.substring(k + magic.length);
}
else if ((k = value.indexOf(magic2)) >= 0)
{    value = value.substring(k + magic2.length);
}
return value;
}
```

https://git.zabbix.com/projects/ZBX/repos/zabbix/raw/ChangeLog?at=refs%2Fheads%2Frelease%2F5.0 # changelog
https://git.zabbix.com/scm/zbx/zabbix.git
https://github.com/zabbix/zabbix
git remote add github https://github.com/zabbix/zabbix

```sh
zabbix_get  -s 10.201.16.112 -k "wmi.get[root\\cimv2,select * from win32_registryaction]" # wmic
zabbix_get  -s 10.201.16.112 -k "wmi.get[root\\cimv2,select status from win32_diskdrive where Name like '%PHYSICALDRIVE0%']" # wmic
zabbix_get  -s 10.1.1.1 -k "wmi.get[root\\cimv2,select * from Win32_LoggedOnUser]"
zabbix_get  -s 10.1.1.1 -k "wmi.getall[root\cimv2,select * from win32_networkadapterconfiguration]"
zabbix_get  -s 10.1.1.1 -k 'wmi.getall[root\cimv2,select * from win32_networkadapterconfiguration where ipenabled=true]'
zabbix-get-proxy.sh BIPBIP 'wmi.getall[root\cimv2,select * from win32_networkadapterconfiguration where ipenabled=true]' | jq '.[].IPAddress'
zabbix-get-proxy.sh BIPBIP 'wmi.getall[root\cimv2,select * from win32_networkadapterconfiguration where ipenabled=true]' | jq '.[].DNSServerSearchOrder'
zabbix-get-proxy.sh BIPBIP 'wmi.getall[root\cimv2,select * from win32_networkadapterconfiguration where ipenabled=true]' | jq '.[].MACAddress'
wmic path win32_networkadapter get netenabled,name,macaddress,speed,physicaladapter,adaptertype
wmic nicconfig where ipenabled=true get defaultipgateway,description,dhcpleaseobtained,dhcpserver,dnsdomainsuffixsearchorder,dnshostname,dnsserversearchorder,ipaddress,ipenabled,ipsubnet,macaddress
wmic path win32_networkadapterconfiguration where ipenabled=true get defaultipgateway,description,dhcpleaseobtained,dhcpserver,dnsdomainsuffixsearchorder,dnshostname,dnsserversearchorder,ipaddress,ipenabled,ipsubnet,macaddress
```

# discovery
uc ls --database /var/cache/duc/data /data -b --full-path -R -l 1  | grep -vE 'burp_wrong|occ-fix' | awk 'BEGIN { print "{#SIZE},{#PATH}"}{ print $1 "," $2 }' |tee  /opt/sf-scripts/zabbix-shared/duc | head

# actions
```bash
/etc/opsgenie/zabbix2opsgenie -triggerName='{EVENT.NAME}' -triggerId='{TRIGGER.ID}' -triggerStatus='{TRIGGER.STATUS}' -triggerSeverity='{TRIGGER.SEVERITY}' -triggerDescription='{TRIGGER.DESCRIPTION}' -triggerUrl='{TRIGGER.URL}' -triggerValue='{TRIGGER.VALUE}' -triggerHostGroupName='{TRIGGER.HOSTGROUP.NAME}' -hostName='{HOST.NAME}' -ipAddress='{IPADDRESS}' -eventId='{EVENT.ID}' -date='{DATE}' -time='{TIME}' -itemKey='{ITEM.KEY}' -itemValue='{ITEM.VALUE}' -recoveryEventStatus='{EVENT.RECOVERY.STATUS}' -teams=ALL
/usr/lib/zabbix/externalscripts/log.sh '{DATE}' '{TIME}' '{TRIGGER.SEVERITY}' '{TRIGGER.STATUS}' '{EVENT.NAME}'

zabbix_sender -z localhost -s fakehost_testprefix -k "service.discovery" -o \
'[
{ "{#SERVICE.NAME}":        "s1",
  "{#SERVICE.DISPLAYNAME}": "s one",
  "{#SERVICE.STARTUPNAME}": "automatic"
}
,{"{#SERVICE.NAME}":        "s2",
  "{#SERVICE.DISPLAYNAME}": "s two",
  "{#SERVICE.STARTUPNAME}": "manual"
}
]'
```


#
```bash
net.tcp.port[<ip>,port] # either simple check or zabbix agent checks if TCP connection is possible
net.tcp.service[service,<ip>,<port>] # either simple check or zabbix agent checks if one one ssh, ldap, smtp, ftp, http, pop, nntp, imap, tcp, https, telnet service is possible, see how this works: https://www.zabbix.com/documentation/current/manual/appendix/items/service_check_details
```
https://www.zabbix.com/documentation/current/manual/config/items/itemtypes/simple_checks

```sql
select * from last_value where host like '%lan' and name like '%uptime%';

select * from (select lower(substr(regexp_substr(name, '\\([^\\)]+'), 2)) as account, last_valuehg.* from last_valuehg where hg like 'windows' and name like 'State of service%') a where not account like '%localsystem%' and not account like '%nt authority%' and account <> '' limit 10;

select * from (select lower(substr(regexp_substr(name, '\\([^\\)]+'), 2)) as account, last_valuehg.* from last_valuehg where hg like 'windows' and name like 'State of service%') a where account like '%stoneh%' limit 50;
```

# macros
## context contextual macros
[https://www.zabbix.com/documentation/current/manual/config/macros/user_macros_context]
```bash
{$LOW_SPACE_LIMIT}  User macro without context.
{$LOW_SPACE_LIMIT:/tmp} User macro with context (static string).
{$LOW_SPACE_LIMIT:regex:"^/tmp$"}   User macro with context (regular expression). Same as {$LOW_SPACE_LIMIT:/tmp}.
{$LOW_SPACE_LIMIT:regex:"^/var/log/.*$"}    User macro with context (regular expression). Matches all strings prefixed with /var/log/.
```

## macros functions
```bash
{{TIME}.fmttime(format,time_shift)}      # macro functions
{{ITEM.VALUE}.regsub(pattern, output)}   # macro functions
{{#LLDMACRO}.regsub(pattern, output)}    # macro fuctions
```


zabbix-get-local.sh 'proc.num[filebeat,root,,/etc/filebeat/filebeat.yml]'
```


triggers evaluation period ime https://www.zabbix.com/documentation/current/manual/config/triggers

typeperf -qx   # performance counter perf counter perf_counter windows
typeperf -qxa  # performance counter perf counter perf_counter windows

https://cdn.zabbix.com/zabbix/binaries/stable/5.4/5.4.10/zabbix_agent2-5.4.10-windows-amd64-openssl.msi
Invoke-WebRequest -Uri "https://cdn.zabbix.com/zabbix/binaries/stable/6.2/6.2.8/zabbix_agent2-6.2.8-windows-amd64-openssl.msi" -OutFile "C:\Utils\Zabbix\zabbix_agent2-6.2.8-windows-amd64-openssl.msi"


tc qdisc add    dev eth0 root netem loss 25% # start simulate ping loss
tc qdisc change dev eth0 root netem loss 0%  # stop  simulate ping loss


# templates
```yaml
- {{ z.uuid('/var/run/reboot-required') }}
  {{ z.tagstpl(['mytag', 'myvalue'], 'mytag2') }}
  {{ z.dependent(main_key, "180d") }} # dependent items
  key: vfs.file.exists[/var/run/reboot-required]
  key: vfs.file.contents[/var/lib/update-notifier/updates-available]
  value_type: FLOAT
  value_type: CHAR
  value_type: TEXT
  value_type: LOG
# value_type: INT <-- there is no INT, it's implicit if missing
  priority: DISASTER
  priority: HIGH
  priority: WARNING
  priority: INFO
  priority: AVERAGE
  type: CALCULATED
  type: SNMP_AGENT
  type: IPMI
  type: HTTP_AGENT
  type: SIMPLE
  trends: '0'
# priority: NOT_CLASSIFIED <-- there is no NOT_CLASSIFIED it's implicit if missig
  preprocessing:
  - {{ z.pp_hb('1d') }}
  - {{ z.pp_regex('(?m)^POWER_SUPPLY_TECHNOLOGY=(.*)',   '\\\\1') }}

- {{ z.uuid('technology') }}
  {{ z.dependent(main_key, "180d") }}
  key: battery.technology
  name: Battery Technology
  value_type: CHAR
  preprocessing:
  - {{ z.pp_regex('(?m)^POWER_SUPPLY_TECHNOLOGY=(.*)',   '\\\\1') }}
```

https://support.zabbix.com/browse/ZBX-16162 # Draw Graph line complete when Discarding values with Heartbeat, bug
https://support.zabbix.com/browse/ZBX-24926 # opsgenie Sending failed: Error: cannot set cURL option CURLOPT_INTERFACE: A libcurl function was given a bad argument.

# proxy
docker exec -it zabbix-proxy zabbix_proxy -R log_level_increase


```sql
set global log_bin_trust_function_creators=1; -- "You do not have the SUPER privilege and binary logging is enabled", zabbix 5.4 -> 6.0 upgrade (or 6.0 to 6.2 I don't recall)
```

# high availibility cluster HA master slave repliac
* https://www.zabbix.com/documentation/current/en/manual/concepts/server/ha
```sh
zabbix_server -R ha_status
docker exec -it zabbix-server zabbix_server -R ha_status
```

# saml
https://www.zabbix.com/forum/zabbix-help/402079-microsoft-adfs-saml-idp-and-zabbix-5-0-guideline
Hi,
I haven't found any post so far where some one explains how to get AzureAD-SSO working with Zabbix. After a lot of sweat and tears I managed to get it working, so I'll post it here - as it is the first result on google when you search Azure AD SSO Zabbix:
1. Make your Zabbix-Frontend work with SSL, if you haven't done so
2. Create a new Enterprise-App in Azure. Entitiy-ID https://zabbix.yourcompany.org - Reply-URL: https://zabbix.yourcompany.org/index_sso.php
3. Download the Federation-Metadata XML from Azure, open it in a text-editor and search for the x509 certificate (appears 3 times in the XML - do NOT download and use the certificate the Azure offers you for direct download)
4. Create a file (/usr/share/zabbix/)conf/certs/idp.crt and insert the certificate as one single string without any "begin certificate" or line breaks or any other stuff
5. (May be optional - but I did it): create a personal certificate and private key and put it in the same directory as sp.crt and sp.key (I linked the letsencrypt cert and key I also use for SSL... potentially not the best idea in hyper-secure environments)
6. (May also be optional): uncomment the SSO part in /usr/share/zabbix/conf/zabbix.conf.php
7. Login in Zabbix-FE, goto Administration, Authentication, SAML. Map the values from Azure -> Zabbix:
-- Azure AD Identifier -> IdP Entity ID (https://sts.windows.net...)
-- Azure Login URL -> SSO service URL (https://login.microsoftonline.com...)
-- Claim name from Azure -> Username attribute (that one is tricky... zabbix will search for the internal technical name. Azure will show you these when you edit your claims. Eg: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name" is the userprinicipalname (aka UPN, aka: Mailaddress in most scenarios)
-- Identifier -> SP entity ID (https://zabbix.yourcompany.org in this example)
8. Create a new user with the right field from Azure as Username (UPN/Mail)
9. Don't forget to grant your user access-rights in Azure, if you have set User assignment required (default)
10. Login with SSO and have a pint of beer


bash-5.1$ grep -i sso /etc/zabbix/web/zabbix.conf.php
$SSO['SP_KEY']         = file_exists('/etc/zabbix/web/certs/sp.key') ? '/etc/zabbix/web/certs/sp.key' : (file_exists(getenv('ZBX_SSO_SP_KEY')) ? getenv('ZBX_SSO_SP_KEY') : '');
$SSO['SP_CERT']            = file_exists('/etc/zabbix/web/certs/sp.crt') ? '/etc/zabbix/web/certs/sp.crt' : (file_exists(getenv('ZBX_SSO_SP_CERT')) ? getenv('ZBX_SSO_SP_CERT') : '');
$SSO['IDP_CERT']       = file_exists('/etc/zabbix/web/certs/idp.crt') ? '/etc/zabbix/web/certs/idp.crt' : (file_exists(getenv('ZBX_SSO_IDP_CERT')) ? getenv('ZBX_SSO_IDP_CERT') : '');
$sso_settings = str_replace("'","\"",getenv('ZBX_SSO_SETTINGS'));
$SSO['SETTINGS']       = (json_decode($sso_settings)) ? json_decode($sso_settings, true) : array();

# functions
dayofweek # Day of week in range of 1 to 7 (Mon - 1, Sun - 7). dayofweek()<6

operator: EXISTS
operator: LIKE
operator: NOT_LIKE
operator: NOT_MATCHES_REGEX
operator: NOT_REGEXP
operator: REGEXP


# perf counter system.uptime problem
## logs
2023/06/23 16:16:28.259863 failed to execute direct exporter task for key 'system.uptime' error: 'Unable to parse the counter path. Check the format and syntax of the  specified path.  '
2023/06/23 16:16:28.260412 sending passive check response: ZBX_NOTSUPPORTED: 'Unable to parse the counter path. Check the format and syntax of the  specified path.  ' to '10.102.32.15'
## symptom
the following registry key is empty
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009
## solution
lodctr /r & REM rebuilds performance counter from system backup, if such exists
sc stop "Zabbix Agent 2" & REM stop and restart zabbix agent
sc start "Zabbix Agent 2"
## alternative symptom
the following registry key is not empty, but incomplete (lacks 2\nSystem\n674\nSystem Up Time)
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009
## solution for alternative symptom
mkdir c:\temp
cd c:\temp
lodctr /s:"c:\temp\000.txt" & REM saves current performance counter to file
copy c:\temp\000.txt c:\temp\001.txt
notepad c:\temp\001.txt & REM open notepad and append at the end of the file (or any other value for which you need the counter that you have found on a properly set server)
2=System
3=The System performance object consists of counters that apply to more than one instance of a component processors on the computer.
16=File Read Bytes/sec
17=File Read Bytes/sec is the overall rate at which bytes are read to satisfy  file system read requests to all devices on the computer, including reads from the file system cache.  It is measured in number of bytes per second.  This counter displays the difference between the values observed in the last two samples, divided by the duration of the sample interval.
18=File Write Bytes/sec
19=File Write Bytes/sec is the overall rate at which bytes are written to satisfy file system write requests to all devices on the computer, including writes to the file system cache.  It is measured in number of bytes per second.  This counter displays the difference between the values observed in the last two samples, divided by the duration of the sample interval.
234=PhysicalDisk
235=The Physical Disk performance object consists of counters that monitor hard or fixed disk drive on a computer.  Disks are used to store file, program, and paging data and are read to retrieve these items, and written to record changes to them.  The values of physical disk counters are sums of the values of the logical disks (or partitions) into which they are divided.
250=Threads
251=Threads is the number of threads in the computer at the time of data collection. This is an instantaneous count, not an average over the time interval.  A thread is the basic executable entity that can execute instructions in a processor.
674=System Up Time
675=System Up Time is the elapsed time (in seconds) that the computer has been running since it was last started.  This counter displays the difference between the start time and the current time.
1402=Avg. Disk Read Queue Length
1403=Avg. Disk Read Queue Length is the average number of read requests that were queued for the selected disk during the sample interval.
1404=Avg. Disk Write Queue Length
1405=Avg. Disk Write Queue Length is the average number of write requests that were queued for the selected disk during the sample interval.
lodctr /r:"c:\temp\001.txt" & REM  restore performance counter from edited backup
sc stop "Zabbix Agent 2" & sc start "Zabbix Agent 2"
shutdown /l

### short version
mkdir c:\temp & cd c:\temp & lodctr /s:"c:\temp\000.txt" & copy c:\temp\000.txt c:\temp\001.txt & notepad c:\temp\001.txt

2=System
3=The System performance object consists of counters that apply to more than one instance of a component processors on the computer.
16=File Read Bytes/sec
17=File Read Bytes/sec is the overall rate at which bytes are read to satisfy  file system read requests to all devices on the computer, including reads from the file system cache.  It is measured in number of bytes per second.  This counter displays the difference between the values observed in the last two samples, divided by the duration of the sample interval.
18=File Write Bytes/sec
19=File Write Bytes/sec is the overall rate at which bytes are written to satisfy file system write requests to all devices on the computer, including writes to the file system cache.  It is measured in number of bytes per second.  This counter displays the difference between the values observed in the last two samples, divided by the duration of the sample interval.
234=PhysicalDisk
235=The Physical Disk performance object consists of counters that monitor hard or fixed disk drive on a computer.  Disks are used to store file, program, and paging data and are read to retrieve these items, and written to record changes to them.  The values of physical disk counters are sums of the values of the logical disks (or partitions) into which they are divided.
250=Threads
251=Threads is the number of threads in the computer at the time of data collection. This is an instantaneous count, not an average over the time interval.  A thread is the basic executable entity that can execute instructions in a processor.
674=System Up Time
675=System Up Time is the elapsed time (in seconds) that the computer has been running since it was last started.  This counter displays the difference between the start time and the current time.
1402=Avg. Disk Read Queue Length
1403=Avg. Disk Read Queue Length is the average number of read requests that were queued for the selected disk during the sample interval.
1404=Avg. Disk Write Queue Length
1405=Avg. Disk Write Queue Length is the average number of write requests that were queued for the selected disk during the sample interval.

lodctr /r:"c:\temp\001.txt" & sc stop "Zabbix Agent 2" & sc start "Zabbix Agent 2"
shutdown /l

py-zabbix==1.1.7
zabbix-api==0.5.6 # py pip used to be used by ansible collection community.zabbix < 1.9.0

# CVE
* https://www.zabbix.com/security_advisories # cve
* https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=zabbix
* https://support.zabbix.com/browse/ZBX-22588?jql=labels%20%3D%20vulnerability # CVE
* https://www.cvedetails.com/product/9588/Zabbix-Zabbix.html?vendor_id=5667
* https://www.cvedetails.com/vulnerability-list/vendor_id-5667/Zabbix.html
* https://www.opencve.io/cve?vendor=zabbix



# other
* zabbix agent2 windows syslog logtype=system https://git.zabbix.com/projects/ZBX/repos/zabbix/commits/0d03c8f6e95db370d0d64565d95ba9776ada9b96#src/go/conf/zabbix_agent2.win.conf


# hard-coded value discovery
Create a discovery of type "Script"
```js
var nl = "\n";
var headers = "{#DEST},{#PORT},{#EXPECTED},{#ITEMDELAY},{#TRIGGERMINARG},{#ITEMTEXT},{#TRIGGERTEXT}";
var value1 = "nmprx101p06.mfogroup.co,3128,1,30m,#3,squid_cluster,squid_cluster should be accessible";
var value2 = "graylog.group.local,5044,1,30m,#3,filebeat,filebeat should be accessible";
return headers + nl + value1 + nl + value2;

return "{#KEY}\nVirtualMachineId\nPhysicalHostNameFullyQualified\nVirtualMachineName";
vfs.file.regexp[/opt/sf-scripts/zabbix-shared/hyperv-kvp,^{#KEY}: (.*),,,,<output>]
```
add preprocessing steps: CSV to JSON with default ' and " parameters and "with headers row checked"



