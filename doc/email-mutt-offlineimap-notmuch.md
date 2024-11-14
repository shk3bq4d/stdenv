multipart/mixed (only if attachments are included)
|
+-- multipart/related (only if embedded contents are included) 
|    |
|    +-- multipart/alternative (only if text AND html are available)
|    |    |
|    |    +-- text/plain (text version of the message)
|    |    +-- text/html  (html version of the message)
|    |     
|    +-- image/gif  (where to include embedded contents)
|
+-- application/msword (where to add attachments)


http://improvmx.com/success/
https://forwardmx.io/pricing


yum install mailx
```sh
echo "coucou" | mailx -s "mysubject mailx" myemail@example.com
echo "Subject: sendmail" | sendmail myemail@example.com
echo -e 'Hello!\nHow are you?\nBob' | mailx -s "test email" -S smtp=webmail.bip.com:587 me@example.com
echo -e 'Hello!\nHow are you?\nBob' | mailx -s "test email" -S smtp=webmail.bip.com:587 me@example.com,me2@example.com
echo "<p><i>italic</i><b>bold</b></p><p>second line $(date)</p>"  | mutt -e "set content_type=text/html" -e 'set smtp_url = "smtp://webmail.bip.com"' -s "Subject of the Email" -- me@example.com
```

# offlineimap
works with app password for me and usual password for mom

https://hobo.house/2017/07/17/using-offlineimap-with-the-gmail-imap-api/

## run
it currently sucks as offlineimap is put in same docker image as mutt which starts
automatically in the container. So:
cd ~/docker/mutt-plus-tools
./run.sh DIRECTORYWHERE_.offlineimaprc_IS
docker-bash-last.sh
offlineimap



## .offlineimaprc
@begin=ini@
[general]
accounts = ExampleOrg
[Account ExampleOrg]
localrepository = ExampleLocal
remoterepository = ExampleRemote
status_backend = sqlite
##postsynchook = notmuch new
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

## mutt
* https://github.com/jessfraz/dockerfiles/blob/master/mutt/Dockerfile
* https://jonathanh.co.uk/blog/mutt-setup/ # Exchange Outlook  Active directory
* https://news.ycombinator.com/item?id=33568388
* https://www.reddit.com/r/voidlinux/comments/kege37/mutt_imap_and_mail_synchronization_with_runit/
