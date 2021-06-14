# /* ex: set cursorcolumn fenc=utf-8 expandtab ts=2 sw=2 : */
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

# https://www.elastic.co/guide/en/beats/filebeat/current/configuring-output.html
You configure Filebeat to write to a specific output by setting options
in the Outputs section of the filebeat.yml config file. Only a single
output may be defined.

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
# https://www.elastic.co/guide/en/beats/filebeat/current/add-fields.html
# https://www.elastic.co/guide/en/beats/filebeat/current/dissect.html
# https://www.elastic.co/guide/en/beats/filebeat/current/decode-json-fields.html
# https://www.elastic.co/guide/en/beats/filebeat/current/processor-script.html
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
  - drop_fields:
      fields:
        - ecs
        - input
        - host
        - log
        - agent
        - _
```


https://github.com/elastic/beats/ # source code
