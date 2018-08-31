works with app password for me and usual password for mom

https://hobo.house/2017/07/17/using-offlineimap-with-the-gmail-imap-api/


# run
it currently sucks as offlineimap is put in same docker image as mutt which starts
automatically in the container. So:
cd ~/docker/mutt-plus-tools
./run.sh DIRECTORYWHERE_.offlineimaprc_IS
docker-bash-last.sh
offlineimap



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
