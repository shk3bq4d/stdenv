# ubuntu
save rootCA.pem in /usr/local/share/ca-certificates/ with a .crt extension
sudo update-ca-certificates
systemctl restart docker.service # optional for artifactory
## cert will probably show up in /etc/ssl/certs

#centos6 and 7
yum install ca-certificates                  # Install the ca-certificates package:
update-ca-trust force-enable                 # Enable the dynamic CA configuration feature:
#cp foo.crt /etc/pki/ca-trust/source/anchors/ # Add it as a new file to /etc/pki/ca-trust/source/anchors/:
cd /etc/pki/ca-trust/source/anchors/
cat - > myca.crt
update-ca-trust extract                      # activate (and also takes care of /etc/pki/ca-trust/extracted/java/cacerts /etc/pki/java/cacerts)

# alpine
apk update && apk add ca-certificates
cp yourca.crt /usr/local/share/ca-certificates/yourca.crt
update-ca-certificates
=> file /etc/ssl/certs/ca-certificates.cr has been updated

# alpine docker zabbix trouble shooting
python -i
from idecore import idelogging, credentials, idetools, zabbix
zabbix.connection(url='https://myzabbix.url')
less /etc/ssl/certs/ca-certificates.crt
apk update && apk add curl && curl https://myzabbix.url

# chrome chromium
chrome://settings/certificates
chrome://net-internals/#hsts
chrome://settings/certificates ~/.words/mitmproxy/mitmproxy-ca-cert.pem

https://konklone.com/post/why-google-is-hurrying-the-web-to-kill-sha-1

# firefox windows
security.enterprise_roots.enabled = true # in about:config will also load windows root CA
https://wiki.mozilla.org/CA:AddRootToFirefox
http://stackoverflow.com/questions/1435000/programmatically-install-certificate-into-mozilla
2, Add the cert manually to firefox Options-->Advanced--Certificates-->Authorities-->Import

# firefox cli
check https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/Tools/certutil


openssl x509 -inform pem -in "$F" -noout -text
openssl x509 -inform pem -in mycert.crt -noout -text | grep -E 'Subject:|Issuer:'

/usr/bin/openssl s_client -connect p-mon-zabbix-001:443 | head -n 20
h=www.google.com; /usr/bin/openssl s_client -connect $h:443 -servername $h | head -n 20 # SNI Server Name Indication
curl -k --resolve myaddress.com:443:186.1.250.3 https://myaddress.com


#apache httpd
SSLEngine on
SSLCertificateFile      "/etc/pki/katello/certs/katello-apache.crt"
SSLCertificateKeyFile   "/etc/pki/katello/private/katello-apache.key"
SSLCertificateChainFile "/etc/pki/katello/certs/katello-server-ca.crt"
SSLCACertificateFile    "/etc/pki/katello/certs/katello-default-ca.crt"
systemctl reload httpd



# java
ls -la  /etc/pki/ca-trust/extracted/java/cacerts /etc/pki/java/cacerts
keytool -list -v -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass changeit | grep -i engineer

cacert password -> changeit
keytool -list -v -keystore /etc/pki/java/cacerts | grep -i mysearchstring #jks
keytool -storepass "123456" -list -v -keystore ~/apache-tomcat/webapps/ROOT/WEB-INF/certs/WebServer.jks
keytool -storepass "123456"  -exportcert -alias webserver -v -keystore apache-tomcat/webapps/ROOT/WEB-INF/certs/WebServer.jks -rfc > /tmp/out3
keytool -import -trustcacerts -alias root -file /tmp/myca.crt -keystore cacerts
keytool -import -trustcacerts -file KS-CFC-Root_KS-CFC-Root.crt -alias KS-CFC-Root -keystore ks-cacerts2.jks -storepass HqBcm
keytool -import -trustcacerts -file KS-CFC-Issuing-01_KS-CFC-Root.crt  -alias KS-CFC-Issuing-01 -keystore ks-cacerts.jks -storepass HqBcm
/e/me/global/java/FwBrowse/nbproject/build-impl.xml
<signjar
          jar="${dist.jar}"
          storepass="fdlskjffjdsaf"
          keystore="nbproject/private/mykeystore.jks"
          keypass="fasdfkjdslfjadlfjldsjflkdjlsa"
          tsaurl="http://timestamp.digicert.com"
          alias="myalias"
          />
