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
