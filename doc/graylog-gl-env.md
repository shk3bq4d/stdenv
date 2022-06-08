# https://facinating.tech/2020/03/08/in-depth-guide-to-running-graylog-in-production/

# cluster discovery
/etc/graylog/server/server.conf mongodb_uri mongodb://admin:password@172.48.9.11:27017,172.48.8.107:27017,172.48.10.233:27017/graylog?replicaSet=rs01
/etc/graylog/server/server.conf elasticsearch_hosts http://172.48.9.200:9200,http://172.48.8.207:9200,http://172.48.10.7:9200
no need for graylog nodes to recognize each other
mongodb needs to have a replicasetCreated on the masternode. That node will then contact the other ones.

https://www.graylog.org/releases # changelog
https://docs.graylog.org/docs/changelog # releases


# extractors
are configured per inputs

do not forget space before
 mode="?([^" ]+)


# queries
http://docs.graylog.org/en/2.1/pages/queries.html
```sh
_exists_:FortinetDeviceName
NOT message:"since the source password has not been changed"
ssh login        # Messages that include the term ssh or login:
"ssh login"      # Messages that include the exact phrase ssh login:
type:ssh         # Messages where the field type includes ssh:
type:(ssh login) # Messages where the field type includes ssh or login:
type:"ssh login" # Messages where the field type includes the exact phrase ssh login:
_missing_:type   # Messages that do not have the field type:
_exists_:type    # Messages that have the field type:
_exists_:gl2_processing_error # find message with graylog processing errors (think pipeline or rules, possibly extractor)

"ssh login" AND source:example.org
("ssh login" AND (source:example.org OR source:another.example.org)) OR _exists_:always_find_me

"ssh login" AND NOT source:example.org
NOT example.org

source:*.org
source:exam?le.org
source:exam?le.*

## Fuzziness: You can search for similar but not equal terms:
ssh logni~
source:exmaple.org~


# Numeric fields support range queries. Ranges in square brackets are inclusive, curly brackets are exclusive and can even be combined:
http_response_code:[500 TO 504]
http_response_code:{400 TO 404}
bytes:{0 TO 64]
http_response_code:[0 TO 64}

http_response_code:>400    # greater than
http_response_code:<400   # lower than
http_response_code:>=400   # greater than
http_response_code:<=400   # lower than


http_response_code:(>=400 AND <500)

&& || : \ / + - ! ( ) { } [ ] ^ " ~ * ? # The following characters must be escaped with a backslash:
```


https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/java/org/graylog2/rest/models/system/inputs/extractors/requests/OrderExtractorsRequest.java # browse to find declaration for the API

# time
"last month" searches between one month ago and now
"4 hours ago" searches between four hours ago and now
"1st of april to 2 days ago" searches between 1st of April and 2 days ago
"yesterday midnight +0200 to today midnight +0200" searches between yesterday midnight and today midnight in timezone +0200 - will be 22:00 in UTC
last hour or last 90 days

# notifications
Remember that notifications are associated to streams, so all conditions evaluated in a stream will share the same notifications.


stream 1:n notifications
stream 1:n conditions


# blocking index file
starts by rebooting the node
```sh
## move first index out of the queue
systemctl stop graylog-server.service ; mv $(ls -1 /var/lib/graylog-server/journal/messagejournal-0 | head -n2) /var;  systemctl start graylog-server.service

## replay
systemctl stop graylog-server.service; cd /var; mv $(basename $(ls -1 *.log* | head -n 1) .log)* /var/lib/graylog-server/journal/messagejournal-0; systemctl start graylog-server.service
```

## backup
see `doc mongodb`


http://docs.graylog.org/en/2.4/pages/extractors.html?highlight=extractor


# negative index
well situation is likely back on track. Following @blaise suggestion I took out /var/lib/graylog-server/journal (and not only /var/lib/graylog-server/journal/messagejournal-0) as it appeared /var/lib/graylog-server/journal/graylog2-committed-read-offset had the exact same number as the one we were complaining)

# aws
http://docs.graylog.org/en/2.4/pages/installation/aws.html
sudo graylog-ctl reconfigure
sudo graylog-ctl status

# plugins
http://docs.graylog.org/en/2.4/pages/plugins.html#installing-and-loading-plugins
ls -l /usr/share/graylog-server/plugin/ /opt/graylog/plugins/


# terraform
* https://github.com/suzuki-shunsuke/docker-image-terraform-graylog
* https://hub.docker.com/r/suzukishunsuke/terraform-graylog

signup

https://docs.graylog.org/en/3.1/pages/changelog.html


```sh
curl -s http://els-host:9200/graylog_392/_mapping | jq '.[].mappings.properties | length' # number fields in one index
curl -s http://els-host:9200/graylog_392/_mapping | jq '.[].mappings.properties | keys' # number fields in one index
```

https://www.graylog.org/post/graylog-update-for-log4j
https://github.com/Graylog2/graylog2-server/pull/11786#issuecomment-994715935 # log4j


# alert
--- [Event Definition] ---------------------------
Title:       ${event_definition_title}
Description: ${event_definition_description}
Type:        ${event_definition_type}
--- [Event] --------------------------------------
Timestamp:            ${event.timestamp}
Message:              ${event.message}
Source:               ${event.source}
Key:                  ${event.key}
Priority:             ${event.priority}
Alert:                ${event.alert}
Timestamp Processing: ${event.timestamp}
Timerange Start:      ${event.timerange_start}
Timerange End:        ${event.timerange_end}
Fields:
${foreach event.fields field}  ${field.key}: ${field.value}
${end}
${if backlog}
--- [Backlog] ------------------------------------
Last messages accounting for this alert:
${foreach backlog message} <- you can change message for the variable name
${message} <- this is somekind of oneliner yaml/json
${message.timestamp}               <-  this a default field, so not in fields
${message.source}                  <-  this a default field, so not in fields
${message.message}                 <-  this a default field, so not in fields
${message.fields.winlog_event_id}  <-  this NOT a default field, so it's a key of "fields"
${end}
${end}

# faulty upgrade
```
mongo 127.0.0.1/graylog $(sed -n -r -e '/^mongodb_uri/s/.*mongodb:\/\/([^:]+):([^:@]+).*/-u \1 -p \2/ p' /etc/graylog/server/server.conf) --quiet --eval 'db.cluster_config.insert([{"type":"org.graylog2.migrations.V20161122174500_AssignIndexSetsToStreamsMigration.MigrationCompleted","payload":{"index_set_id":"5f8716200e808e404377331a","completed_stream_ids":[],"failed_stream_ids":[]},"last_updated":ISODate("2022-06-03T12:34:56.789Z"),"last_updated_by":"d9ce2ebb-2811-4e13-aa57-508ef7068fd6"}])'
```
