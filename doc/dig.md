```bash
dig +nocmd +multiline +noall +answer any ateamsystems.com @8.8.8.8 # all records, include TTL
dig +nocmd +multiline +noall +answer A   ateamsystems.com @8.8.8.8 # all records, include TTL
dig TXT _acme-challenge.bip.com

dig   +tcp haha @8.8.8.8 # no UDP
dig +notcp haha @8.8.8.8 #    UDP

dig -x # reverse-dns reverse DNS
```
