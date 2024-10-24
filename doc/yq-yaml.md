* https://github.com/mikefarah/yq/issues/462 # list indentation

sudo snap install yq
https://mikefarah.gitbook.io/yq/

```bash
ln -is /snap/yq/current/bin/yq ~/bin/

yq e '.all.hosts += {"hehe":"habon"}' inventory.yml
yq e '.. | select(key == "vmware_new_20210331").hosts += {"hehe":null}' inventory.yml
                yq e '
                  ( del .metadata.annotations."kubectl.kubernetes.io/last-applied-configuration" ) |
                  ( del .metadata.resourceVersion ) |
                  ( del .metadata.selfLink ) |
                  ( del .metadata.uid ) |
                  ( del .metadata.creationTimestamp ) |
                  ( del .metadata.generation ) |
                  ( del .status )
                  ' -i $instance_filename


                if [[ $resource_type == secrets ]]; then
                    yq e '.data.* = "REDACTED"' -i $instance_filename


| yq e -P                         # json to yaml
yq --output-format=json e . $YAML # yaml to json

yq e '.azure_sf_domains[]' - # Cannot index array with '*'

yq e -i '.bip2 = "hehe"'   bip.yml # write, edit in place an existing and non-empty document
yq e -n '.bip2 = "hehe"' > bip.yml # write, edit with empty or non-existing document


yq eval -i 'sortKeys(..)' file1.yml # diff
yq eval -i 'sortKeys(..)' file2.yml # diff
diff file1.yml file2.yml # diff

kubectl get pods -Ao yaml | yq e '.items[]|select(.spec.volumes[].persistentVolumeClaim).spec.volumes[]|select(.persistentVolumeClaim).persistentVolumeClaim' - # kubernetes k8s get all PVCs tied to pods
kubectl get pods -Ao yaml | yq e '.items[]|select(.spec.volumes[].persistentVolumeClaim).metadata|{.namespace:.name}' - # all pods with pvc
kubectl get pods -Ao yaml | yq e '.items[]|select(.spec.volumes[].persistentVolumeClaim).metadata|{.namespace:.name}' - | while IFS=": " read a b; do echo "a=$a b=$b"; done # all pods with pvc bash iteration
kubectl get pods -Ao yaml | yq e '.items[]|select(.spec.volumes[].persistentVolumeClaim).metadata|{.namespace:0,.name:0}|keys()|join(" ")' - | while read namespace name; do echo "namespace=$namespace name=$name"; done # all pods with pvc bash iteration
kubectl get pods -o jsonpath='{range .items[*]}{..metadata.name}{"\n"}{end}'
kgp -Ao=jsonpath='{range .items[*].status.containerStatuses[*]}{.imageID}{"\n"}{end}' | sort -u

yq e '.contexts[]|select(.name=="mycontext").context.namespace' ~/.kube/config
yq e ".contexts[]| select(.name==((.|parent|parent).current-context)) |.context.namespace" ~/.kube/config
yq '._49_jira_filebeat_inputs__to_merge[]|select(.paths[0]|contains("atlassian-jira-security.log")).paths' group_vars/jira.yml
yq e ".current-context, .contexts[]| select(.name==((.|parent|parent).current-context)) |.context.namespace" ~/.kube/config # union

f=corp.yml; _path='.corp_certs__to_merge'; yq e "$_path"'|keys|.[]' $f | while read key; do yq e "$_path""[\"$key\"]" $f > ../../certs/ca/corp/$key; done
```

yq e '.myarray | map_values("")' # list to dict, https://mikefarah.gitbook.io/yq/operators/map


yq '[.spec.containers[],.spec.initContainers[]]|flatten|.[].image' bip.yaml # concatenate list

yq -o json eval-all '[..|select(has("merged_var_name"))]' $(ack -l merged_var_name:)

| explode(.) # resolves anchors, https://mikefarah.gitbook.io/yq/operators/anchor-and-alias-operators

    _yq -r '
        (
        []
        + ([.[].roles[] | select(has("role") | not)] // [])
        + ([.[].roles[] | select(has("role")).role] // [])
        + ([.. | select(has("include_role"))."include_role".name] // [])
        + ([.. | select(has("ansible.builtin.include_role"))."ansible.builtin.include_role".name] // [])
        + ([.. | select(has("import_role"))."import_role".name] // [])
        + ([.. | select(has("ansible.builtin.import_role"))."ansible.builtin.import_role".name] // [])
        ) | explode(.) | unique | sort | join(" ")
        ' "$1" | tr ' ' $'\n'

yq '(... | select(type == "!!seq")) |= sort' # sort list / array recursively, useful for ansible groups comparison
ansible -m debug -a var=groups MYHOST 2>/dev/null | sed -n -e '/groups:/,/PLAY RECAP/ p' | head -n -1 | yq '(... | select(type == "!!seq")) |= sort'
