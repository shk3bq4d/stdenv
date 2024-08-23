```sh
mongoexport -h MYHOST --port=33333 -u backup -p MYPASS --authenticationDatabase=config --db=graylog --collection=pipeline_processor_rules
show databases     //Print a list of all available databases.
show dbs   // Print a list of all databases on the server.

use <db>    // Switch current database to <db>. The mongo shell variable db is set to the current database.
show collections    //Print a list of all collections for current database.
db.getCollectionNames()
show users  //Print a list of users for current database.
show roles  //Print a list of all roles, both user-defined and built-in, for the current database.
```


# check is master / primary
  roles:
```sh
mongo --quiet --eval "d=db.isMaster(); print( d['ismaster'] );"
mongo --quiet --eval "print(db.isMaster()['ismaster']);"
mongo --host MYHOST --port=27017 --quiet --eval "d=db.isMaster(); print( d['ismaster'] );"
```

# blue
```sh
mongo 127.0.0.1/graylog $(sudo sed -n -r -e '/^mongodb_uri/s/.*mongodb:\/\/([^:]+):([^:@]+).*/-u \1 -p \2/ p' /etc/graylog/server/server.conf)
mongo 127.0.0.1/graylog -u admin -p $(sudo sed -n -r -e '/^mongodb_uri/s/.*mongodb:\/\/([^:]+):([^:@]+).*/-u \1 -p \2/ p' /etc/graylog/server/server.conf)
mongo 127.0.0.1/graylog $(sudo sed -n -r -e '/^mongodb_uri/s/.*mongodb:\/\/([^:]+):([^:@]+).*/-u \1 -p \2/ p' /etc/graylog/server/server.conf) --quiet --eval "db.cluster_config.find().pretty()"
mongo 127.0.0.1/graylog $(sudo sed -n -r -e '/^mongodb_uri/s/.*mongodb:\/\/([^:]+):([^:@]+).*/-u \1 -p \2/ p' /etc/graylog/server/server.conf) --quiet --eval "db.cluster_config.find({},{_id:0,last_updated:0,last_updated_by:0}).sort({"last_updated":1}).toArray()" > ~me/azure8
mongo 127.0.0.1/graylog $(sudo sed -n -r -e '/^mongodb_uri/s/.*mongodb:\/\/([^:]+):([^:@]+).*/-u \1 -p \2/ p' /etc/graylog/server/server.conf) --quiet --eval 'db.cluster_config.insert([{"type":"org.graylog2.migrations.V20161122174500_AssignIndexSetsToStreamsMigration.MigrationCompleted","payload":{"index_set_id":"5f8716200e808e404377331a","completed_stream_ids":[],"failed_stream_ids":[]},"last_updated":ISODate("2022-06-03T12:34:56.789Z"),"last_updated_by":"d9ce2ebb-2811-4e13-aa57-508ef7068fd6"}])'
mongo 127.0.0.1/graylog -u 'MYUSER' -p 'MYPASSWORD'
mongo 172.18.9.77/graylog -u 'MYUSER' -p 'MYPASSWORD'
mongo 172.18.9.140/graylog -u 'MYUSER' -p 'MYPASSWORD' --quiet --eval  "printjson(db.adminCommand('listDatabases'))"
mongo 172.18.9.140/graylog -u 'MYUSER' -p 'MYPASSWORD' --quiet --eval  "print('_ ' + db.getCollectionNames())"
mongo 172.18.9.140/graylog -u 'MYUSER' -p 'MYPASSWORD' --quiet --eval  "rs.slaveOk(); print(db.getCollectionNames())" | tr ',' '\n' | xargs -n1 -I@ mongoexport -h 172.18.9.140 --db graylog -u 'graylog' -p 'MYPASSWORD'  --pretty --collection @ -o out/@.json
mongo -u admin -pMYPASSWORD --authenticationDatabase admin
mongo -u admin -pMYPASSWORD --authenticationDatabase admin -host rs01/localhost:27017 # force connection to effective master primary with on replicaset rs01
mongoimport --db graylog --username=admin --password=MYPASSWORD --authenticationDatabase=admin --verbose --drop users.json
```

# querifing unify controller
```sh
sudo docker exec -it mongo mongo 127.0.0.1/unifi
```
```js
db.site.findOne()
db.site.find().forEach(function(i) { print(i.desc); })
db.site.find().forEach(function(i) { print(i._id + " " + i.desc); })
db.device.findOne(); // name, ip, mac, version, site_id, config_network.type, config_network.ip
db.site.find().forEach(function(i) { print(i._id + " " + i.desc); })
db.device.find().forEach(function(i) { print(i.name); })
db.device.find().forEach(function(i) { print(i.ip + " " + i.name); })
db.setting.find().forEach(function(i) { if (!i.site_id) printjson(i.key); })
```

