http://grokconstructor.appspot.com/do/constructionstep
\A\[%{BASE10NUM}m%{SYSLOGBASE2} \[%{SYSLOGPROG}] %{SYSLOGPROG}
\A\[%{BASE10NUM}m%{SYSLOGBASE2} \[%{SYSLOGPROG}] %{SYSLOGPROG} -> %{NOTSPACE}%{SPACE}%{NOTSPACE}%{SPACE}%{GREEDYDATA}
\A\[%{BASE10NUM}m%{TIMESTAMP_ISO8601} %{TZ} \A\[%{BASE10NUM}m%{SYSLOGBASE2} \[%{SYSLOGPROG}] %{SYSLOGPROG} -> %{NOTSPACE} %{NOTSPACE} %{GREEDYDATA}
\\A\\[%{BASE10NUM}m%{TIMESTAMP_ISO8601:app_timestamp} %{TZ:app_timezone} \\[%{SYSLOGPROG:app_module}] %{SYSLOGPROG:app_function} -> %{NOTSPACE:app_loglevel} %{NOTSPACE} %{GREEDYDATA:app_message}

Bandwidth utilization is %{BASE10NUM:bandwith_utilization} %{DATA:bandwith_unit}, exceeded %{BASE10NUM:bandwith_percentage}% of Licensed %{BASE10NUM:bandwith_licensed} %{DATA:bandwith_licensed_unit}$
%{HOST:f5_host} %{NOTSPACE:f5_uw}: %{NOTSPACE}: Bandwidth utilization is %{NUMBER:f5_bandwidth_used;int} Mbps, exceeded %{NUMBER:f5_bandwidth_limit_pct;int}% of Licensed %{NUMBER:f5_bandwidth_limit_abs;int} Mbps

2018-07-03 09:25:21 +0000 [info]: #0 [filter_kube_metadata] stats - namespace_cache_size: 4, pod_cache_size: 6, namespace_cache_api_updates: 737, pod_cache_api_updates: 737, id_cache_miss: 737


# http://docs.graylog.org/en/2.4/pages/extractors.html#using-grok-patterns-to-extract-data
Grok directly supports converting field values by adding ;datatype at the end of the pattern, like:
The currently supported data types, and their corresponding ranges and values, are:
Type     Range                Example
byte     -128 ... 127         %{NUMBER:fieldname;byte}
short    -32768 ... 32767     %{NUMBER:fieldname;short}
int      -2^31 ... 2^31 -1    %{NUMBER:fieldname;int}
long     -2^63 ... 2^63 -1    %{NUMBER:fieldname;long}
float    32-bit IEEE 754      %{NUMBER:fieldname;float}
double   64-bit IEEE 754      %{NUMBER:fieldname;double}
boolean  true, false          %{DATA:fieldname;boolean}
string   Any UTF-8 string     %{DATA:fieldname;string}
date     See SimpleDateFormat %{DATA:timestamp;date;dd/MMM/yyyy:HH:mm:ss Z}
datetime Alias for date


# date nanoseconds
%{TIMESTAMP_ISO8601:timestamp;date;yyyy-MM-dd'T'HH:mm:ss.SSSSSS}\d{3}

# regexp in grok
(?<param1>.*?)
