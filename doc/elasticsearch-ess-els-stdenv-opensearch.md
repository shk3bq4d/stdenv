```nosyntax
http://bip.bop.net:9200/_plugin/kopf/
http://bip.bop.net:9200/_plugin/head/
```

# monitor health
```sh
watch -n 14 -d=c curl -a -k -fs -XGET --user user:pass https://p-es-02.example.local:9200/_cluster/health?pretty
watch "curl -s 'http://localhost:9200/_cat/shards?v&s=index,shard' | grep -v STARTED"
watch "curl -s 'http://localhost:9200/_cluster/health?pretty'"
curl -s http://localhost:9200/_cat/nodes


https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
https://www.elastic.co/guide/en/elasticsearch/reference/current/cat-indices.html
https://www.elastic.co/guide/en/elasticsearch/reference/7.13/modules-cluster.html

curl -s 'http://localhost:9200/_cluster/health?pretty'
https://bip.bop.net/_snapshot/nfs_backups/
 curl -s 'http://localhost:9200/_cluster/settings?pretty'
curl -s http://bip.po.net:9200/_snapshot
curl -s http://bip.po.net:9200/_snapshot/nfs_backups/
curl -s http://bip.po.net:9200/_snapshot/nfs_backups/_all
curl -s http://bip.po.net:9200/_snapshot/nfs_backups/_all | prettify-json
curl -s http://localhost:9200/_cat/indices
curl -s http://localhost:9200/_cluster/allocation/explain?pretty=true # explains unassigned shards
curl -s http://localhost:9200/_cat/nodes
curl -s http://localhost:9200/_cat/nodes\?format\=json | jq
curl -s http://localhost:9200/_cat/nodes\?format\=json\&pretty\=true
curl -s http://localhost:9200/_cluster/state
curl -s http://localhost:9200/_cat/nodes\?format\=json | jq
curl -s http://localhost:9200/_cluster/state | grep read_only
curl -s http://localhost:9200/_cluster/state?pretty=true | grep -C4 read_only
curl -s http://localhost:9200/_cat/shards | sort
curl -s http://localhost:9200/_cat/shards | grep -vE 'STARTED' | sort
curl -s http://localhost:9200/_cat/shards | sort | tail -n 24
curl -s http://localhost:9200/graylog_43 | python -m json.tool
curl -XDELETE http://localhost:9200/graylog_43


curl -sXPOST http://localhost:9200/_cluster/reroute?retry_failed=true
~/bin/notinpath/elastic-reroute.sh
curl -XPOST 'localhost:9200/_cluster/reroute' -d '{
    "commands": [{
        "allocate": {
            "index": "graylog2_35",
            "shard": 2,
            "node": "p-infra-els-001-graylog",
            "allow_primary": 1
        }
    }]
}'
curl -XPOST 'localhost:9200/_cluster/reroute' -d '{
    "commands": [{
        "allocate_stale_primary": {
            "index": "graylog_43",
            "shard": 2,
            "accept_data_loss": true,
            "node": "elasticsearch-2a-01"
        }
    }]
}'
curl -XPOST 'localhost:9200/_cluster/reroute' -d '{"commands": [{ "move": { "index": "graylog_176", "shard": 1, "from_node": "es3", "to_node": "es1"}}]}'

curl http://localhost:9200/_cat/shards | sort | awk '{ print $6 }' | dehumanise
curl http://localhost:9200/_cat/shards 2>/dev/null | sort | grep elasticsearch-2c-03 | awk '{ print $6 }' | dehumanise | awk '{total += $1} END {print total / 1024 / 1024 / 1024 "Gb"}'
curl 'http://localhost:9200/_cat/shards?v&s=index,shard' # verbose and sort
curl 'http://localhost:9200/_cat/indices?v&s=index' # verbose and sort
curl -s 'http://localhost:9200/_cluster/allocation/explain?pretty=true'
```