# querying graylog
```sh
db.collectionName.find().pretty() # show all elements in one collection

db.ldap_settings.find().pretty(); # graylog ldap ad
db.ldap_settings.update({}, {$set: {"system_username": 'myuser@mydomain.local'}}); # graylog ldap

db.streams.find()
db.users.find()

echo users.json roles.json streams* pipeline_processor_* lut* inputs.json dashboards.json grok_patterns.json collector* alarmcallback* | xargs -rtn 1 mongoimport --db graylog --username=admin --password=MYPASSWORD --authenticationDatabase=admin --verbose --drop
db.COLLECTIONNAME.find().toArray().length
db.index_sets.find().toArray().length
db.index_sets.find().toArray()[0]["_id"]
mongo -u admin -pMYPASSWORD --authenticationDatabase admin graylog --quiet --eval 'db.index_sets.find().toArray()[0]["_id"].valueOf();'
```

# add node
```sh
rs.add('mongo-master-2a-01.dev.payday.net:27017')
rs.add('mongo-master-2b-02.dev.payday.net:27017')
rs.add('mongo-master-2c-03.dev.payday.net:27017')
```

# remove nodes
```sh
cfg = rs.conf()
cfg.members = [cfg.members[0] , cfg.members[4] , cfg.members[7]]
cfg.members = [cfg.members[1] , cfg.members[2] , cfg.members[3]]
cfg.members[0].host = 'mongo-2c-02.dev.payday.net:27017'
cfg.members[0].host = 'mongo-2c-02.dev.payday.net:27017'
rs.reconfig(cfg, {force : true})

rs.stepDown(600) # relinquish master and mark it as unelectable for 60 seconds
rs.freeze(60) # mark it as unelectable for 60 seconds (useful before reboot)

cfg = rs.conf(); for (var k = 0, s = cfg.members.length; k < s; ++k) {cfg.members[k].host=cfg.members[k].host.replace(':', '.prod.payday.net:');print(cfg.members[k].host);}; rs.reconfig(cfg);

rs.isMaster().primary
```


# restore config from \*.json
```sh
cd /backup_mongo/latest/2018-11-06_04h00m.Tuesday/text; for i in *.json; do cat $i | mongoimport --db graylog --username=admin --password=MYPASSWORD --authenticationDatabase=admin --verbose --drop --collection=$(basename $i .json); done
```

```js
rs.status()
rs.status().myState
sA = rs.status().members; for (var k = 0, s = sA.length; k < s; ++k) {print('health: ' + sA[k].health + ', state: ' + sA[k].stateStr + ', ' + sA[k].name);}
```

# https://docs.mongodb.com/manual/reference/replica-states/
0	STARTUP	Not yet an active member of any set. All members start up in this state. The mongod parses the replica set configuration document while in STARTUP.
1	PRIMARY	The member in state primary is the only member that can accept write operations. Eligible to vote.
2	SECONDARY	A member in state secondary is replicating the data store. Eligible to vote.
3	RECOVERING	Members either perform startup self-checks, or transition from completing a rollback or resync. Eligible to vote.
5	STARTUP2	The member has joined the set and is running an initial sync. Eligible to vote.
6	UNKNOWN	The member’s state, as seen from another member of the set, is not yet known.
7	ARBITER	Arbiters do not replicate data and exist solely to participate in elections. Eligible to vote.
8	DOWN	The member, as seen from another member of the set, is unreachable.
9	ROLLBACK	This member is actively performing a rollback. Eligible to vote. Data is not available for reads from this member.
10	REMOVED	This member was once in a replica set but was subsequently removed.


```js
db.createUser( { user: "accountAdmin01",
                 pwd: "changeMe",
                 customData: { employeeId: 12345 },
                 roles: [ { role: "clusterAdmin", db: "admin" },
                          { role: "readAnyDatabase", db: "admin" },
                          "readWrite"] },
               { w: "majority" , wtimeout: 5000 } )

db.createUser( { user: "accountAdmin01",
                 pwd: "changeMe",
                 customData: { employeeId: 12345 },
                 roles: [ { role: "root", db: "admin" },
                          "readWrite"] },
               { w: "majority" , wtimeout: 5000 } )
```

# upgrade
https://docs.mongodb.com/manual/release-notes/4.2-upgrade-replica-set/
db.adminCommand( { setFeatureCompatibilityVersion: "4.0" } ); # so as to prevent new nodes being updated from doing anything silly with new features
upgrade all the secondary nodes, one by one, ensure service was restarted
rs.stepDown(600); on the master, to relinquish its master status
upgrade the last node
db.adminCommand( { setFeatureCompatibilityVersion: "4.2" } ); # to the new, upgrade version


# memory limit RAM
from https://github.com/jacobalberty/unifi-docker/compare/master...deviantintegral:unifi-docker:patch-1
 # Uncomment and modify the following to limit how much memory Mongo will use.
    # If the cache is too small, this may lead to higher CPU use.
    # https://www.mongodb.com/docs/manual/faq/storage/#to-what-size-should-i-set-the-wiredtiger-internal-cache-
    # command: --wiredTigerCacheSizeGB 0.25
