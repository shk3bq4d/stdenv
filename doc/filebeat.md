#  ex: set cursorcolumn fenc=utf-8 expandtab ts=2 sw=2 :
```yaml
output.file:
  path: "/tmp/filebeat"
  filename: filebeat

output:
  file:
    path: "/tmp/filebeat"
    filename: filebeat.log
    #rotate_every_kb: 10000
    #number_of_files: 7
    #permissions: 0600
    codec:
     json: # https://www.elastic.co/guide/en/beats/filebeat/current/configuration-output-codec.html
       pretty: true
#    format: # only one of json or format can be used
#      string: 'path: %{[url.path]} original: %{[url.original]}'
 ```

# https://www.elastic.co/guide/en/beats/filebeat/current/configuring-output.html
You configure Filebeat to write to a specific output by setting options
in the Outputs section of the filebeat.yml config file. Only a single
output may be defined.

# https://www.elastic.co/guide/en/ecs/current/ecs-field-reference.html
https://github.com/elastic/ecs

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
# https://www.elastic.co/guide/en/beats/filebeat/current/add-fields.html
# https://www.elastic.co/guide/en/beats/filebeat/current/dissect.html
# https://www.elastic.co/guide/en/beats/filebeat/current/decode-json-fields.html
# https://www.elastic.co/guide/en/beats/filebeat/current/processor-script.html # javascript js
# https://www.elastic.co/guide/en/beats/filebeat/master/configuration-filebeat-modules.html
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

if.equals.log.file.path:
if.regexp.log.file.path:

