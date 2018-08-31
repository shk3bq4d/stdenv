
# .offlineimaprc
@begin=ini@
[general]
accounts = ExampleOrg
[Account ExampleOrg]
localrepository = ExampleLocal
remoterepository = ExampleRemote
status_backend = sqlite
#postsynchook = notmuch new
[Repository ExampleRemote]
type = IMAP
remotehost = imap.gmail.com
remoteuser = jeff.malone@gmail.com
remotepass = MySecretPassword
ssl = yes
sslcacertfile = /etc/ssl/certs/ca-bundle.crt
auth_mechanisms = GSSAPI, XOAUTH2, CRAM-MD5, PLAIN, LOGIN
[Repository ExampleLocal]
type = Maildir
localfolders = ~/Maildir
restoreatime = no
@begin=ini@
