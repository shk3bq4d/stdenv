JMX enabled by default
Using config: /etc/zookeeper/conf/zoo.cfg
ZooKeeper data directory is missing at /var/lib/zookeeper fix the path or run initialize
yum update -y && service zookeeper-server init && puppet agent -td


ZooKeeper Commands: The Four Letter Words
ZooKeeper responds to a small set of commands. Each command is composed of four letters. You issue the commands to ZooKeeper via telnet or nc, at the client port.
dump Lists the outstanding sessions and ephemeral nodes. This only works on the leader.
envi Print details about serving environment
kill Shuts down the server. This must be issued from the machine the ZooKeeper server is running on.
reqs List outstanding requests
ruok Tests if server is running in a non-error state. The server will respond with imok if it is running. Otherwise it will not respond at all.
srst Reset statistics returned by stat command.
stat Lists statistics about performance and connected clients.
$ echo ruok | nc 127.0.0.1 5111
imok
echo envi | nc jzookeeper 5111


conf New in 3.3.0: Print details about serving configuration.
cons New in 3.3.0: List full connection/session details for all clients connected to this server. Includes information on numbers of packets received/sent, session id, operation latencies, last operation performed, etc...
crst New in 3.3.0: Reset connection/session statistics for all connections.
dump Lists the outstanding sessions and ephemeral nodes. This only works on the leader.
envi Print details about serving environment
ruok Tests if server is running in a non-error state. The server will respond with imok if it is running. Otherwise it will not respond at all.  A response of "imok" does not necessarily indicate that the server has joined the quorum, just that the server process is active and bound to the specified client port. Use "stat" for details on state wrt quorum and client connection information.
srst Reset server statistics.
srvr New in 3.3.0: Lists full details for the server.
stat Lists brief details for the server and connected clients.
wchs New in 3.3.0: Lists brief information on watches for the server.
wchc New in 3.3.0: Lists detailed information on watches for the server, by session. This outputs a list of sessions(connections) with associated watches (paths). Note, depending on the number of watches this operation may be expensive (ie impact server performance), use it carefully.
dirs New in 3.5.1: Shows the total size of snapshot and log files in bytes
wchp New in 3.3.0: Lists detailed information on watches for the server, by path. This outputs a list of paths (znodes) with associated sessions. Note, depending on the number of watches this operation may be expensive (ie impact server performance), use it carefully.
mntr New in 3.4.0: Outputs a list of variables that could be used for monitoring the health of the cluster.
$ echo mntr | nc localhost 2185

              zk_version  3.4.0
              zk_avg_latency  0
              zk_max_latency  0
              zk_min_latency  0
              zk_packets_received 70
              zk_packets_sent 69
              zk_outstanding_requests 0
              zk_server_state leader
              zk_znode_count   4
              zk_watch_count  0
              zk_ephemerals_count 0
              zk_approximate_data_size    27
              zk_followers    4                   - only exposed by the Leader
              zk_synced_followers 4               - only exposed by the Leader
              zk_pending_syncs    0               - only exposed by the Leader
              zk_open_file_descriptor_count 23    - only available on Unix platforms
              zk_max_file_descriptor_count 1024   - only available on Unix platforms
              
The output is compatible with java properties format and the content may change over time (new keys added). Your scripts should expect changes.

ATTENTION: Some of the keys are platform specific and some of the keys are only exported by the Leader.

The output contains multiple lines with the following format:

key \t value
isro New in 3.4.0: Tests if server is running in read-only mode. The server will respond with "ro" if in read-only mode or "rw" if not in read-only mode.
gtmk Gets the current trace mask as a 64-bit signed long value in decimal format. See stmk for an explanation of the possible values.
stmk Sets the current trace mask. The trace mask is 64 bits, where each bit enables or disables a specific category of trace logging on the server. Log4J must be configured to enable TRACE level first in order to see trace logging messages. The bits of the trace mask correspond to the following trace logging categories.

Trace Mask Bit Values
0b0000000000	Unused, reserved for future use.
0b0000000010	Logs client requests, excluding ping requests.
0b0000000100	Unused, reserved for future use.
0b0000001000	Logs client ping requests.
0b0000010000	Logs packets received from the quorum peer that is the current leader, excluding ping requests.
0b0000100000	Logs addition, removal and validation of client sessions.
0b0001000000	Logs delivery of watch events to client sessions.
0b0010000000	Logs ping packets received from the quorum peer that is the current leader.
0b0100000000	Unused, reserved for future use.
0b1000000000	Unused, reserved for future use.
All remaining bits in the 64-bit value are unused and reserved for future use. Multiple trace logging categories are specified by calculating the bitwise OR of the documented values. The default trace mask is 0b0100110010. Thus, by default, trace logging includes client requests, packets received from the leader and sessions.

To set a different trace mask, send a request containing the stmk four-letter word followed by the trace mask represented as a 64-bit signed long value. This example uses the Perl pack function to construct a trace mask that enables all trace logging categories described above and convert it to a 64-bit signed long value with big-endian byte order. The result is appended to stmk and sent to the server using netcat. The server responds with the new trace mask in decimal format.

$ perl -e "print 'stmk', pack('q>', 0b0011111010)" | nc localhost 2181
250

/usr/jails/jzookeeper/usr/local/bin/zkCli.sh
/usr/local/bin/zkCli.sh
ssh_jail.sh jzookeeper /usr/local/bin/zkCli.sh
ls /
get /neato/secret
ssh_jail.sh jzookeeper /usr/local/bin/zkCli.sh get /neato/secret