# index indice rotation
# see ~/doc/elasticsearch-ess-els-indice-rotation.md
```sh
while :; do curl 'http://localhost:9200/_cat/indices?v&s=index' 2>/dev/null | tail -1; sleep 5; done
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      16424           44     59.6mb         28.1mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      17048           90     60.1mb         28.1mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      17404          101     57.4mb         28.9mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      17753          100     57.3mb         28.9mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      18431           91     65.7mb         35.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      18950          104     65.9mb         35.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      19554           84     68.8mb         31.6mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      19956           47       69mb         31.6mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      20362           71     66.4mb         33.4mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      20664           30     66.8mb         33.4mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      21108           84     74.5mb         34.5mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      21782           85     74.7mb         34.5mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      22239          102       73mb         36.7mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      22631           88     73.4mb         36.7mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      23252          133     76.6mb         38.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      23384           50     76.6mb         38.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      24253          130     98.1mb           46mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      25889          393     98.8mb           46mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      26589          149       87mb         42.9mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      27190          157     87.6mb         42.9mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      27459          188     89.4mb         44.7mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      28234           94     89.6mb         44.7mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      28800           98     93.5mb           47mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      29442           34     93.7mb           47mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      32894           38    102.1mb         51.5mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      35249           49      103mb         51.5mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      37356           38    119.9mb         55.6mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      40307           76    120.9mb         55.6mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      43076           59    122.8mb         61.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      46057          146    123.7mb         61.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      48186           87    144.3mb         77.8mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      51097          423    145.1mb         77.8mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      54030          187    176.5mb         82.4mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      56162           54    177.3mb         82.4mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      58858           55    178.3mb         90.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      62120           96    193.1mb         90.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      64164          103    179.4mb         83.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      66114           47    166.6mb         83.3mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      67675           25    187.8mb         86.6mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      69586           51    188.4mb         86.6mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      72104          225    184.2mb         92.1mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      73042          409      185mb         92.1mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      75075          547    207.9mb        100.9mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1        429           12    592.4kb           390b
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       1001           50    592.4kb           390b
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       1430           78      9.8mb          4.7mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       1943           88      9.8mb          4.7mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       2563          103     13.1mb          6.1mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       2848           43     13.1mb          6.1mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       3211           52     14.5mb          6.6mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       3664          110     14.5mb          6.6mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       4189          126     23.2mb         11.7mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       4556           23     23.2mb         11.7mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       5079          130     20.7mb         10.3mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1       5501          127     20.7mb         10.3mb
green  open   graylog_86 DOKbqgthQ1WF8JueKfkbJA   6   1      52401           63    162.1mb         81.2mb
green  open   graylog_87 r8nePpE2Tb2apXTnlRdLOQ   6   1      49197          127    152.9mb         76.5mb
green  open   graylog_88 hs_v_mP8RhyUVoWaP75nbA   6   1      70737          246    179.7mb         89.8mb
green  open   graylog_89 a-7V-SsSRP-F-S97pNjDPg   6   1      49135          283    162.1mb         81.1mb
green  open   graylog_90 IVfImvU4QievU4oPJvl7nw   6   1      48744           52    152.4mb         76.5mb
green  open   graylog_91 _urR3jW1Q5uY98Waigql4A   6   1      59786           55    191.4mb         95.7mb
green  open   graylog_92 Z_ze28MgRyqh_Mg6gSU1Pg   6   1      55873           17      167mb         83.5mb
green  open   graylog_93 hH67I3MvQwqF98FUd7NyDQ   6   1      76123         1033    204.8mb        101.6mb
green  open   graylog_94 Gn-MZnKwQKqtu30zrpqogA   6   1      33224          170      129mb         68.9mb
```


total space used is:
```nosyntax
 #index size * (1 + #replicas) * #nb_indices_kept * compression_ratio
```
updated config to
Index prefix: graylog
Shards: 4
Replicas: 1
Index rotation strategy: Index Size
Max index size: 10737418240 bytes (10.0GB)
Index retention strategy: Delete
Max number of indices: 16
rational:
having rotation based on size gives us peace of mind as per cluster's health liveness. (It would be good to have some alerts if incoming data is too big)
16 * 2 * 10GB is about 320GB, after compression is more like 272GB which can live on two nodes (2 * 150GB) should we loose one.
4 shards with 1 replica: gives a distribution of 2-3-3 per node, which gives a little breath to one node in the cluster to catch up from time to time and absorb any node with higher load should it fail.
16 * 10 GB is about 16 days of logs at current rate, although it would have been less than a day when glusterfs logs were spamming A LOT ￼


# reboot cluster
1. Go to graylog on the indice and perform a "Rotate active write index" maintenance on a URL like https://graylog/system/index_sets/58dd0e5036620c1b784346c5
2. Verify cluster's health
```sh
   curl -s 'http://localhost:9200/_cluster/health?pretty'  | grep status
   curl -s 'http://localhost:9200/_cat/shards?v&s=index,shard' | grep -v STARTED
```
3. Once green, deactivate shard allocation using either the deprecated
   cluster.routing.allocation.disable_allocation
   or the current
   cluster.routing.allocation.enable
   option
