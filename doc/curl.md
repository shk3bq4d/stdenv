```sh
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
curl --data "name=curl" --data "tool=cmdline" https://example.com # POST is implicit, content-type: application/x-www-form-urlencoded is implicit
curl  -d    "name=curl"  -d    "tool=cmdline" https://example.com # POST is implicit, content-type: application/x-www-form-urlencoded is implicit
curl -H "Content-Type: application/json"     --data-raw '{"key1":"value"}' # raw json
curl -H "Content-Type: application/json"     --data-binary '{"key1":"value"}' # raw json --data-raw not in centos. Beware that data-binary has special handling of @
curl -H "Content-Type: application/json"     --data-binary @filename.json
curl -H "Content-Type: multipart/form-data;" --form "key1=val1"        # raw form
curl -T filename.txt # PUT --upload-file
curl --upload-file filename.txt # PUT --upload-file
curl -v # debug verbose see certificate, request headers, response headers
openssl s_client -connect {HOSTNAME}:{PORT} -showcerts # certificate save as file
UA="Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
curl -A "$UA" # user-agent useragent
curl --user-agent "$UA" # useragent

curl -s -o './#1.yaml' 'https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/examples/helloWorld/{configMap,deployment,kustomization,service}.yaml' # multidownload

curl --resolve backoffice-ks.fabric-ci-74.hehee.k8s.haha.com:443:10.0.2.15 https://backoffice-ks.fabric-ci-74.hehe.k8s.haha.com # SNI cheat, custom name DNS resolution
curl -D - -s -o /dev/null # only response headers
command ssh myhost curl -s https://download.through/other/machine.html | tee machine.html > /dev/null

curl -s -o /dev/null -w "%{http_code}" # print only http response status code

curl -c store-cookies-here.txt -b read-cookies-there.txt https://example
.com

https_proxy == 'socks5h://127.0.0.1:29842' # httpproxy http_proxy DNS gets resolved on proxy
https_proxy ==  'socks5://127.0.0.1:29842' # httpproxy http_proxy DNS gets resolved locally

# curl: (35) error:0A000152:SSL routines::unsafe legacy renegotiation disabled
## on ubuntu 22.04
sed -imybackup -r -e '/^\[system_default_sect\]/a Options = UnsafeLegacyRenegotiation' /etc/ssl/openssl.cnf

curl -k                # SSL certificates validation
curl --insecure # -k     SSL certificates validation
curl --cert FILEPATH   # SSL certificates validation

curl --output FILEPATH url # save document filename filepath
curl -O FILEPATH  url      # save document filename filepath
```

