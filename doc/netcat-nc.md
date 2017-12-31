# tunnel
mkfifo /tmp/myfifo
while :; do nc -l -4 25 < /tmp/myfifo | tee -a /tmp/traffic | nc mail.mydomain.local 25 | tee -a /tmp/traffic > /tmp/myfifo; done


# quickly check browser header user agent
nc -l 10000
# then go to http://localhost:10000 

nc 10.36.211.135 22 -l -k #--keep-open
