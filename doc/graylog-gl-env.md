# https://facinating.tech/2020/03/08/in-depth-guide-to-running-graylog-in-production/

https://hub.docker.com/r/graylog/graylog
https://hub.docker.com/r/graylog/graylog-datanode

# cluster discovery
/etc/graylog/server/server.conf mongodb_uri mongodb://admin:password@172.48.9.11:27017,172.48.8.107:27017,172.48.10.233:27017/graylog?replicaSet=rs01
/etc/graylog/server/server.conf elasticsearch_hosts http://172.48.9.200:9200,http://172.48.8.207:9200,http://172.48.10.7:9200
no need for graylog nodes to recognize each other
mongodb needs to have a replicasetCreated on the masternode. That node will then contact the other ones.

https://go2docs.graylog.org/5-0/changelogs/changelog.html
* https://www.graylog.org/releases # changelog
* https://go2docs.graylog.org/current/changelogs/changelog.html?tocpath=Changelogs%7C_____1 # releases
https://github.com/Graylog2/graylog2-server/tree/4.3.10/changelog/4.3.10

https://go2docs.graylog.org/4-x/what_is_graylog/what_is_graylog_operations.html
https://go2docs.graylog.org/4-x/changelogs/changelog.html
https://go2docs.graylog.org/4-x/changelogs/operations_changelog.html

https://YOUR_INSTANCE/api/api-browser/global/index.html

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

_index:graylog_8* AND _exists_: palo_field0 # search in specific index

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
* https://github.com/zahiar/terraform-provider-graylog
* https://registry.terraform.io/providers/zahiar/graylog/1.3.0
* https://github.com/one-2-one/terraform-provider-graylog
* https://registry.terraform.io/providers/terraform-provider-graylog/graylog/latest/docs

## ressources
graylog_alarm_callback
graylog_alert_condition
graylog_dashboard
graylog_dashboard_widget
graylog_dashboard_widget_positions
graylog_event_definition
graylog_event_notification
graylog_extractor
graylog_grok_pattern
graylog_index_set
graylog_input
graylog_input_static_fields
graylog_ldap_setting
graylog_output
graylog_pipeline
graylog_pipeline_connection
graylog_pipeline_rule
graylog_role
graylog_sidecar_collector
graylog_sidecar_configuration
graylog_sidecars
graylog_stream
graylog_stream_output
graylog_stream_rule
graylog_user

## Data Sources
graylog_dashboard
graylog_index_set
graylog_sidecar
graylog_stream

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

# pipelines
https://go2docs.graylog.org/4-x/making_sense_of_your_log_data/functions_descriptions.html

# hidden fields
  gl2_accounted_message_size: long
  gl2_message_id: keyword
  gl2_original_timestamp: date
  gl2_processing_timestamp: date
  gl2_receive_timestamp: date
  gl2_remote_ip: keyword
  gl2_remote_port: long
  gl2_source_input: keyword
  gl2_source_node: keyword
  gl2_processing_duration_ms
  gl2_second_sort_field


 ansible module to be checked and extended: https://github.com/ReconInfoSec/ansible-graylog-modules

# docker
https://go2docs.graylog.org/current/downloading_and_installing_graylog/docker_installation.htm

