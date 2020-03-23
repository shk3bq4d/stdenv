

one Maintenance may contain several periods and affect Hosts or Groups (of Hosts)

IT Services: example: C015 - N*
click, edit (context menu), time (tab)

https://www.zabbix.com/documentation/3.2/manual/api/
https://www.zabbix.com/documentation/2.4/manual/api/reference/maintenance/get
https://www.zabbix.com/documentation/2.4/manual/api/reference_commentary
https://www.zabbix.com/documentation/2.4/manual/appliance
https://www.zabbix.com/documentation/3.0/manual/appliance

https://github.com/ansible/ansible-modules-extras/blob/482b1a640e95274b1a6f41ec21efc333ac4076b5/monitoring/zabbix_maintenance.py


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
searchWildcardsEnabled  boolean If set to true enables the use of “*” as a wildcard character in the search parameter.

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

IDEAS
fuzzytime # check drifting machines https://www.zabbix.com/documentation/3.2/manual/appendix/triggers/functions

https://www.zabbix.org/wiki/Start_with_SNMP_traps_in_Zabbix

# custom check
$ cat /etc/zabbix/zabbix_agentd.d/reboot-needed.conf
UserParameter=kernel.reboot,test $(ls -t1 /boot/vmlinuz-?\.* | head -1) == /boot/vmlinuz-$(uname -r) && echo "NO" || echo "YES"


http://cavaliercoder.com/blog/testing-zabbix-actions.html # push item data so as to fire trigger and test subsequent action
- create item of type zabbix trapper
- create corresponding trigger
- push item value:

zabbix_sender -z localhost -s fakehost_testprefix -k mykey0 -o 0 # use host of zabbix_proxy instead of localhost if relevant
/usr/bin/zabbix_sender -vv -z PROXY -s TARGET_HOST -k MY.ITEM.KEY -o 0

# trigger
https://www.zabbix.com/documentation/3.2/manual/appendix/triggers/functions
https://www.zabbix.com/documentation/3.2/manual/config/triggers/expression
{fakehost_testprefix:mykey0.last(0)} > 0
{10.7.254.1:fgVpnTunEntStatus[VPN-SU-0002-01].last(0)}=1
count(#4, 200, ne)  >= 2
{Template OS security:security.meltdown.regexp(^OK$)}=1
{SFTP-Backup server deadman switch:zsets.mss.watchdog[{#ZFSDATASET},{$SFTP_WATCHDOG_NB_DAYS_EXISTING},{$SFTP_WATCHDOG_NB_DAYS_NONE}].last()}=-2 and {SFTP-Backup server deadman switch:zsets.mss.watchdog[{#ZFSDATASET},{$SFTP_WATCHDOG_NB_DAYS_EXISTING},{$SFTP_WATCHDOG_NB_DAYS_NONE}].delta()}=0

# calculated trigger
https://www.zabbix.com/documentation/3.2/manual/config/items/itemtypes/calculated
last("vpn02.group.local:fgVpnTunEntInOctets[C010DB]")
diff("vpn02.group.local:fgVpnTunEntInOctets[C010DB]")

# webscenario
The steps are periodically executed by Zabbix server in a pre-defined order. If a host is monitored by proxy, the steps are executed by the proxy.
https://www.zabbix.com/documentation/3.2/manual/web_monitoring/example
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
DebugLevel=4
service zabbix-server restart
tail -f /var/log/zabbix/zabbix_server.log | grep -C0 -E 'process_httptest|web scenario'



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
@begin=sql@
select * from rights left join groups on rights.id = groups.groupid;
select usrgrp.name as usrgrp_name, groups.name as hg_name, permission from rights left join groups on rights.id = groups.groupid left join usrgrp on rights.groupid = usrgrp.usrgrpid order by usrgrp.name, groups.name;
@end=sql@


https://atlassian.hq.k.grp/confluence/pages/viewpage.action?pageId=112557332 # MSS Zabbix template git CI/CD workflow rules merge request

# jmx auto discovery
discovery rule:
type: JMX Agent
key: jmx.discovery

# expressions
{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].diff()}<>0
{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].prev()}<>{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].last()}
{IDE MTU:vfs.file.contents[/sys/class/net/{#IFNAME}/mtu].delta(55)}=0

@begin=javascript@
javascript:var bA = document._getElementsByXPath("//input[@type='checkbox']"); for (var k = bA.length - 1; k >= 0; --k) {bA[k].checked = true;} // template import select all box
@end=javascript@


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

docker run --name some-zabbix-appliance -p 80:80 -p 10051:10051 -d zabbix/zabbix-appliance:tag
docker run --name zabbix -p 80:80 -p 10051:10051 -d zabbix/zabbix-appliance:ubuntu-4.0.17

https://www.zabbix.com/documentation/4.0/manual/config/items/item/custom_intervals

# opsgenie action
/etc/opsgenie/zabbix2opsgenie -triggerName='{EVENT.NAME}' -triggerId='{TRIGGER.ID}' -triggerStatus='{TRIGGER.STATUS}' -triggerSeverity='{TRIGGER.SEVERITY}' -triggerDescription='{TRIGGER.DESCRIPTION}' -triggerUrl='{TRIGGER.URL}' -triggerValue='{TRIGGER.VALUE}' -triggerHostGroupName='{TRIGGER.HOSTGROUP.NAME}' -hostName='{HOST.NAME}' -ipAddress='{IPADDRESS}' -eventId='{EVENT.ID}' -date='{DATE}' -time='{TIME}' -itemKey='{ITEM.KEY}' -itemValue='{ITEM.VALUE}' -recoveryEventStatus='{EVENT.RECOVERY.STATUS}' -teams=sfitdn
