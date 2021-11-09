
.well-known/acme-challenge
https://acme-staging-v02.api.letsencrypt.org/directory
https://acme-v02.api.letsencrypt.org/directory


# https://letsencrypt.org/certificates/
* a) DST Root CA X3 is the legacy one who expired on September 30th 2021
* b) ISRG Root X1 is the current one, but it may come as an intermediate signed by
  DST Root CA X3 (this is the default behavior, and it apparently works best for
  legacy clients) or a pure self-signed (but may not be installed on legacy
  clients, though it looks cleaner to no longer have the legacy DST Root CA X3 as
  the root CA)