# mongodb
```sh
sudo docker exec -itu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates -u admin -p "$(sudo docker exec -t mongodb sh -c 'echo -n $MONGO_INITDB_ROOT_PASSWORD')"
sudo docker exec -itu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates "$(sudo docker exec -t graylog sh -c 'echo -n $GRAYLOG_MONGODB_URI')"
echo "show dbs" | sudo docker exec -iu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates "$(sudo docker exec -t graylog sh -c 'echo -n $GRAYLOG_MONGODB_URI')"
echo "show collections" | sudo docker exec -iu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates "$(sudo docker exec -t graylog sh -c 'echo -n $GRAYLOG_MONGODB_URI')"
echo "show collections" | xargs -I_ sudo docker exec -iu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates --norc --quiet "$(sudo docker exec -t graylog sh -c 'echo -n $GRAYLOG_MONGODB_URI')"  --eval "_"
echo "db.datanodes.find().pretty()" | xargs -I_ sudo docker exec -iu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates --norc --quiet "$(sudo docker exec -t graylog sh -c 'echo -n $GRAYLOG_MONGODB_URI')"  --eval "_"
echo "db.datanodes.countDocuments()" | xargs -I_ sudo docker exec -iu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates --norc --quiet "$(sudo docker exec -t graylog sh -c 'echo -n $GRAYLOG_MONGODB_URI')"  --eval "_"
mongo.sh "db.datanodes.countDocuments()"
mongo.sh "db.access_tokens.countDocuments()"
mongo.sh "show collections" | while read c; do printf "%-40s %d\n" "$c" "$(mongo.sh "db.$c.countDocuments()")"; done
mongo.sh "db.cluster_config.find().pretty()"
mongo.sh "db.nodes.find().pretty()"
mongo.sh "db.datanodes.find().pretty()"
```
## collections
```sh
access_tokens
certificate_exchange
cluster_config
cluster_events
cluster_locks
content_packs
content_packs_installations
dashboards                            [view]
datanodes
entity_list_preferences
event_definitions
event_notifications
event_processor_state
favorites
grants
grok_patterns
index_failures
index_field_type_profiles
index_field_types
index_ranges
index_set_templates
index_sets
inputs
last_opened
lut_caches
lut_data_adapters
lut_tables
nodes
notifications
pipeline_processor_pipelines
pipeline_processor_pipelines_streams
pipeline_processor_rules
preflight
processing_status
query_strings
recent_activity
roles
rule_fragments
scheduler_job_definitions
scheduler_triggers
search_job_states
searches
sessions
sidecar_collectors
sidecar_configuration_variables
sidecar_configurations
sidecars
stream_destination_filters
streamrules
streams
system_messages
telemetry_cluster_infos
telemetry_user_settings
traffic
users
views
system.views
```


# graylog datanode opensearch
https://go2docs.graylog.org/current/setting_up_graylog/data_node_configuration_overrides.htm?tocpath=Set%20Up%20Graylog%7CConfiguration%20Settings%7CData%20Node%20Configuration%7C_____1
https://docs.opensearch.org/docs/2.17/tuning-your-cluster/#shard-allocation-awareness

Hi,
You have two options. Either you can use the built-in proxy in the graylog server to forward authenticated requests directly to the underlying opensearch. This will add the needed JWT auth header for you. The URL format is `/api/datanodes/{hostname}/opensearch/{path: .*}`

