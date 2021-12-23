https://jmespath.org/
https://jmespath.org/tutorial.html#functions
# https://jmespath.org/specification.html#builtin-functions
## Built-in Functions
* abs
* avg
* contains
* ceil
* ends_with
* floor
* join
* keys
* length
* map
* max
* max_by
* merge
* min
* min_by
* not_null
* reverse
* sort
* sort_by
* starts_with
* sum
* to_array
* to_string
* to_number
* type
* values

```bash
msg: "{{ out.json['values'] | list | json_query('[*].{a:name,b:project.key}') | to_nice_yaml }}"
json_query != jq -> https://jmespath.org/specification.html#and-expressions
loop: "{{ domain_definition | json_query('domain.cluster[*].name') }}"
loop: "{{ domain_definition | json_query('domain.server[*].name') }}"
loop: "{{ domain_definition | json_query(server_name_cluster1_query) }}"
msg: "{{ domain_definition | json_query('domain.server[?cluster==`cluster1`].port') | join(', ') }}"
loop: "{{ domain_definition | json_query('domain.server[?cluster==''cluster1''].port') }}"
loop: "{{ domain_definition | json_query(server_name_cluster1_query) }}"
{{ ansible_mounts | map(attribute='mount') | join(',') }} # json_query
msg: "{{ pvs.stdout | from_json | json_query('report[0].pv[*].pv_name') }}"
```
