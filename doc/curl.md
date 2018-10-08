# ex: set filetype=sh:
curl -u username
curl -u username:password
curl -X POST
curl -X PUT
curl -X DELETE
curl -X HEAD
curl -X PATCH
curl -L # follow
curl -k # insecure https certificate validation
curl -H "Content-Type: application/json"
curl -H "Content-Type: application/json"     --data-raw '{"key1":"value"}' # raw json
curl -H "Content-Type: application/json"     --data-binary '{"key1":"value"}' # raw json --data-raw not in centos. Beware that data-binary has special handling of @
curl -H "Content-Type: multipart/form-data;" -F "key1=val1"        # raw form
curl -T filename.txt # PUT --upload-file
curl --upload-file filename.txt # PUT --upload-file
curl -v # see certificate, request headers, response headers
openssl s_client -connect {HOSTNAME}:{PORT} -showcerts # certificate save as file
UA="Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
curl -A "$UA"

curl -s -o './#1.yaml' 'https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/examples/helloWorld/{configMap,deployment,kustomization,service}.yaml' # multidownload
