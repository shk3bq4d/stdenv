output.file:
  path: "/tmp/filebeat"
  filename: filebeat

output:
  file:
	path: "/tmp/filebeat"
	filename: filebeat
	#rotate_every_kb: 10000
	#number_of_files: 7
	#permissions: 0600

# https://www.elastic.co/guide/en/ecs/current/ecs-field-reference.html

# https://www.elastic.co/guide/en/beats/filebeat/master/rate-limit.html
```yaml
processors:
  - rate_limit:
      limit: "1/s"
  - rename:
      fields:
        - from: "a.g"
          to: "e.d"
      ignore_missing: false
      fail_on_error: true
```
# https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html
# https://www.elastic.co/guide/en/beats/filebeat/current/dissect.html
# processor conditions
https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html#conditions
Conditionsedit
Each condition receives a field to compare. You can specify multiple fields under the same condition by using AND between the fields (for example, field1 AND field2).

For each field, you can specify a simple field name or a nested map, for example dns.question.name.

See Exported fields for a list of all the fields that are exported by Filebeat.

The supported conditions are:

equals
contains
regexp
range
network
has_fields
or
and
not
equals
```yaml
      when:
        contains:
          source: "test"


processors:
  - rename:
      fields:
        - from: "event.code"
          to: "event.squid_code"
      ignore_missing: false
      fail_on_error: true
      when:
        equals:
          event.module: "squid"
- type: log
  processors:
    #values will be under nginx_$name_of_value. Ex, clientip will be nginx_clientip
    - dissect:
        tokenizer: "%{clientip} %{ident} %{auth} [%{@timestamp}] \"%{verb} %{request} HTTP/%{httpversion}\" %{status} %{size} %{referer} %{user_agent}"
        field: "message"
        target_prefix: "nginx_"
        ignore_missing: true
        ignore_failure: true
  paths:
      - /var/log/nginx/error.log
      - /var/log/nginx/access.log

- type: log
  paths:
    - /var/log/impstats
  processors:
    - dissect:
        # Thu Apr 22 08:06:36 2021: action 1:        origin=core.action processed=4 failed=0 suspended=0 suspended.duration=0 resumed=0
        tokenizer: "%{@timestamp}: action %{action}: origin=%{origin} processed=%{processed} failed=%{failed} suspended=%{suspended} suspended.duration=%{suspended_duration} resumed=%{resumed} "
        field: message
        target_prefix: impstat
        ignore_missing: true
        ignore_failure: true

	- dissect:
        tokenizer: "%{test0165465|integer}"
        tokenizer: "%{test0165465|long}"
        tokenizer: "%{test0165465|double}"
        tokenizer: "%{test0165465|float}"
        tokenizer: "%{test0165465|boolean}"
        tokenizer: "%{test0165465|ip}"
        field: message
        target_prefix: ""
        ignore_missing: true
        ignore_failure: true
        overwrite_keys: true # timestamp at least will be overwritten
```


https://github.com/elastic/beats/ # source code
