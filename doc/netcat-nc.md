# tunnel
mkfifo /tmp/myfifo
while :; do nc -l -4 25 < /tmp/myfifo | tee -a /tmp/traffic | nc mail.habon.com 25 | tee -a /tmp/traffic > /tmp/myfifo; done


# quickly check browser header user agent
nc -l 10000
# then go to http://localhost:10000

nc -p 22 -l -k #--keep-open
nc -p 22 -l -s 127.0.0.1 # bind to local source address



echo bip > /dev/tcp/172.18.13.142/1514 # netcat replacement

tnc MYHOST -port MYPORT # powershell windows
