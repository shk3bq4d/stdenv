http://grokconstructor.appspot.com/do/constructionstep
\A\[%{BASE10NUM}m%{SYSLOGBASE2} \[%{SYSLOGPROG}] %{SYSLOGPROG}
\A\[%{BASE10NUM}m%{SYSLOGBASE2} \[%{SYSLOGPROG}] %{SYSLOGPROG} -> %{NOTSPACE}%{SPACE}%{NOTSPACE}%{SPACE}%{GREEDYDATA}
\A\[%{BASE10NUM}m%{TIMESTAMP_ISO8601} %{TZ} \A\[%{BASE10NUM}m%{SYSLOGBASE2} \[%{SYSLOGPROG}] %{SYSLOGPROG} -> %{NOTSPACE} %{NOTSPACE} %{GREEDYDATA}
\\A\\[%{BASE10NUM}m%{TIMESTAMP_ISO8601:app_timestamp} %{TZ:app_timezone} \\[%{SYSLOGPROG:app_module}] %{SYSLOGPROG:app_function} -> %{NOTSPACE:app_loglevel} %{NOTSPACE} %{GREEDYDATA:app_message}

Bandwidth utilization is %{BASE10NUM:bandwith_utilization} %{DATA:bandwith_unit}, exceeded %{BASE10NUM:bandwith_percentage}% of Licensed %{BASE10NUM:bandwith_licensed} %{DATA:bandwith_licensed_unit}$


2018-07-03 09:25:21 +0000 [info]: #0 [filter_kube_metadata] stats - namespace_cache_size: 4, pod_cache_size: 6, namespace_cache_api_updates: 737, pod_cache_api_updates: 737, id_cache_miss: 737
