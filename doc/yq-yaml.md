sudo snap install yq
http://mikefarah.github.io/yq/
http://mikefarah.github.io/yq/read/

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


| yq e -P # json to yaml

yq e '.azure_sf_domains[]' - # Cannot index array with '*'

yq e -i '.bip2 = "hehe"'   bip.yml # write, edit in place an existing and non-empty document
yq e -n '.bip2 = "hehe"' > bip.yml # write, edit with empty or non-existing document
```