[for example](http://graylog-server-host:port/api/datanodes/any/opensearch/_cat/indices?h=index,status)

The {hostname} part can be used to target a specific datanode/opensearch instance. The any keyword will forward your request to a random connected opensearch.

By default the proxy is limited to a few read-only opensearch endpoints. You’ll need to disable the allowlist if you want to delete indices. The graylog-server setting is called datanode_proxy_api_allowlist. Set it to false if you want to disable it.

You’ll also need your graylog auth credentials provided as basic auth header in the request.

The other option is to generate client certificates which you can use to communicate directly. They can be configured and downloaded in the System->Datanodes->Configuration menu.

Best regards,
Tomas


```sh
$ curl-opensearch.sh _cat/shards\?help
index                                     | i,idx                                       | index name
shard                                     | s,sh                                        | shard name
prirep                                    | p,pr,primaryOrReplica                       | primary or replica
state                                     | st                                          | shard state
docs                                      | d,dc                                        | number of docs in shard
store                                     | sto                                         | store size of shard (how much disk it uses)
ip                                        |                                             | ip of node where it lives
id                                        |                                             | unique id of node where it lives
node                                      | n                                           | name of node where it lives
sync_id                                   | sync_id                                     | sync id
unassigned.reason                         | ur                                          | reason shard is unassigned
unassigned.at                             | ua                                          | time shard became unassigned (UTC)
unassigned.for                            | uf                                          | time has been unassigned
unassigned.details                        | ud                                          | additional details as to why the shard became unassigned
recoverysource.type                       | rs                                          | recovery source type
completion.size                           | cs,completionSize                           | size of completion
fielddata.memory_size                     | fm,fielddataMemory                          | used fielddata cache
fielddata.evictions                       | fe,fielddataEvictions                       | fielddata evictions
query_cache.memory_size                   | qcm,queryCacheMemory                        | used query cache
query_cache.evictions                     | qce,queryCacheEvictions                     | query cache evictions
flush.total                               | ft,flushTotal                               | number of flushes
flush.total_time                          | ftt,flushTotalTime                          | time spent in flush
get.current                               | gc,getCurrent                               | number of current get ops
get.time                                  | gti,getTime                                 | time spent in get
get.total                                 | gto,getTotal                                | number of get ops
get.exists_time                           | geti,getExistsTime                          | time spent in successful gets
get.exists_total                          | geto,getExistsTotal                         | number of successful gets
get.missing_time                          | gmti,getMissingTime                         | time spent in failed gets
get.missing_total                         | gmto,getMissingTotal                        | number of failed gets
indexing.delete_current                   | idc,indexingDeleteCurrent                   | number of current deletions
indexing.delete_time                      | idti,indexingDeleteTime                     | time spent in deletions
indexing.delete_total                     | idto,indexingDeleteTotal                    | number of delete ops
indexing.index_current                    | iic,indexingIndexCurrent                    | number of current indexing ops
indexing.index_time                       | iiti,indexingIndexTime                      | time spent in indexing
indexing.index_total                      | iito,indexingIndexTotal                     | number of indexing ops
indexing.index_failed                     | iif,indexingIndexFailed                     | number of failed indexing ops
merges.current                            | mc,mergesCurrent                            | number of current merges
merges.current_docs                       | mcd,mergesCurrentDocs                       | number of current merging docs
merges.current_size                       | mcs,mergesCurrentSize                       | size of current merges
merges.total                              | mt,mergesTotal                              | number of completed merge ops
merges.total_docs                         | mtd,mergesTotalDocs                         | docs merged
merges.total_size                         | mts,mergesTotalSize                         | size merged
merges.total_time                         | mtt,mergesTotalTime                         | time spent in merges
refresh.total                             | rto,refreshTotal                            | total refreshes
refresh.time                              | rti,refreshTime                             | time spent in refreshes
refresh.external_total                    | rto,refreshTotal                            | total external refreshes
refresh.external_time                     | rti,refreshTime                             | time spent in external refreshes
refresh.listeners                         | rli,refreshListeners                        | number of pending refresh listeners
search.fetch_current                      | sfc,searchFetchCurrent                      | current fetch phase ops
search.fetch_time                         | sfti,searchFetchTime                        | time spent in fetch phase
search.fetch_total                        | sfto,searchFetchTotal                       | total fetch ops
search.open_contexts                      | so,searchOpenContexts                       | open search contexts
search.query_current                      | sqc,searchQueryCurrent                      | current query phase ops
search.query_time                         | sqti,searchQueryTime                        | time spent in query phase
search.query_total                        | sqto,searchQueryTotal                       | total query phase ops
search.concurrent_query_current           | scqc,searchConcurrentQueryCurrent           | current concurrent query phase ops
search.concurrent_query_time              | scqti,searchConcurrentQueryTime             | time spent in concurrent query phase
search.concurrent_query_total             | scqto,searchConcurrentQueryTotal            | total concurrent query phase ops
search.concurrent_avg_slice_count         | casc,searchConcurrentAvgSliceCount          | average query concurrency
search.scroll_current                     | scc,searchScrollCurrent                     | open scroll contexts
search.scroll_time                        | scti,searchScrollTime                       | time scroll contexts held open
search.scroll_total                       | scto,searchScrollTotal                      | completed scroll contexts
search.point_in_time_current              | spc,searchPointInTimeCurrent                | open point in time contexts
search.point_in_time_time                 | spti,searchPointInTimeTime                  | time point in time contexts held open
search.point_in_time_total                | spto,searchPointInTimeTotal                 | completed point in time contexts
search.search_idle_reactivate_count_total | ssirct,searchSearchIdleReactivateCountTotal | number of times a shard reactivated
segments.count                            | sc,segmentsCount                            | number of segments
segments.memory                           | sm,segmentsMemory                           | memory used by segments
segments.index_writer_memory              | siwm,segmentsIndexWriterMemory              | memory used by index writer
segments.version_map_memory               | svmm,segmentsVersionMapMemory               | memory used by version map
segments.fixed_bitset_memory              | sfbm,fixedBitsetMemory                      | memory used by fixed bit sets for nested object field types and type filters for types referred in _parent fields
seq_no.max                                | sqm,maxSeqNo                                | max sequence number
seq_no.local_checkpoint                   | sql,localCheckpoint                         | local checkpoint
seq_no.global_checkpoint                  | sqg,globalCheckpoint                        | global checkpoint
warmer.current                            | wc,warmerCurrent                            | current warmer ops
warmer.total                              | wto,warmerTotal                             | total warmer ops
warmer.total_time                         | wtt,warmerTotalTime                         | time spent in warmers
path.data                                 | pd,dataPath                                 | shard data path
path.state                                | ps,statsPath                                | shard state path
docs.deleted                              | dd,docsDeleted                              | number of deleted docs in shard
```

"Group By->Timestamp, Metrics->Function:Count, Visualization->Type:Bar Chart,Mode:Stack,Axis Type:linear # histogram
