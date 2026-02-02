```sh
https://github.com/mongodb/helm-charts
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

# graylog
sudo docker exec -itu mongodb mongodb mongosh
sudo docker exec -itu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates
sudo docker exec -itu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates -u admin -p "$(sudo docker exec -tu mongodb mongodb sh -c 'echo -n $MONGO_INITDB_ROOT_PASSWORD')"
sudo docker exec -itu mongodb mongodb mongosh --tls --tlsAllowInvalidCertificates "$(sudo docker exec -t graylog sh -c 'echo -n $GRAYLOG_MONGODB_URI')"
use graylog
db.nodes.find().pretty()
db.datanodes.find().pretty()
mongo.sh "show collections" | while read c; do printf "%-40s %d\n" "$c" "$(mongo.sh "db.$c.countDocuments()")"; done

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
db.version()
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


mongo.sh 'const c = db.index_failures.find().sort({ timestamp: -1 }).limit(3); while (c.hasNext()) {const d = c.next(); print(d.timestamp);}'
'const c = db.index_failures.find().sort({ timestamp: -1 }).limit(3); while (c.hasNext()) {const d = c.next(); print(d.timestamp.toISOString() + " " +d.message);};'


# https://www.mongodb.com/docs/manual/reference/method/
```sh
db.collection.createSearchIndex() Creates an MongoDB Search index on a specified collection or view.
db.collection.dropSearchIndex() Deletes an existing MongoDB Search index.
db.collection.getSearchIndexes() Returns information about existing MongoDB Search indexes on a specified collection or view.
db.collection.updateSearchIndex() Updates an existing MongoDB Search index.
sp.createStreamProcessor() Creates a stream processor.
sp.listStreamProcessors() Lists all existing stream processors on the current stream processing workspace.
sp.process() Creates an ephemeral stream processor.
sp.processor.drop() Deletes an existing stream processor.
sp.processor.sample() Returns an array of sampled results from a currently running stream processor.
sp.processor.start() Starts an existing stream processor.
sp.processor.stats() Returns statistics summarizing an existing stream processor.
sp.processor.stop() Stops a currently running stream processor.
db.collection.analyzeShardKey() Calculates metrics for evaluating a shard key.
db.collection.aggregate() Provides access to the [aggregation pipeline](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/aggregation-pipeline/#std-label-aggregation-pipeline).
db.collection.bulkWrite() Provides bulk write operation functionality.
db.collection.compactStructuredEncryptionData() Wraps [`compactStructuredEncryptionData`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/compactStructuredEncryptionData/#mongodb-dbcommand-dbcmd.compactStructuredEncryptionData) to return a success or failure object.
db.collection.configureQueryAnalyzer() Configures query sampling for a collection.
db.collection.count() Wraps [`count`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/count/#mongodb-dbcommand-dbcmd.count) to return a count of the number of documents in a collection or a view.
db.collection.countDocuments() Wraps the [`$group`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/operator/aggregation/group/#mongodb-pipeline-pipe.-group) aggregation stage with a [`$sum`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/operator/aggregation/sum/#mongodb-group-grp.-sum) expression to return a count of the number of documents in a collection or a view.
db.collection.createIndex() Builds an index on a collection.
db.collection.createIndexes() Builds one or more indexes on a collection.
db.collection.dataSize() Returns the size of the collection. Wraps the [`size`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/collStats/#mongodb-data-collStats.size) field in the output of the [`collStats`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/collStats/#mongodb-dbcommand-dbcmd.collStats).
db.collection.deleteOne() Deletes a single document in a collection.
db.collection.deleteMany() Deletes multiple documents in a collection.
db.collection.distinct() Returns an array of documents that have distinct values for the specified field.
db.collection.drop() Removes the specified collection from the database.
db.collection.dropIndex() Removes a specified index on a collection.
db.collection.dropIndexes() Removes all indexes on a collection.
db.collection.estimatedDocumentCount() Wraps [`count`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/count/#mongodb-dbcommand-dbcmd.count) to return an approximate count of the documents in a collection or a view.
db.collection.explain() Returns information on the query execution of various methods.
db.collection.find() Performs a query on a collection or a view and returns a cursor object.
db.collection.findAndModify() Atomically modifies and returns a single document.
db.collection.findOne() Performs a query and returns a single document.
db.collection.findOneAndDelete() Finds a single document and deletes it.
db.collection.findOneAndReplace() Finds a single document and replaces it.
db.collection.findOneAndUpdate() Finds a single document and updates it.
db.collection.getIndexes() Returns an array of documents that describe the existing indexes on a collection.
db.collection.getShardDistribution() For collections in sharded clusters, [`db.collection.getShardDistribution()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/db.collection.getShardDistribution/#mongodb-method-db.collection.getShardDistribution) reports data of [chunk](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-chunk) distribution.
db.collection.getShardVersion() Internal diagnostic method for sharded cluster.
db.collection.hideIndex() Hides an index from the query planner.
db.collection.insertOne() Inserts a new document into a collection.
db.collection.insertMany() Inserts several new documents into a collection.
db.collection.isCapped() Reports if a collection is a [capped collection](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-capped-collection).
db.collection.latencyStats() Returns latency statistics for a collection.
db.collection.mapReduce() Performs map-reduce style data aggregation.
db.collection.reIndex() Rebuilds all existing indexes on a collection.
db.collection.remove() Deletes documents from a collection.
db.collection.renameCollection() Changes the name of a collection.
db.collection.replaceOne() Replaces a single document in a collection.
db.collection.stats() Reports on the state of a collection. Provides a wrapper around the [`collStats`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/collStats/#mongodb-dbcommand-dbcmd.collStats).
db.collection.storageSize() Reports the total size used by the collection in bytes. Provides a wrapper around the [`storageSize`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/collStats/#mongodb-data-collStats.storageSize) field of the [`collStats`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/collStats/#mongodb-dbcommand-dbcmd.collStats) output.
db.collection.totalIndexSize() Reports the total size used by the indexes on a collection. Provides a wrapper around the [`totalIndexSize`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/collStats/#mongodb-data-collStats.totalIndexSize) field of the [`collStats`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/collStats/#mongodb-dbcommand-dbcmd.collStats) output.
db.collection.totalSize() Reports the total size of a collection, including the size of all documents and all indexes on a collection.
db.collection.unhideIndex() Unhides an index from the query planner.
db.collection.updateOne() Modifies a single document in a collection.
db.collection.updateMany() Modifies multiple documents in a collection.
db.collection.watch() Establishes a Change Stream on a collection.
db.collection.validate() Performs diagnostic operations on a collection.
cursor.addOption() Adds special wire protocol flags that modify the behavior of the query.'
cursor.allowDiskUse() Allows MongoDB to use temporary files on disk to store data exceeding the 100 megabyte system memory limit while processing an in-memory sort operation.
cursor.batchSize() Controls the number of documents MongoDB will return to the client in a single network message.
cursor.close() Close a cursor and free associated server resources.
cursor.isClosed() Returns `true` if the cursor is closed.
cursor.collation() Specifies the collation for the cursor returned by the [`db.collection.find()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/db.collection.find/#mongodb-method-db.collection.find).
cursor.comment() Attaches a comment to the query to allow for traceability in the logs and the system.profile collection.
cursor.count() Modifies the cursor to return the number of documents in the result set rather than the documents themselves.
cursor.explain() Reports on the query execution plan for a cursor.
cursor.forEach() Applies a JavaScript function for every document in a cursor.
cursor.hasNext() Returns true if the cursor has documents and can be iterated.
cursor.hint() Forces MongoDB to use a specific index for a query.
cursor.isExhausted() Returns `true` if the cursor is closed *and* there are no objects remaining in the batch.
cursor.itcount() Computes the total number of documents in the cursor client-side by fetching and iterating the result set.
cursor.limit() Constrains the size of a cursor's result set.
cursor.map() Applies a function to each document in a cursor and collects the return values in an array.
cursor.max() Specifies an exclusive upper index bound for a cursor. For use with [`cursor.hint()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/cursor.hint/#mongodb-method-cursor.hint)
cursor.maxTimeMS() Specifies a cumulative time limit in milliseconds for processing operations on a cursor.
cursor.min() Specifies an inclusive lower index bound for a cursor. For use with [`cursor.hint()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/cursor.hint/#mongodb-method-cursor.hint)
cursor.next() Returns the next document in a cursor.
cursor.noCursorTimeout() Instructs the server to avoid closing a cursor automatically after a period of inactivity.
cursor.objsLeftInBatch() Returns the number of documents left in the current cursor batch.
cursor.pretty() Configures the cursor to display results in an easy-to-read format.
cursor.readConcern() Specifies a [read concern](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-read-concern) for a [`find()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/db.collection.find/#mongodb-method-db.collection.find) operation.
cursor.readPref() Specifies a [read preference](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-read-preference) to a cursor to control how the client directs queries to a [replica set](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-replica-set).
cursor.returnKey() Modifies the cursor to return index keys rather than the documents.
cursor.showRecordId() Adds an internal storage engine ID field to each document returned by the cursor.
cursor.size() Returns a count of the documents in the cursor after applying [`skip()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/cursor.skip/#mongodb-method-cursor.skip) and [`limit()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/cursor.limit/#mongodb-method-cursor.limit) methods.
cursor.skip() Returns a cursor that begins returning results only after passing or skipping a number of documents.
cursor.sort() Returns results ordered according to a sort specification.
cursor.tailable() Marks the cursor as tailable. Only valid for cursors over capped collections.
cursor.toArray() Returns an array that contains all documents returned by the cursor.
db.adminCommand() Runs a command against the `admin` database.
db.aggregate() Runs admin/diagnostic pipeline which does not require an underlying collection.
db.commandHelp() Returns help information for a [database command](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-database-command).
db.createCollection() Creates a new collection or a view. Commonly used to create a capped collection.
db.createView() Creates a view.
db.currentOp() Reports the current in-progress operations.
db.dropDatabase() Removes the current database.
db.fsyncLock() Flushes writes to disk and locks the database to prevent write operations and assist backup operations. Wraps [`fsync`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/fsync/#mongodb-dbcommand-dbcmd.fsync).
db.fsyncUnlock() Allows writes to continue on a database locked with [`db.fsyncLock()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/db.fsyncLock/#mongodb-method-db.fsyncLock).
db.getCollection() Returns a collection or view object. Used to access collections with names that are not valid in [`mongosh`](https://www.mongodb.com/docs/mongodb-shell/#mongodb-binary-bin.mongosh).
db.getCollectionInfos() Returns collection information for all collections and views in the current database.
db.getCollectionNames() Lists all collections and views in the current database.
db.getLogComponents() Returns the log message verbosity levels.
db.getMongo() Returns the [`Mongo()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/Mongo/#mongodb-method-Mongo) connection object for the current connection.
db.getName() Returns the name of the current database.
db.getProfilingStatus() Returns a document that reflects the current profiling level and the profiling threshold.
db.getReplicationInfo() Returns a document with replication statistics.
db.getSiblingDB() Provides access to the specified database.
db.hello() Returns a document that reports the state of the replica set.
db.help() Displays descriptions of common `db` object methods.
db.hostInfo() Returns a document with information about the system MongoDB runs on. Wraps [`hostInfo`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/hostInfo/#mongodb-dbcommand-dbcmd.hostInfo)
db.killOp() Terminates a specified operation.
db.listCommands() Displays a list of common database commands.
db.logout() *Deprecated*. Ends an authenticated session.
db.printCollectionStats() Prints statistics from every collection. Wraps [`db.collection.stats()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/db.collection.stats/#mongodb-method-db.collection.stats).
db.printReplicationInfo() Prints a report of the status of the replica set from the perspective of the primary.
db.printSecondaryReplicationInfo() Prints the status of the replica set from the perspective of the secondaries.
db.printShardingStatus() Prints a report of the sharding configuration and the chunk ranges.
db.rotateCertificates() Performs online TLS certificate rotation. Wraps [`rotateCertificates`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/rotateCertificates/#mongodb-dbcommand-dbcmd.rotateCertificates).
db.runCommand() Runs a [database command](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/#std-label-database-commands).
db.serverBuildInfo() Returns a document that displays the compilation parameters for the [`mongod`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/program/mongod/#mongodb-binary-bin.mongod) instance. Wraps [`buildInfo`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/buildInfo/#mongodb-dbcommand-dbcmd.buildInfo).
db.serverCmdLineOpts() Returns a document with information about the runtime used to start the MongoDB instance. Wraps [`getCmdLineOpts`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/getCmdLineOpts/#mongodb-dbcommand-dbcmd.getCmdLineOpts).
db.serverStatus() Returns a document that provides an overview of the state of the database process.
db.setLogLevel() Sets a single log message verbosity level.
db.setProfilingLevel() Modifies the current level of database profiling.
db.shutdownServer() Shuts down the current [`mongod`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/program/mongod/#mongodb-binary-bin.mongod) or [`mongos`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/program/mongos/#mongodb-binary-bin.mongos) process cleanly and safely.
db.stats() Returns a document that reports on the state of the current database.
db.version() Returns the version of the [`mongod`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/program/mongod/#mongodb-binary-bin.mongod) instance.
db.watch() Opens a [change stream cursor](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/changeStreams/#std-label-changeStreams) for a database to report on all its non-`system` collections. Cannot be opened on the `admin`, `local` or `config` databases.
db.collection.getPlanCache() Returns an interface to access the query plan cache object and associated PlanCache methods for a collection.
PlanCache.clear() Clears all the cached query plans for a collection. Accessible through the plan cache object of a specific collection, i.e. `db.collection.getPlanCache().clear()`.
PlanCache.clearPlansByQuery() Clears the cached query plans for the specified [plan cache query shape](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-plan-cache-query-shape). Accessible through the plan cache object of a specific collection, i.e. `db.collection.getPlanCache().clearPlansByQuery()`
PlanCache.help() Displays the methods available for a collection's query plan cache. Accessible through the plan cache object of a specific collection, i.e. `db.collection.getPlanCache().help()`.
PlanCache.list() Returns the plan cache information for a collection. Accessible through the plan cache object of a specific collection, i.e. `db.collection.getPlanCache().list()`.
db.collection.initializeOrderedBulkOp() Initializes a [`Bulk()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/Bulk/#mongodb-method-Bulk) operations builder for an ordered list of operations.
db.collection.initializeUnorderedBulkOp() Initializes a [`Bulk()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/Bulk/#mongodb-method-Bulk) operations builder for an unordered list of operations.
Mongo.bulkWrite() Executes bulk write operations on multiple namespaces.
Bulk() Bulk operations builder.
Bulk.execute() Executes a list of operations in bulk.
Bulk.find() Specifies the query condition for an update or a remove operation.
Bulk.find.arrayFilters() Specifies the filters that determine which elements of an array to update for an `update` or `updateOne` operation.
Bulk.find.collation() Specifies the [collation](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/collation/#std-label-collation) for the query condition.
Bulk.find.delete() Adds a multiple document delete operation to a list of operations.
Bulk.find.deleteOne() Adds a single document delete operation to a list of operations.
Bulk.find.hint() Specifies the index to use for the update/replace operation.
Bulk.find.remove() An alias for `Bulk.find.delete()`.
Bulk.find.removeOne() An alias for `Bulk.find.deleteOne()`.
Bulk.find.replaceOne() Adds a single document replacement operation to a list of operations.
Bulk.find.updateOne() Adds a single document update operation to a list of operations.
Bulk.find.update() Adds a `multi` update operation to a list of operations.
Bulk.find.upsert() Specifies `upsert: true` for an update operation.
Bulk.getOperations() Returns an array of write operations executed in the [`Bulk()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/Bulk/#mongodb-method-Bulk) operations object.
Bulk.insert() Adds an insert operation to a list of operations.
Bulk.toJSON() Returns a JSON document that contains the number of operations and batches in the [`Bulk()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/Bulk/#mongodb-method-Bulk) operations object.
Bulk.toString() Returns the [`Bulk.toJSON()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/Bulk.tojson/#mongodb-method-Bulk.toJSON) results as a string.
db.auth() Authenticates a user to a database.
db.changeUserPassword() Changes an existing user's password.
db.createUser() Creates a new user.
db.dropUser() Removes a single user.
db.dropAllUsers() Deletes all users associated with a database.
db.getUser() Returns information about the specified user.
db.getUsers() Returns information about all users associated with a database.
db.grantRolesToUser() Grants a role and its privileges to a user.
db.removeUser() Deprecated. Removes a user from a database.
db.revokeRolesFromUser() Removes a role from a user.
db.updateUser() Updates user data.
passwordPrompt() Prompts for the password as an alternative to specifying passwords directly in various [`mongosh`](https://www.mongodb.com/docs/mongodb-shell/#mongodb-binary-bin.mongosh) user authentication/management methods.
db.createRole() Creates a role and specifies its privileges.
db.dropRole() Deletes a user-defined role.
db.dropAllRoles() Deletes all user-defined roles associated with a database.
db.getRole() Returns information for the specified role.
db.getRoles() Returns information for all the user-defined roles in a database.
db.grantPrivilegesToRole() Assigns privileges to a user-defined role.
db.revokePrivilegesFromRole() Removes the specified privileges from a user-defined role.
db.grantRolesToRole() Specifies roles from which a user-defined role inherits privileges.
db.revokeRolesFromRole() Removes inherited roles from a role.
db.updateRole() Updates a user-defined role.
rs.add() Adds a member to a replica set.
rs.addArb() Adds an [arbiter](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-arbiter) to a replica set.
rs.conf() Returns the replica set configuration document.
rs.freeze() Prevents the current member from seeking election as primary for a period of time.
rs.help() Returns basic help text for [replica set](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-replica-set) functions.
rs.initiate() Initializes a new replica set.
rs.printReplicationInfo() Prints a formatted report of the replica set status from the perspective of the primary.
rs.printSecondaryReplicationInfo() Prints a formatted report of the replica set status from the perspective of the secondaries.
rs.reconfig() Re-configures a replica set by applying a new replica set configuration object.
rs.remove() Remove a member from a replica set.
rs.status() Returns a document with information about the state of the replica set.
rs.stepDown() Causes the current [primary](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-primary) to become a secondary which forces an [election](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-election).
rs.syncFrom() Sets the member that this replica set member will sync from, overriding the default sync target selection logic.
convertShardKeyToHashed() Returns the hashed value for the input.
db.checkMetadataConsistency() Checks the cluster or database for inconsistent sharding metadata.
db.collection.checkMetadataConsistency() Checks the collection for inconsistent sharding metadata.
db.collection.getShardLocation() Returns a document containing the shards where the collection is located and whether the collection is sharded.
sh.abortMoveCollection() Stops an in-progress [`moveCollection`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/command/moveCollection/#mongodb-dbcommand-dbcmd.moveCollection) operation.
sh.abortReshardCollection() Aborts a [resharding operation](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/sharding-reshard-a-collection/#std-label-sharding-resharding).
sh.addShard() Adds a [shard](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-shard) to a sharded cluster.
sh.addShardTag() This method aliases to [`sh.addShardToZone()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/sh.addShardToZone/#mongodb-method-sh.addShardToZone).
sh.addShardToZone() Associates a shard to a zone. Supports configuring [zones](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/zone-sharding/#std-label-zone-sharding) in sharded clusters.
sh.addTagRange() This method aliases to [`sh.updateZoneKeyRange()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/sh.updateZoneKeyRange/#mongodb-method-sh.updateZoneKeyRange).
sh.balancerCollectionStatus() Returns information on whether the chunks of a sharded collection are balanced.
sh.checkMetadataConsistency() Checks the cluster for inconsistent sharding metadata.
sh.commitReshardCollection() Forces a [resharding operation](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/sharding-reshard-a-collection/#std-label-sharding-resharding) to block writes and complete.
sh.disableAutoMerger() Disables automatic [chunk](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-chunk) merges for a [namespace](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-namespace).
sh.disableAutoSplit() Disables auto-splitting for the sharded cluster.
sh.disableBalancing() Disable balancing on a single collection in a sharded database. Does not affect balancing of other collections in a sharded cluster.
sh.disableMigrations() Disables chunk migrations for a specific collection in a sharded cluster.
sh.enableAutoMerger() Enables automatic [chunk](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-chunk) merges for a [namespace](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-namespace).
sh.enableAutoSplit() Enables auto-splitting for the sharded cluster.
sh.enableBalancing() Activates the sharded collection balancer process if previously disabled using [`sh.disableBalancing()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/sh.disableBalancing/#mongodb-method-sh.disableBalancing).
sh.enableMigrations() Enables chunk migrations for a specific collection in a sharded cluster that were previously disabled using [`sh.disableMigrations()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/sh.disableMigrations/#mongodb-method-sh.disableMigrations).
sh.enableSharding() Creates a database.
sh.getBalancerState() Returns a boolean to report if the [balancer](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-balancer) is currently enabled.
sh.getShardedDataDistribution() Returns data distribution information for sharded collections. `sh.getShardedDataDistribution()` is a shell helper method for the [`$shardedDataDistribution`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/operator/aggregation/shardedDataDistribution/#mongodb-pipeline-pipe.-shardedDataDistribution) aggregation pipeline stage.
sh.help() Returns help text for the `sh` methods.
sh.isBalancerRunning() Returns a document describing the status of the balancer.
sh.isConfigShardEnabled() Returns whether a cluster has a [config shard](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/config-shard/#std-label-config-shard-concept). If it does, `sh.isConfigShardEnabled()` also returns host and tag information.
sh.listShards() Returns an array of documents describing the shards in a sharded cluster.
sh.moveChunk() Migrates a [chunk](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-chunk) in a [sharded cluster](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-sharded-cluster).
sh.moveCollection() Moves a single unsharded collection to a different shard.
sh.moveRange() Move ranges between shards.
sh.removeRangeFromZone() Removes an association between a range of shard keys and a zone. Supports configuring [zones](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/zone-sharding/#std-label-zone-sharding) in sharded clusters.
sh.removeShardTag() This method aliases to [`sh.removeShardFromZone()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/sh.removeShardFromZone/#mongodb-method-sh.removeShardFromZone).
sh.removeShardFromZone() Removes the association between a shard and a zone. Use to manage [zone sharding](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/zone-sharding/#std-label-zone-sharding).
sh.removeTagRange() This method aliases to [`sh.removeRangeFromZone()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/sh.removeRangeFromZone/#mongodb-method-sh.removeRangeFromZone).
sh.reshardCollection() Initiates a [resharding operation](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/sharding-reshard-a-collection/#std-label-sharding-resharding) to change the shard key for a collection, changing the distribution of your data.
sh.setBalancerState() Enables or disables the [balancer](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-balancer) which migrates [chunks](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-chunk) between [shards](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-shard).
sh.shardAndDistributeCollection() Shards a collection and immediately redistributes the data using the provided [shard key](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-shard-key).
sh.shardCollection() Enables sharding for a collection.
sh.splitAt() Divides an existing [chunk](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-chunk) into two chunks using a specific value of the [shard key](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-shard-key) as the dividing point.
sh.splitFind() Divides an existing [chunk](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-chunk) that contains a document matching a query into two approximately equal chunks.
sh.startAutoMerger() Enables the [AutoMerger](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/automerger-concept/#std-label-automerger-concept).
sh.startBalancer() Enables the [balancer](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-balancer) and waits for balancing to start.
sh.status() Reports on the status of a [sharded cluster](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-sharded-cluster), as [`db.printShardingStatus()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/db.printShardingStatus/#mongodb-method-db.printShardingStatus).
sh.stopAutoMerger() Disables the [AutoMerger](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/automerger-concept/#std-label-automerger-concept).
sh.stopBalancer() Disables the [balancer](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-balancer) and waits for any in progress balancing rounds to complete.
sh.unshardCollection() Unshards an existing sharded collection and moves the collection data onto a single shard. When you unshard a collection, the collection cannot be partitioned across multiple [shards](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-shard) and the [shard key](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-shard-key) is removed.
sh.updateZoneKeyRange() Associates a range of shard keys to a zone. Supports configuring [zones](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/core/zone-sharding/#std-label-zone-sharding) in sharded clusters.
sh.waitForBalancer() Internal. Waits for the balancer state to change.
sh.waitForBalancerOff() Internal. Waits until the balancer stops running.
sh.waitForPingChange() Internal. Waits for a change in ping state from one of the [`mongos`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/program/mongos/#mongodb-binary-bin.mongos) in the sharded cluster.
Binary.createFromBase64() Creates a binary object from a base64 value.
Binary.createFromHexString() Creates a binary object from a hexadecimal value.
BinData() Returns a [binary data object](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/bson-types/#std-label-document-bson-type-binary-data).
BulkWriteResult() Wrapper around the result set from [`Bulk.execute()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/Bulk.execute/#mongodb-method-Bulk.execute).
Date() Creates a date object. By default creates a date object including the current date.
HexData() Returns a [binary data object](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/bson-types/#std-label-document-bson-type-binary-data).
ObjectId() Returns an [ObjectId](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-ObjectId).
ObjectId.createFromBase64() Creates an [ObjectId](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-ObjectId) from a base64 value.
ObjectId.createFromHexString() Creates an [ObjectId](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-ObjectId) from a hexadecimal value.
ObjectId.getTimestamp() Returns the timestamp portion of an [ObjectId](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-ObjectId).
ObjectId.toString() Displays the string representation of an [ObjectId](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-ObjectId).
UID()](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/UUID/) Converts a 32-byte hexadecimal string to the UUID BSON subtype.
WriteResult() Wrapper around the result set from write methods.
onnect()](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/connect/) Connects to a MongoDB instance and to a specified database on that instance.
Mongo() Creates a new connection object.
Mongo.getDB() Returns a database object.
Mongo.getReadPrefMode() Returns the current read preference mode for the MongoDB connection.
Mongo.getReadPrefTagSet() Returns the read preference tag set for the MongoDB connection.
Mongo.setCausalConsistency() Enables or disables causal consistency on the connection object.
Mongo.setReadPref() Sets the [read preference](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/glossary/#std-term-read-preference) for the MongoDB connection.
Mongo.startSession() Starts a session on the connection object.
Mongo.watch() Opens a [change stream cursor](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/changeStreams/#std-label-changeStreams) for a deployment to report on all its non-`system` collections across all its databases, excluding the internal `admin`, `local`, and `config` databases.
Session() The session object.
SessionOptions() The options object for the session.
getKeyVault() Returns the key vault object for the current MongoDB connection.
KeyVault.createKey()[`KeyVault.createDataKey()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/KeyVault.createDataKey/#mongodb-method-KeyVault.createDataKey) Creates a data encryption key for use with Client-Side Field Level Encryption.
KeyVault.deleteKey() Deletes the specified data encryption key from the key vault.
KeyVault.getKey() Retrieves the specified data encryption key from the key vault.
KeyVault.getKeys() Retrieves all keys in the key vault.
KeyVault.addKeyAlternateName()[`KeyVault.addKeyAltName()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/KeyVault.addKeyName/#mongodb-method-KeyVault.addKeyAltName) Associates a key alternative name to the specified data encryption key.
KeyVault.removeKeyAlternateName()[`KeyVault.removeKeyAltName()`](https://mongodbcom-cdn.staging.corp.mongodb.com/docs/reference/method/KeyVault.removeKeyAltName/#mongodb-method-KeyVault.removeKeyAltName) Removes a key alternative name from the specified data encryption key.
KeyVault.getKeyByAltName() Retrieves keys with the specified key alternative name.
KeyVault.rewrapManyDataKey() Decrypts multiple data keys and re-encrypts them with a new master key.
getClientEncryption() Returns the client encryption object for supporting explicit encryption/decryption of fields.
ClientEncryption.createEncryptedCollection() Creates a collection with encrypted fields.
ClientEncryption.encrypt() Encrypts a field using a specified data encryption key and encryption algorithm.
ClientEncryption.encryptExpression() Encrypts a query expression using a specified data encryption key and encryption options.
ClientEncryption.decrypt()
```
