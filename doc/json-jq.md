curl -s http://localhost:8500/v1/catalog/service/download | jq  -e -r '.[].ServiceEnableTagOverride'
python -m json.tool my_json.json # json prettifyer
python -m json.tool

jq -s -c  'sort_by(.total_size)' /tmp/c.json | jq '.[]' | jq --raw-output '[.created_at, .name, .destroy_path] | @tsv'
jq -r '.modules[0].resources[] | select( .type == "openstack_networking_secgroup_rule_v2") | .primary.id' $TFSTATE
jq -r '.[].ID' $SG
jq -r '.[] | select(.Name | startswith("infra_")) | .ID' $SG
jq -r '.[] | [."Security Group", .ID ] | @csv' $RULES
jq -r '.[] | select(.ID == "'$1'") | .Name' $SG
jq 'map(select(."IP Range"=="0.0.0.0/0"))'


if jq -e ".jsonpath" bip.json >/dev/null; then # --exit-status Sets the exit status of jq to 0 if the last output values was neither fal se nor null, 1 if the last output value was either false or null, or 4  if  no  valid result  was  ever produced. Normally jq exits with 2 if there was any usa ge problem or system error, 3 if there was a jq program compile error, or 0 if the jq program ran.  

jq . bip.json
{
  "hehe": 5
}
jq '.bob = 3' bip.json
{
  "hehe": 5,
  "bob": 3
}
