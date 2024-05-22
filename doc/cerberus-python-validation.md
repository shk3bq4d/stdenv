
* https://docs.python-cerberus.org/schemas.html
* https://docs.python-cerberus.org/validation-rules.html#schema-dict


# schema validation schema
* https://docs.python-cerberus.org/api.html#schema-validation-schema
```yaml
allof:
  logical: allof
  type: list
allow_unknown:
  oneof:
  - type: boolean
  - check_with: bulk_schema
    type:
    - dict
    - string
allowed:
  type: container
anyof:
  logical: anyof
  type: list
check_with:
  oneof:
  - type: callable
  - schema:
      oneof:
      - type: callable
      - allowed: []
        type: string
    type: list
  - allowed: []
    type: string
coerce:
  oneof:
  - type: callable
  - schema:
      oneof:
      - type: callable
      - allowed: []
        type: string
    type: list
  - allowed: []
    type: string
contains:
  empty: false
default:
  nullable: true
default_setter:
  oneof:
  - type: callable
  - allowed: []
    type: string
dependencies:
  check_with: dependencies
  type:
  - dict
  - hashable
  - list
empty:
  type: boolean
excludes:
  schema:
    type: hashable
  type:
  - hashable
  - list
forbidden:
  type: list
items:
  check_with: items
  type: list
keysrules:
  check_with: bulk_schema
  forbidden:
  - rename
  - rename_handler
  type:
  - dict
  - string
max:
  nullable: false
maxlength:
  type: integer
meta: {}
min:
  nullable: false
minlength:
  type: integer
noneof:
  logical: noneof
  type: list
nullable:
  type: boolean
oneof:
  logical: oneof
  type: list
purge_unknown:
  type: boolean
readonly:
  type: boolean
regex:
  type: string
rename:
  type: hashable
rename_handler:
  oneof:
  - type: callable
  - schema:
      oneof:
      - type: callable
      - allowed: []
        type: string
    type: list
  - allowed: []
    type: string
require_all:
  type: boolean
required:
  type: boolean
schema:
  anyof:
  - check_with: schema
  - check_with: bulk_schema
  type:
  - dict
  - string
type:
  check_with: type
  type:
  - string
  - list
valuesrules:
  check_with: bulk_schema
  forbidden:
  - rename
  - rename_handler
  type:
  - dict
  - string

bip_lvm_logical_volumes_schema:
  root:
    type: dict
    keysrules:
      regex: ^lv[a-z0-9]+$ # debian
#     regex: ^lv[a-z0-9]+$|^LV.*|data|varlv|backup|prodbitbucket|prodnextcloud|blobfusecache # legacy (centos)
      type: string
    valuesrules:
      oneof:
       - schema:
          fs:
            allowed:
              - swap
            type: string
            required: true
          size:
            type: string
            regex: >-
              ^\d+(\.\d+)?[gm]$
            required: true
       - schema:
          fs:
            allowed:
              - ext4
            type: string
            required: true
          group: &group
            oneof:
              - type: string
              - type: integer
          owner: *group
          mode:
            type: string
            regex: ^01?[57][0157][0157]$
          mount:
            type: string
            regex: >-
              ^(/|(/[a-zA-Z0-9_.\-]+)+)$
            required: true
          selevel:
            type: string
          serole:
            type: string
          seuser:
            type: string
          setype:
            type: string
          size:
            type: string
            regex: >-
              ^\d+(\.\d+)?[gm]$
            required: true
          vg:
            type: string

---
# schema validation schema
allof:
  logical: allof
  type: list
allow_unknown:
  oneof:
  - type: boolean
  - check_with: bulk_schema
    type:
    - dict
    - string
allowed:
  type: container
anyof:
  logical: anyof
  type: list
check_with:
  oneof:
  - type: callable
  - schema:
      oneof:
      - type: callable
      - allowed: []
        type: string
    type: list
  - allowed: []
    type: string
coerce:
  oneof:
  - type: callable
  - schema:
      oneof:
      - type: callable
      - allowed: []
        type: string
    type: list
  - allowed: []
    type: string
contains:
  empty: false
default:
  nullable: true
default_setter:
  oneof:
  - type: callable
  - allowed: []
    type: string
dependencies:
  check_with: dependencies
  type:
  - dict
  - hashable
  - list
empty:
  type: boolean
excludes:
  schema:
    type: hashable
  type:
  - hashable
  - list
forbidden:
  type: list
items:
  check_with: items
  type: list
keysrules:
  check_with: bulk_schema
  forbidden:
  - rename
  - rename_handler
  type:
  - dict
  - string
max:
  nullable: false
maxlength:
  type: integer
meta: {}
min:
  nullable: false
minlength:
  type: integer
noneof:
  logical: noneof
  type: list
nullable:
  type: boolean
oneof:
  logical: oneof
  type: list
purge_unknown:
  type: boolean
readonly:
  type: boolean
regex:
  type: string
rename:
  type: hashable
rename_handler:
  oneof:
  - type: callable
  - schema:
      oneof:
      - type: callable
      - allowed: []
        type: string
    type: list
  - allowed: []
    type: string
require_all:
  type: boolean
required:
  type: boolean
schema:
  anyof:
  - check_with: schema
  - check_with: bulk_schema
  type:
  - dict
  - string
type:
  check_with: type
  type:
  - string
  - list
valuesrules:
  check_with: bulk_schema
  forbidden:
  - rename
  - rename_handler
  type:
  - dict
  - string


```
