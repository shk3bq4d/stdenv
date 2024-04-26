
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
```