jarsigner -verify /e/me/local/appsdata/apache-tomcat/projects/fw/build/WEB-INF/lib/FwServlet.jar
jarsigner.exe -verify -verbose -certs $(cygpath -wa /java/FwBrowse/dist/FwBrowse.jar)  | less
jarsigner -keystore /e/me/certs/mykeystore.jks -tsa http://timestamp.digicert.com bip.jar myalias
for i in *jar; do printf "%-30s %s\n" $i "$(jarsigner -verify $i)"; done

# retrieve certifcate from server
echo QUIT | openssl s_client -connect ${HOSTNAME}:${PORT} -servername ${HOSTNAME} -tls1_1
 -no_ssl3                   Just disable SSLv3
 -no_tls1                   Just disable TLSv1
 -no_tls1_1                 Just disable TLSv1.1
 -no_tls1_2                 Just disable TLSv1.2
 -no_tls1_3                 Just disable TLSv1.3
  -tls1                      Just use TLSv1
  -tls1_1                    Just use TLSv1.1
  -tls1_2                    Just use TLSv1.2
  -tls1_3                    Just use TLSv1.3
  -dtls                      Use any version of DTLS
  -dtls1                     Just use DTLSv1
  -dtls1_2                   Just use DTLSv1.2
echo QUIT | openssl s_client -connect ${HOSTNAME}:${PORT} -servername ${HOSTNAME} -tls1_1
echo QUIT | openssl s_client -connect ${HOSTNAME}:${PORT} -servername ${HOSTNAME} -tls1_2
echo QUIT | openssl s_client -connect ${HOSTNAME}:${PORT} -servername ${HOSTNAME} -tls1_3
echo QUIT | openssl s_client -connect ${HOSTNAME}:${PORT} -servername ${HOSTNAME} -showcerts # save certificate as file
echo QUIT | openssl s_client -connect ${HOSTNAME}:${PORT} -servername ${HOSTNAME} -starttls smtp -showcerts # -starttls for upgraded connection
printf 'quit\n' | openssl s_client -connect 192.168.182.21:25 -starttls smtp | openssl x509 -enddate -noout
python -c "import ssl; print(ssl.get_server_certificate(('atlassian.hq.k.grp', 443)))"

# node.js
export NODE_EXTRA_CA_CERTS=/etc/pki/ca-trust/source/anchors/myca.crt

# git https
GIT_SSL_NO_VERIFY=true

LDAPTLS_REQCERT=never ldapwhoami -v -x -H ldaps://10.0.1.15 -D myuser@domain # ldaps no verify ldapsearch

AZURE_CLI_DISABLE_CONNECTION_VERIFICATION=1

# verify validation (full chain must be in onefile)
host=www.google.com; a=$(mktemp); python -c "import ssl; print(ssl.get_server_certificate(('$host', 443)))" |tee $a; openssl verify -verbose -CAfile ~/myca.crt $a


# windows
certmgr.msc

# vagrant
config.vm.box_download_insecure = true # certs https




create_cert.sh

certmgr.msc

# keytool jks jdk8 to jdk6,jdk7
```sh
jdk8/bin/keytool -importkeystore -srckeystore tensorsys.jks -destkeystore bip.p12 -srcstoretype JKS -deststoretype PKCS12 # in jdk8 converts JKS to PKCS12
openssl pkcs12 -info -in bip.p12 -nodes > TMPFILE # prints private key and certs in plain text
# manually separate TMPFILE in a.key and bundle.crt
openssl pkcs12 -export -out certificate.pfx -inkey a.key -in bundle.crt -name MYALIAS # reassamble a new pkcs12 with an actual alias. I wonder if this step is necessary
jdk6/bin/keytool -importkeystore -deststorepass "Abcd1234" -destkeypass "Abcd1234" -destkeystore jdk6.jks -srckeystore certificate.pfx -srcstoretype PKCS12 -srcstorepass Abcd1234 -alias MYALIAS # in jdk6, convert PKCS12 to JSK
```

