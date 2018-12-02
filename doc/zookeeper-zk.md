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


# strace init
13:51:51 6 root@t-infra-zk-idk-1046.dev.ks.local:/home/adminmru
$ grep execve /tmp/strace.out.18*
/tmp/strace.out.18871:13:50:08.982046 execve("/sbin/service", ["service", "zookeeper-server", "init"], [/* 58 vars */]) = 0 <0.000623>
/tmp/strace.out.18873:13:50:09.000634 execve("/sbin/consoletype", ["/sbin/consoletype"], [/* 58 vars */]) = 0 <0.000208>
/tmp/strace.out.18875:13:50:09.022204 execve("/bin/cat", ["cat", "/proc/cmdline"], [/* 58 vars */]) = 0 <0.000400>
/tmp/strace.out.18876:13:50:09.033520 execve("/bin/basename", ["basename", "/sbin/service"], [/* 58 vars */]) = 0 <0.000352>
/tmp/strace.out.18877:13:50:09.043189 execve("/bin/basename", ["basename", "/sbin/service"], [/* 58 vars */]) = 0 <0.000358>
/tmp/strace.out.18878:13:50:09.056810 execve("/bin/env", ["env", "-i", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", "TERM=xterm-256color", "SYSTEMCTL_IGNORE_DEPENDENCIES=", "SYSTEMCTL_SKIP_REDIRECT=", "/etc/init.d/zookeeper-server", "init"], [/* 59 vars */]) = 0 <0.000337>
/tmp/strace.out.18878:13:50:09.060153 execve("/etc/init.d/zookeeper-server", ["/etc/init.d/zookeeper-server", "init"], [/* 4 vars */]) = 0 <0.004033>
/tmp/strace.out.18880:13:50:09.095891 execve("/bin/ls", ["ls", "-rvd", "/usr/java/jdk1.7*"], [/* 7 vars */]) = 0 <0.000261>
/tmp/strace.out.18882:13:50:09.110306 execve("/bin/ls", ["ls", "-rvd", "/usr/java/jre1.7*"], [/* 7 vars */]) = 0 <0.000337>
/tmp/strace.out.18884:13:50:09.128222 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/j2sdk1.7-oracle*"], [/* 7 vars */]) = 0 <0.000419>
/tmp/strace.out.18886:13:50:09.148241 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/j2sdk1.7-oracle/jre*"], [/* 7 vars */]) = 0 <0.000322>
/tmp/strace.out.18888:13:50:09.165879 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/java-7-oracle*"], [/* 7 vars */]) = 0 <0.000337>
/tmp/strace.out.18890:13:50:09.183064 execve("/bin/ls", ["ls", "-rvd", "/usr/java/jdk1.8*"], [/* 7 vars */]) = 0 <0.000297>
/tmp/strace.out.18892:13:50:09.199611 execve("/bin/ls", ["ls", "-rvd", "/usr/java/jre1.8*"], [/* 7 vars */]) = 0 <0.000306>
/tmp/strace.out.18894:13:50:09.215880 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/j2sdk1.8-oracle*"], [/* 7 vars */]) = 0 <0.000298>
/tmp/strace.out.18896:13:50:09.231488 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/j2sdk1.8-oracle/jre*"], [/* 7 vars */]) = 0 <0.000273>
/tmp/strace.out.18898:13:50:09.246610 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/java-8-oracle*"], [/* 7 vars */]) = 0 <0.000278>
/tmp/strace.out.18900:13:50:09.261212 execve("/bin/ls", ["ls", "-rvd", "/Library/Java/Home*"], [/* 7 vars */]) = 0 <0.000310>
/tmp/strace.out.18902:13:50:09.275862 execve("/bin/ls", ["ls", "-rvd", "/usr/java/default*"], [/* 7 vars */]) = 0 <0.000266>
/tmp/strace.out.18904:13:50:09.290813 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/default-java*"], [/* 7 vars */]) = 0 <0.000291>
/tmp/strace.out.18906:13:50:09.308083 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/java-openjdk*"], [/* 7 vars */]) = 0 <0.000351>
/tmp/strace.out.18908:13:50:09.325183 execve("/bin/ls", ["ls", "-rvd", "/usr/lib/jvm/jre-openjdk"], [/* 7 vars */]) = 0 <0.000349>
/tmp/strace.out.18909:13:50:09.343769 execve("/bin/install", ["install", "-d", "-m", "0755", "-o", "zookeeper", "-g", "zookeeper", "/var/run/zookeeper/"], [/* 8 vars */]) = 0 <0.000322>
/tmp/strace.out.18911:13:50:09.365694 execve("/bin/cat", ["cat", "/var/run/zookeeper/zookeeper-server.pid"], [/* 8 vars */]) = 0 <0.000332>
/tmp/strace.out.18912:13:50:09.374770 execve("/bin/su", ["su", "-s", "/bin/bash", "zookeeper", "-c", "zookeeper-server-initialize "], [/* 8 vars */]) = 0 <0.000327>
/tmp/strace.out.18913:13:50:09.470301 execve("/bin/bash", ["bash", "-c", "zookeeper-server-initialize "], [/* 13 vars */]) = 0 <0.000543>
/tmp/strace.out.18913:13:50:09.482779 execve("/bin/zookeeper-server-initialize", ["zookeeper-server-initialize"], [/* 13 vars */]) = 0 <0.000422>
/tmp/strace.out.18914:13:50:09.502708 execve("/bin/env", ["env", "CLASSPATH=:/etc/zookeeper/conf:/usr/lib/zookeeper/*:/usr/lib/zookeeper/lib/*", "/usr/lib/zookeeper/bin/zkServer-initialize.sh"], [/* 22 vars */]) = 0 <0.000349>
/tmp/strace.out.18914:13:50:09.505426 execve("/usr/lib/zookeeper/bin/zkServer-initialize.sh", ["/usr/lib/zookeeper/bin/zkServer-initialize.sh"], [/* 22 vars */]) = 0 <0.000416>
/tmp/strace.out.18914:13:50:09.508303 execve("/usr/local/sbin/bash", ["bash", "/usr/lib/zookeeper/bin/zkServer-initialize.sh"], [/* 22 vars */]) = -1 ENOENT (No such file or directory) <0.000030>
/tmp/strace.out.18914:13:50:09.508429 execve("/usr/local/bin/bash", ["bash", "/usr/lib/zookeeper/bin/zkServer-initialize.sh"], [/* 22 vars */]) = -1 ENOENT (No such file or directory) <0.000043>
/tmp/strace.out.18914:13:50:09.508562 execve("/sbin/bash", ["bash", "/usr/lib/zookeeper/bin/zkServer-initialize.sh"], [/* 22 vars */]) = -1 ENOENT (No such file or directory) <0.000028>
/tmp/strace.out.18914:13:50:09.508676 execve("/bin/bash", ["bash", "/usr/lib/zookeeper/bin/zkServer-initialize.sh"], [/* 22 vars */]) = 0 <0.000310>
/tmp/strace.out.18915:13:50:09.525283 execve("/bin/dirname", ["dirname", "/usr/lib/zookeeper/bin/zkServer-initialize.sh"], [/* 22 vars */]) = 0 <0.000343>
/tmp/strace.out.18918:13:50:09.549112 execve("/bin/uname", ["uname"], [/* 22 vars */]) = 0 <0.000317>
/tmp/strace.out.18919:13:50:09.559641 execve("/bin/getopt", ["getopt", "-n", "/usr/lib/zookeeper/bin/zkServer-initialize.sh", "-o", "h", "-l", "help", "-l", "configfile:", "-l", "myid:", "-l", "force", "--"], [/* 22 vars */]) = 0 <0.000337>
/tmp/strace.out.18921:13:50:09.574264 execve("/bin/grep", ["grep", "^[[:space:]]*dataDir", "/etc/zookeeper/conf/zoo.cfg"], [/* 22 vars */]) = 0 <0.000394>
/tmp/strace.out.18922:13:50:09.574192 execve("/bin/sed", ["sed", "-e", "s/.*=//"], [/* 22 vars */]) = 0 <0.000435>
/tmp/strace.out.18924:13:50:09.595770 execve("/bin/grep", ["grep", "^[[:space:]]*dataLogDir", "/etc/zookeeper/conf/zoo.cfg"], [/* 22 vars */]) = 0 <0.000348>
/tmp/strace.out.18925:13:50:09.595559 execve("/bin/sed", ["sed", "-e", "s/.*=//"], [/* 22 vars */]) = 0 <0.000272>
/tmp/strace.out.18926:13:50:09.613170 execve("/bin/rm", ["rm", "-rf", "/var/lib/zookeeper/myid"], [/* 22 vars */]) = 0 <0.000348>
/tmp/strace.out.18927:13:50:09.619705 execve("/bin/rm", ["rm", "-rf", "/var/lib/zookeeper/version-2"], [/* 22 vars */]) = 0 <0.000315>
/tmp/strace.out.18928:13:50:09.627574 execve("/bin/mkdir", ["mkdir", "-p", "/var/lib/zookeeper/version-2"], [/* 22 vars */]) = 0 <0.000334>

13:51:57 7 root@t-infra-zk-idk-1046.dev.ks.local:/home/adminmru
$ strace -s 99999 -ffttTo /tmp/strace.out service zookeeper-server init


2181 # external port
2888 # internal port 1 (node to node)
3888 # internal port 2 (leader election)

