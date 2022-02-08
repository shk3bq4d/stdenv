sudo snap install yq
https://mikefarah.gitbook.io/yq/

```bash
ln -is /snap/yq/current/bin/yq ~/bin/

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

yq e '.contexts[]|select(.name=="mycontext").context.namespace' ~/.kube/config
yq e ".contexts[]| select(.name==((.|parent|parent).current-context)) |.context.namespace" ~/.kube/config
yq e ".current-context, .contexts[]| select(.name==((.|parent|parent).current-context)) |.context.namespace" ~/.kube/config # union
```