# on apache
insures that hostname is FQDN and hostname -f returns correct value
hostnamectl set-hostname mymachine-001.mydomain.local


http://stackoverflow.com/questions/20065304/what-is-the-differences-between-begin-rsa-private-key-and-begin-private-key
http://stackoverflow.com/questions/10783366/how-to-generate-pkcs1-rsa-keys-in-pem-format

PKCS #1    2.2   RSA Cryptography Standard                        See RFC 3447. Defines the mathematical properties and format of RSA public and private keys (ASN.1-encoded in clear-text), and the basic algorithms and encoding/padding schemes for performing RSA encryption, decryption, and producing and verifying signatures.
PKCS #2    -     Withdrawn                                        No longer active as of 2010. Covered RSA encryption of message digests; subsequently merged into PKCS #1.
PKCS #3    1.4   Diffie–Hellman Key Agreement Standard            A cryptographic protocol that allows two parties that have no prior knowledge of each other to jointly establish a shared secret key over an insecure communications channel.
PKCS #4    -     Withdrawn                                        No longer active as of 2010. Covered RSA key syntax; subsequently merged into PKCS #1.
PKCS #5    2.0   Password-based Encryption Standard               See RFC 2898 and PBKDF2.
PKCS #6    1.5   Extended-Certificate Syntax Standard             Defines extensions to the old v1 X.509 certificate specification. Obsoleted by v3 of the same.
PKCS #7    1.5   Cryptographic Message Syntax Standard            See RFC 2315. Used to sign and/or encrypt messages under a PKI. Used also for certificate dissemination (for instance as a response to a PKCS #10 message). Formed the basis for S/MIME, which is as of 2010 based on RFC 5652, an updated Cryptographic Message Syntax Standard (CMS). Often used for single sign-on.
PKCS #8    1.2   Private-Key Information Syntax Standard          See RFC 5958. Used to carry private certificate keypairs (encrypted or unencrypted).
PKCS #9    2.0   Selected Attribute Types                         See RFC 2985. Defines selected attribute types for use in PKCS #6 extended certificates, PKCS #7 digitally signed messages, PKCS #8 private-key information, and PKCS #10 certificate-signing requests.
PKCS #10   1.7   Certification Request Standard                   See RFC 2986. Format of messages sent to a certification authority to request certification of a public key. See certificate signing request.
PKCS #11   2.40  Cryptographic Token Interface                    Also known as "Cryptoki". An API defining a generic interface to cryptographic tokens (see also hardware security module). Often used in single sign-on, public-key cryptography and disk encryption systems. RSA Security has turned over further development of the PKCS #11 standard to the OASIS PKCS 11 Technical Committee.
PKCS #12   1.1   Personal Information Exchange Syntax Standard    See RFC 7292. Defines a file format commonly used to store private keys with accompanying public key certificates, protected with a password-based symmetric key. PFX is a predecessor to PKCS #12.  This container format can contain multiple embedded objects, such as multiple certificates. Usually protected/encrypted with a password. Usable as a format for the Java key store and to establish client authentication certificates in Mozilla Firefox. Usable by Apache Tomcat.
PKCS #13    –    Elliptic Curve Cryptography Standard             (Apparently abandoned, only reference is a proposal from 1998.)
PKCS #14    –    Pseudo-random Number Generation                  (Apparently abandoned, no documents exist.)
PKCS #15   1.1   Cryptographic Token Information Format Standard  Defines a standard allowing users of cryptographic tokens to identify themselves to applications, independent of the application's Cryptoki implementation (PKCS #11) or other API. RSA has relinquished IC-card-related parts of this standard to ISO/IEC 7816-15.


