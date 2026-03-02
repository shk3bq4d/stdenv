```sh
tail -f /var/log/squid/access.log | perl -p -e 's/^([0-9]*)/"[".localtime($1)."]"/e'

SALT=mysecretphrase perl -MDigest::SHA=sha256_hex -pe '
  BEGIN { $salt = $ENV{SALT} // "default_salt" }
  s/^(\s*[^:]*(?:password|secret|token|endpoint)[^:]*\s*:\s*)(.+)$/$1 . sha256_hex($salt . $2)/ei
' -
```
