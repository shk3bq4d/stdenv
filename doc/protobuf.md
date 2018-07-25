
# golang compile
kubectl cp -n $n ~/Downloads/protoc-3.6.0-linux-x86_64/bin/protoc $i:/usr/local/bin/
kubectl exec -n $n $i -- sh -c "cd /go/src/grey.com/gomicro-playground/proto && protoc --go_out=. *.proto"

# random links
* https://github.com/google/protobuf/releases/tag/v3.6.0
* https://github.com/golang/protobuf
