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
```


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
