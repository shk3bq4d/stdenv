https://stedolan.github.io/jq/manual/#Advancedfeatures
```sh
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

msg: "{{ out.json['values'] | list | json_query('[*].{a:name,b:project.key}') | to_nice_yaml }}"

kgcm -A -o json | jq -r '.items[] | select(.metadata.name=="server-mysql-password") | .data["MYSQL-PASSWORD"]'


[.[] | select(test("\\."))] # filter array of string by a regular expression regex

cat uat.json| jq '[.resources[]| select(.type == "random_id") ] | length' # count
terraform state pull | jq '.resources[]| select(.type == "azurerm_virtual_machine") | .instances[].attributes.name'
terraform state pull | jq '.resources[]| select(.type == "okta_user" and .name == "auth_profile").instances[].index_key'

```
```sh
az acr list -o json |
  jq -r '.[] | .loginServer + " " + .name + " " + .resourceGroup + " " + .id' |
  while read server name rg id; do
    subscription=$(cut -d / -f3 <<< "$id")
    echo "============="
    echo "server: $server"
    echo "name: $name"
    echo "rg: $rg"
    echo "id: $id"
  done
```

```bash
curl -s http://omahaproxy.appspot.com/all.json | jq -r '.[] | select(.os=="win") | .versions[] | select(.channel=="stable") | .current_version' # chrome version

cat ~/tmp/bip.json | jq -r  '[ .resources[]| select(.type == "azuread_service_principal") | .instances[] | .attributes.display_name == "my_name" ] | index(true)'                                                                                                                            # retrieves the (first) index of elements that match a condition within a list, https://coderedirect.com/questions/337575/getting-the-object-array-index-in-jq
cat ~/tmp/bip.json | jq -r '([ .resources[]| select(.type == "azuread_service_principal") | .instances[] | .attributes.display_name == "my_name" ] | index(true)) as $myindex | .resources[]| select(.type == "azuread_service_principal") | .instances[$myindex].attributes.application_id'  retrieves the (first) index of elements that match a condition within a list, https://coderedirect.com/questions/337575/getting-the-object-array-index-in-jq, intermediary variables

jq -R -s '.' < FILE # escape FILE as json string
```
