# Procedure
* https://wiki.archlinux.org/index.php/Easy-RSA
* https://community.openvpn.net/openvpn/wiki/EasyRSA3-OpenVPN-Howto

The binary files on Ubuntu are different than the ones from ArchWiki and
openvpn. Likely a difference between easy-rsa 1, 2, 3

## sytem installation
apt install easy-rsa

## generate CA
@begin=sh@
CANAME=p02ca
cd ~/tmp
export PATH=/usr/share/easy-rsa/:$PATH
make-cadir $CANAME
cd ~/tmp/$CANAME
cp ~/tmp/vars-ca ~/tmp/$CANAME/vars # or vi vars
source vars
./clean-all
./build-ca
@end=sh@

## skip intermediate CA
In case you don't need it for simple setup

## generate client CSR
@begin=sh@
CLIENTNAME=myidentifyingname
cd ~/tmp
export PATH=/usr/share/easy-rsa/:$PATH
make-cadir $CLIENTNAME
cd ~/tmp/$CLIENTNAME
cp ~/tmp/vars-$CLIENTNAME ~/tmp/$CLIENTNAME/vars # vi vars
source vars
./clean-all
./build-req  $CLIENTNAME
@end=sh@

## transmit CSR to CA
@begin=sh@
mkdir ~/tmp/$CANAME/clients/
cp ~/tmp/$CLIENTNAME/keys/${CLIENTNAME}.csr ~/tmp/$CANAME/clients/
@end=sh@

## Sign Certificate Request
@begin=sh@
cd ~/tmp/$CANAME
source vars
./sign-req $PWD/clients/${CLIENTNAME} # notice .csr was skipped and file is absolute

@end=sh@

# existing files
/usr/share/doc/easy-rsa/README.Debian

/usr/share/easy-rsa
/usr/share/doc/easy-rsa
/usr/share/doc/easy-rsa/README-2.0.gz
/usr/share/doc/easy-rsa/README.Debian
/usr/share/doc/easy-rsa/changelog.Debian.gz
/usr/share/doc/easy-rsa/copyright
/usr/share/easy-rsa/build-ca
/usr/share/easy-rsa/build-dh
/usr/share/easy-rsa/build-inter
/usr/share/easy-rsa/build-key
/usr/share/easy-rsa/build-key-pass
/usr/share/easy-rsa/build-key-pkcs12
/usr/share/easy-rsa/build-key-server
/usr/share/easy-rsa/build-req
/usr/share/easy-rsa/build-req-pass
/usr/share/easy-rsa/clean-all
/usr/share/easy-rsa/inherit-inter
/usr/share/easy-rsa/list-crl
/usr/share/easy-rsa/openssl-0.9.6.cnf
/usr/share/easy-rsa/openssl-0.9.8.cnf
/usr/share/easy-rsa/openssl-1.0.0.cnf
/usr/share/easy-rsa/pkitool
/usr/share/easy-rsa/revoke-full
/usr/share/easy-rsa/sign-req
/usr/share/easy-rsa/vars
/usr/share/easy-rsa/whichopensslcnf