#define PEM_STRING_X509_OLD "X509 CERTIFICATE"
#define PEM_STRING_X509     "CERTIFICATE"
#define PEM_STRING_X509_PAIR    "CERTIFICATE PAIR"
#define PEM_STRING_X509_TRUSTED "TRUSTED CERTIFICATE"
#define PEM_STRING_X509_REQ_OLD "NEW CERTIFICATE REQUEST"
#define PEM_STRING_X509_REQ "CERTIFICATE REQUEST"
#define PEM_STRING_X509_CRL "X509 CRL"
#define PEM_STRING_EVP_PKEY "ANY PRIVATE KEY"
#define PEM_STRING_PUBLIC   "PUBLIC KEY"
#define PEM_STRING_RSA      "RSA PRIVATE KEY"
#define PEM_STRING_RSA_PUBLIC   "RSA PUBLIC KEY"
#define PEM_STRING_DSA      "DSA PRIVATE KEY"
#define PEM_STRING_DSA_PUBLIC   "DSA PUBLIC KEY"
#define PEM_STRING_PKCS7    "PKCS7"
#define PEM_STRING_PKCS7_SIGNED "PKCS #7 SIGNED DATA"
#define PEM_STRING_PKCS8    "ENCRYPTED PRIVATE KEY"
#define PEM_STRING_PKCS8INF "PRIVATE KEY"
#define PEM_STRING_DHPARAMS "DH PARAMETERS"
#define PEM_STRING_DHXPARAMS    "X9.42 DH PARAMETERS"
#define PEM_STRING_SSL_SESSION  "SSL SESSION PARAMETERS"
#define PEM_STRING_DSAPARAMS    "DSA PARAMETERS"
#define PEM_STRING_ECDSA_PUBLIC "ECDSA PUBLIC KEY"
#define PEM_STRING_ECPARAMETERS "EC PARAMETERS"
#define PEM_STRING_ECPRIVATEKEY "EC PRIVATE KEY"
#define PEM_STRING_PARAMETERS   "PARAMETERS"
#define PEM_STRING_CMS      "CMS"


pip install --trusted-host pypi.python.org  ldap3 # no validate python pip

openssl rsa -aes256 -in adminmru.key -out adminmru-key.key # add change passphrase key password

# pfx
openssl pkcs12 -in client_ssl.pfx -out client_ssl.pem -clcerts # extract CL certs (but not CA certs) from pfx
openssl pkcs12 -in client_ssl.pfx -out root.pem -cacerts       # extract CA certs (but not CL certs) from pfx
openssl pkcs12 -export -out domain.name.pfx -inkey domain.name.key -in domain.name.crt -in intermediate.crt -in rootca.crt # to pfx
openssl pkcs12 -export -out out.pfx -inkey key.pem -in root.crt -in intermediate.crt -in mycert.pem
openssl pkcs7 -print_certs  -in p2f.LweE3.p7b # microsoft CA


# listen https
openssl s_server -key /etc/ssl/private/nginx-selfsigned.key -cert /root/a.crt -cert_chain /root/b.crt -accept 443 -www
socat openssl-listen:12345,reuseaddr,cert=test.pem,verify=0,fork stdio
ncat -lvnp 12345 --ssl
ncat -lvnp 443 --ssl --ssl-cert /etc/ssl/certs/nginx-selfsigned.crt --ssl-key /etc/ssl/private/nginx-selfsigned.key
socat openssl-listen:12345,reuseaddr,cert=test.pem,verify=0,fork stdio

# wrap
ssh-keygen -f hehe
date > data
ssh-public-key-converter.sh hehe
openssl rsautl -encrypt -pkcs -pubin -inkey ./hehe.pub.PKCS8 -in data -out data.secure
openssl rsautl -decrypt -in data.secure -inkey hehe > data.unwrapped

# OSCP must-staple
https://scotthelme.co.uk/ocsp-must-staple/
```ini
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
1.3.6.1.5.5.7.1.24 = DER:30:03:02:01:05
```
