
$apr1$: Apache MD5-based   $apr1$xJZ8QPTb$O93/pwUz9b.YQ5raH88mZ
$1$: MD5-based crypt ('md5crypt')
$2$: Blowfish-based crypt ('bcrypt')
$sha1$: SHA-1-based crypt ('sha1crypt')
$5$: SHA-256-based crypt ('sha256crypt')
$6$: SHA-512-based crypt ('sha512crypt')
$2$  bcrypt - the first revision of BCrypt, which suffers from a minor security flaw and is generally not used anymore.
$2a$  bcrypt - some implementations suffered from rare security flaws, replaced by 2b.
$2y$  bcrypt - format specific to the crypt_blowfish BCrypt implementation, identical to "2b" in all but name.
$2b$  bcrypt - latest revision of the official BCrypt algorithm, current default.

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 24
openssl rand -base64 30

openssl rand -base64 30 | openssl passwd -6 -stdin
openssl rand -base64 30 | openssl passwd -6 -stdin | xargs -nI@ usermod -p @ zabbix
openssl rand -base64 30 | ./encrypt-string.sh
