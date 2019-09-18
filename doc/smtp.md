# port: 25, 587, 465 (inofficial, should not be used), 2525 (innoficial used to route around blocking)

telnet mail.domain.ext 25
HELO local.domain.name - dont worry too much about your local domain name although you really should use your exact fully qualified domain name as seen by the outside world the mail server has no choice but to take your word for it as of RFC822-RFC1123.
HELO local.domain.name
MAIL FROM: mail@domain.ext
RCPT TO: mail@otherdomain.ext
DATA
Subject: hehe

Body start

hehe

hoho
.
QUIT

# https://www.linode.com/docs/email/postfix/configure-postfix-to-send-mail-using-gmail-and-google-apps-on-debian-or-ubuntu
