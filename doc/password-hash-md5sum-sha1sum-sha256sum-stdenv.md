rsZouSDdyLCn1uskRZUETw== # md5 base64 string -> echo rsZouSDdyLCn1uskRZUETw== | base64 -d | xxd -p -c 32 # md5
aec668b920ddc8b0a7d6eb244595044f # md5 hexadecimal string
b97b2b9a21645f8da762435e14a3050605160511 # sha1sum hexadecimal string
a9c1e9686b0ced6d367954ecf14d13541c925cfb570866d4b459eab3dd730228 # sha256sum hexadecimal string


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
$argon2id$

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 24
openssl rand -base64 30
openssl rand -base64 30 | tr '[:upper:]' '[:lower:]' # lowercase
openssl rand -base64 80 | tr -cd '[a-z]' | head -c 32; echo # only lowercase letters
openssl rand -base64 80 | tr -cd '[a-z0-9]' | head -c 30; echo # only lowercase alphanumerics
openssl rand -base64 80 | tr -cd '[a-z0-9]' | sed -r -e 's/(....)/\1 /g' | head -c 29; echo # lowercase alphanumeric group by 4 letters joined by space
openssl rand -base64 80 | tr -cd '[a-z]'    | tr -d '[aqwyz]' | sed -r -e 's/(....)/\1 /g' | head -c 29; echo # lowercase letters, excluding hard to type using various layouts group by 4 letters joined by space
openssl rand -base64 80 | tr -cd '[a-z0-9]' | tr -d '[aqwyz]' | sed -r -e 's/(....)/\1 /g' | head -c 29; echo # lowercase alphanumeric, excluding hard to type using various layouts group by 4 letters joined by space

openssl rand -base64 30 | openssl passwd -6 -stdin
openssl rand -base64 30 | openssl passwd -6 -stdin | xargs -nI@ usermod -p @ zabbix
openssl rand -base64 30 | ./encrypt-string.sh

* cli password manager https://www.passwordstore.org/
