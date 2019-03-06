curl -s http://localhost:8500/v1/catalog/service/download | jq  -e -r '.[].ServiceEnableTagOverride'
python -m json.tool my_json.json # json prettifyer
python -m json.tool

jq -s -c  'sort_by(.total_size)' /tmp/c.json | jq '.[]' | jq --raw-output '[.created_at, .name, .destroy_path] | @tsv'
jq -r '.modules[0].resources[] | select( .type == "openstack_networking_secgroup_rule_v2") | .primary.id' $TFSTATE
jq -r '.[].ID' $SG
jq -r '.[] | select(.Name | startswith("infra_")) | .ID' $SG
jq -r '.[] | [."Security Group", .ID ] | @csv' $RULES
jq -r '.[] | select(.ID == "'$1'") | .Name' $SG
