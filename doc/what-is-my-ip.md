https://www.google.ch/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=what+is+my+ip

curl -s https://4.ifcfg.me/
curl https://diagnostic.opendns.com/myip
curl http://canhazip.com
curl -s http://whatismyip.akamai.com/
dig +short myip.opendns.com @resolver1.opendns.com
nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4
echo close | ftp 4.ifcfg.me | awk '{print $4; exit}'

curl -s --resolve whatismyip.akamai.com:80:77.109.138.83 http://whatismyip.akamai.com/
