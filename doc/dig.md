```bash
dig +nocmd +multiline +noall +answer any ateamsystems.com @8.8.8.8 # all records, include TTL
dig +nocmd +multiline +noall +answer A   ateamsystems.com @8.8.8.8 # all records, include TTL
dig TXT _acme-challenge.bip.com

dig -x # reverse-dns reverse DNS
```
