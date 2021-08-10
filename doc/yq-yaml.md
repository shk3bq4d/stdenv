sudo snap install yq
http://mikefarah.github.io/yq/
http://mikefarah.github.io/yq/read/

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
