https://www.google.ch/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=what+is+my+ip

wget -qO- http://whatismyip.akamai.com/; echo
wget -qO- https://4.ifcfg.me; echo
curl -s https://4.ifcfg.me/
curl https://diagnostic.opendns.com/myip
curl http://canhazip.com
curl -s http://whatismyip.akamai.com/
dig +short myip.opendns.com @resolver1.opendns.com
nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4
echo close | ftp 4.ifcfg.me | awk '{print $4; exit}'

curl -s --resolve whatismyip.akamai.com:80:77.109.138.83 http://whatismyip.akamai.com/

kubectl run -n default curl-pod --rm --stdin --tty --image=curlimages/curl --restart=Never -- curl -sA bip http://whatismyip.akamai.com/; echo


exec 3<>/dev/tcp/whatismyip.akamai.com/80; printf 'GET / HTTP/1.0\r\nHost: whatismyip.akamai.com\r\n\r\n' >&3; cat <&3; echo; exec 3<&-
exec 3<>/dev/tcp/canhazip.com/80; printf 'GET / HTTP/1.0\r\nHost: canhazip.com\r\n\r\n' >&3; cat <&3; exec 3<&-
exec 3<>/dev/udp/resolver1.opendns.com/53; printf '\x12\x34\x01\x00\x00\x01\x00\x00\x00\x00\x00\x00\x04myip\x07opendns\x03com\x00\x00\x01\x00\x01' >&3; timeout 3 dd bs=512 count=1 <&3 2>/dev/null | tail -c 4 | od -An -tu1 | awk -v OFS=. '{$1=$1; print}'; exec 3<&-
exec 3<>/dev/tcp/4.ifcfg.me/21; IFS= read -r -t 5 banner <&3; printf 'QUIT\r\n' >&3; cat <&3; exec 3<&-; printf '%s\n' "${banner%$'\r'}";
exec 3<>/dev/tcp/telnetmyip.com/23; timeout 5 cat <&3 | tr -cd '\11\12\40-\176' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -1; exec 3<&-