* [if doc](https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html)
* [no else if elif](https://discuss.elastic.co/t/beats-processors-else-if/197608)

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
      - script:
          lang: javascript
          id: rx-extract
          source: |
            // ```js
            function process(event) {
              var bH, matcher, key, value;

              // step a) extract regexp successively
              bH = {
                "sub" : /(?:^|\/)subscriptions\/([^/]+)/i,
                "rg"  : /(?:^|\/)resourceGroups\/([^/]+)/i,
                "vm"  : /(?:^|\/)virtualMachines\/([^/]+)/i
              }
              key = "Id";
              value = event.Get(key) || "";
              for (key in bH) {
                matcher = bH[key].exec(value);
                if (matcher)
                { event.Put(key, matcher[1].toLowerCase());
                }
              }

              // step b) enrich with/replace known subscription GUID
              bH = {
                "ba7dcad5-11f6-400a-897c-856f33bb9637": "sfopsb.onmicrosoft.com",
                "0433448c-cf06-421d-ba53-dee879d6087a": "sfops.onmicrosoft.com"
              }
              key = "sub";
              value = event.Get(key) || "";
              if (value && value in bH)
              { event.Put(key, bH[value]);
              }
            }
            // ```
  - script:
      lang: javascript
      id: lowercase
      source: |
        function process(event) {
            var bH = {
              "sub" : /(?:^|\/)subscriptions\/([^/]+)/i,
              "rg"  : /(?:^|\/)resourceGroup\/([^/]+)/i,
              "vm"  : /(?:^|\/)virtualMachines\/([^/]+)/i
            }
            var level = event.Get("message");
            var matcher;
            if(level != null) {
                event.Put("message", level.toString().toLowerCase() + "/");
                for (var b in bH) {
                  matcher = bH[b].exec(level);
                  if (matcher)
                  { event.Put(b, matcher[1]);
                  }

                }
            }
        }
  - dissect: #    /subscriptions/0433448c-cf06-421d-ba53-dee879d6087a/resourceGroups/PROD-AZURECH-RG/providers/Microsoft.Compute/virtualMachines/jira-001/providers/Microsoft.Security/assessments/1195afff-c881-495e-9bc5-1486211ae03f/subassessments/236c6889-bb1f-498b-ccbb-806173c13bc7
      tokenizer: "%{_}/subscriptions/%{subscription}/"
      ignore_failure: true
      overwrite_keys: true
      target_prefix: ""
  - dissect: #    /subscriptions/0433448c-cf06-421d-ba53-dee879d6087a/resourceGroups/PROD-AZURECH-RG/providers/Microsoft.Compute/virtualMachines/jira-001/providers/Microsoft.Security/assessments/1195afff-c881-495e-9bc5-1486211ae03f/subassessments/236c6889-bb1f-498b-ccbb-806173c13bc7
      tokenizer: "%{_}/haha/%{haha}/"
      ignore_failure: true
      overwrite_keys: true
      target_prefix: ""
  - dissect: #    /subscriptions/0433448c-cf06-421d-ba53-dee879d6087a/resourceGroups/PROD-AZURECH-RG/providers/Microsoft.Compute/virtualMachines/jira-001/providers/Microsoft.Security/assessments/1195afff-c881-495e-9bc5-1486211ae03f/subassessments/236c6889-bb1f-498b-ccbb-806173c13bc7
      tokenizer: "%{_}/resourcegroups/%{resourcegroup}/"
      ignore_failure: true
      overwrite_keys: true
      target_prefix: ""
  - dissect: #    /subscriptions/0433448c-cf06-421d-ba53-dee879d6087a/resourceGroups/PROD-AZURECH-RG/providers/Microsoft.Compute/virtualMachines/jira-001/providers/Microsoft.Security/assessments/1195afff-c881-495e-9bc5-1486211ae03f/subassessments/236c6889-bb1f-498b-ccbb-806173c13bc7
      tokenizer: "%{_}/virtualmachines/%{virtualmachine}/"
      ignore_failure: true
      overwrite_keys: true
      target_prefix: ""
  - drop_fields:     # delete remove rm
      fields:        # delete remove rm
      - ecs          # delete remove rm
      - input        # delete remove rm
      - host         # delete remove rm
      - log          # delete remove rm
      - agent        # delete remove rm
      - _            # delete remove rm
```


https://github.com/elastic/beats/ # source code
https://www.elastic.co/downloads/beats/winlogbeat # version
https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.15.2-windows-x86_64.zip


filebeat test config -c /etc/filebeat/filebeat.yml --strict.perms # doesn't seem to verify my module config

- timestamp:
   field: ansible.time # timestamp
   target_field: @timestamp # @timestamp is default, and a such this is optional
   test: # timestamp
     - Dec 31 1999 23:59:59.999 # timestamp
     - Jul 15 2021 13:08:56.040 # timestamp
     - 1663443523.289 # timestamp
   layouts: # timestamp
     - Jan  2 2006 15:04:05.999        # timestamp layout
      # Fri, 24 Nov 2023 07:29:19 +0000
     - Mon, 2 Jan 2006 15:04:05.999 -0700 # timestamp layout
     - Mon Jan  2 2006 15:04:05.999    # timestamp layout
     - Mon Jan 2 2006 15:04:05.999     # timestamp layout
     - '2006-01-02T15:04:05Z'          # timestamp layout
     - '2006-01-02T15:04:05.999Z'      # timestamp layout
     - '2006-01-02T15:04:05.999-07:00' # timestamp layout
     - "2006-01-02 15:04:05,999"       # timestamp layout, if you have nanoseconds, use truncate field
     - "2006-01-02T15:04:05.999"       # timestamp layout, if you have nanoseconds, use truncate field
     - UNIX                            # timestamp layout 1663443523.289
     - UNIX_MS                         # timestamp layout 1663443523289 unix with milliseconds


[filebeat] squid module cannot parse CONNECT request because "extract_page failed": filebeat[3796]: ERROR [processor.javascript] console/console.go:54 extract_page failed for 'eu-v20.events.data.microsoft.com:443' https://github.com/elastic/beats/issues/24260



```yaml
filebeat.inputs:
    - type: log # inputs https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-log.html
      fields_under_root: true # inputs
      fields: # inputs
        stdenv.filebeat.debug: 1 # inputs
      paths: # inputs
        #- /tmp/filebeat-debug/auditd.log
        - /tmp/filebeat-debug/auditd-python-compile.log # inputs

- script: # javascript
    lang: javascript
    id: myjavascript
      source: | # javascript
        // ```js
        function process(event) { # javascript
            event.Tag("javascript");
            event.Get("javascript");
            event.Put("javascript", value);
            event.Rename("javascript", string);
            event.Delete("javascript"); # remove
            event.Cancel();  // Flag the event as cancelled which causes the processor to drop event. javascript
            event.Tag("javascript"); // Append a tag to the tags field if the tag does not already exist. Throws an exception if tags exists and is not a string or a list of strings. javascript
            event.AppendTo("javascript", string);
        } # javascript
        // ```

if.equals.bip.leftover: ''
if.and:
  - equals.bip.leftover: 'if.and'

 - include_fields: # keep fields exclude only subset
      when:
        condition
      fields: ["stdenv.filebeat.debug"] # include_fields exclude keep only subset
```

date -d "2006-01-02 15:04:05" +"%A" # filebeat timestamp reference day of week is Monday

https://dissect-tester.jorgelbg.me/

# missing source field
* https://github.com/Graylog2/graylog2-server/issues/13254
* https://github.com/Graylog2/graylog2-server/pull/13897
* https://www.elastic.co/guide/en/beats/filebeat/7.17/exported-fields-beat-common.html # deprecated

timestamps milliseconds nanoseconds https://github.com/elastic/beats/issues/15871

- add_fields.fields.step.three: youpi     # short
- add_fields.fields.line.line49: 1        # short
- add_fields.fields.line.line50: 1        # short
- add_fields.fields.step.four.youpi2:     # not very good as youpi2 is key whose value is null
- drop_fields:                            # short
    when.equals.nextcloud.userAgent: "--" # short
    fields:    [nextcloud.userAgent]      # short
- if.has_fields.nextcloud.time:           # short apparently works
  if.has_fields.nextcloud:  time          # short apparently works

    - replace: # regexp
        fields: # regexp
          - field: myfield #regexp
            pattern: ^(.)(.)([^x]+)x(\d+)x(\d+)x(\d+)$ # regexp
            replacement: $1 $2 # regexp ( dollar as group back trace)

copy_fields:
  fields: # copy
  - from: copy.from
    to:   copy.to

processor add_cloud_metadata
processor add_cloudfoundry_metadata
processor add_docker_metadata
processor add_fields
processor add_host_metadata
processor add_id
processor add_kubernetes_metadata
processor add_labels
processor add_locale
processor add_network_direction
processor add_nomad_metadata
processor add_observer_metadata
processor add_process_metadata
processor add_tags
processor community_id
processor convert
processor copy_fields
processor decode_base64_field
processor decode_cef
processor decode_csv_fields
processor decode_duration
processor decode_json_fields
processor decode_xml
processor decode_xml_wineventlog
processor decompress_gzip_field
processor detect_mime_type
processor dissect
processor dns
processor drop_event
processor drop_fields
processor extract_array
processor fingerprint
processor include_fields
processor move_fields
processor parse_aws_vpc_flow_log
processor rate_limit
processor registered_domain
processor rename
processor replace
processor script
processor syslog
processor timestamp
processor translate_sid
processor truncate_fields
processor urldecode

kubectl get configmap -n filebeat filebeat-config -o jsonpath="{ .data['filebeat\.yml'] }"