```sh
   ##deprecated a=true; curl -XPUT -d "{\"transient\":{\"cluster.routing.allocation.disable_allocation\":$a}}" 'http://localhost:9200/_cluster/settings'
   b=primaries; curl -XPUT -H 'content-type: application/json' -d "{\"transient\":{\"cluster.routing.allocation.enable\":\"$b\"}}" 'http://localhost:9200/_cluster/settings'
```
4. Reboot one node and wait for it to come and have its service up again
5. Reactivate allocation
```bash
   b=all; curl -XPUT -d "{\"transient\":{\"cluster.routing.allocation.enable\":\"$b\"}}" 'http://localhost:9200/_cluster/settings'
```
6. Verify cluster's health
7. When green, deactivate shard allocation
8. Reboot next node (go to 4.)


# remove read only flag
```bash
curl -XPUT -d '{"index.blocks.read_only_allow_delete": null }' -H 'content-type: application/json' -s 'http://localhost:9200/_all/_settings' # remove readonly read-only
```

# temporarily increase node_concurrent_recoveries
```sh
curl -XPUT -d '{"transient":{"cluster.routing.allocation.node_concurrent_recoveries":5}}' -H 'content-type: application/json' 'http://localhost:9200/_cluster/settings'
```

# ElasticsearchException[Elasticsearch exception [type=illegal_argument_exception, reason=Limit of total fields [1000] has been exceeded]]
```sh
curl -XPUT http://localhost:9200/graylog_371/_settings -d '{ "index.mapping.total_fields.limit": 2000 }' -H 'content-type: application/json'
```

7.16.2 log4j 2.17.0
6.8.22 log4j 2.17.0

Elasticsearch   JDK CVE IDs Information Leak    Remote Code Execution   Complete Mitigation
7.16.1 - 7.16.2 ≥ 8 CVE-2021-44228, CVE-2021-45046  No  No  N/A (not vulnerable)
7.0.0 - 7.16.0  ≥ 9 CVE-2021-44228, CVE-2021-45046  No  No  N/A3 (not vulnerable)
7.0.0 - 7.16.0  < 9 CVE-2021-44228, CVE-2021-45046  Yes No  System property1
6.8.21  ≥ 8 CVE-2021-44228, CVE-2021-45046  No  No  N/A (not vulnerable)
6.0.0 - 6.8.20  ≥ 9 CVE-2021-44228, CVE-2021-45046  No  No  N/A3 (not vulnerable)
6.4.0 - 6.8.20  < 9 CVE-2021-44228, CVE-2021-45046  Yes No  System property1
6.0.0 - 6.3.2   < 9 CVE-2021-44228, CVE-2021-45046  Yes No  Remove JndiLookup2
5.6.11 - 5.6.16 8   CVE-2021-44228, CVE-2021-45046  Yes Yes System property1
5.0.0 - 5.6.10  8   CVE-2021-44228, CVE-2021-45046  Yes Yes Remove JndiLookup2
< 5.0.0 any CVE-2021-44228, CVE-2021-45046  No  No  N/A (not vulnerable)
1Set the JVM option -Dlog4j2.formatMsgNoLookups=true on each node and restart each node. This is a complete mitigation where noted above. Elasticsearch has no known vulnerabilities to Thread Context Message and Context Lookup from CVE-2021-45046.

2Removal of the JndiLookup class from the Log4j library. Instructions here.

3No mitigation is needed as this configuration is not vulnerable. On Elasticsearch 6.4.0 or higher, you can still add the system property in an abundance of caution.

https://discuss.elastic.co/t/apache-log4j2-remote-code-execution-rce-vulnerability-cve-2021-44228-esa-2021-31/291476
https://discuss.elastic.co/t/elasticsearch-5-0-0-5-6-10-and-6-0-0-6-3-2-log4j-cve-2021-44228-cve-2021-45046-remediation/292054
https://github.com/elastic/elasticsearch/pull/47298 # log4j
https://www.elastic.co/what-is/opensearch # amazon
https://opensearch.org/ # amazon
https://github.com/opensearch-project # amazon
https://opensearch.org/docs/latest/
https://github.com/opensearch-project/opensearch-build/issues/1117 # rpm yum centos7


# shutdown node lifecycle
API appeard in 7.15, not in 7.14 nor 7.13
https://www.elastic.co/guide/en/elasticsearch/reference/current/put-shutdown.html
https://www.elastic.co/guide/en/elasticsearch/reference/7.15/put-shutdown.html
https://www.elastic.co/guide/en/elasticsearch/reference/7.17/put-shutdown.html
```sh
mynode="graylog-elasticsearch-data-1"; curl -XPUT http://localhost:9200/graylog_371/_settings -d '{ "index.mapping.total_fields.limit": 2000 }' -H 'content-type: application/json'
graylog-elasticsearch-data-1
```
