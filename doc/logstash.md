https://www.elastic.co/guide/en/logstash/current/plugins-inputs-tcp.html#plugins-inputs-tcp-ssl_extra_chain_certs

 echo "coucou $(hostname -f)" | logger -P 10514 -n t-infra-logstash-003.dev.ks.local --tcp # doesn't seem to work, although looks almost good to me. I went the rsyslog-server smart class parameter (via puppet) way.

