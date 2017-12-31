fail2ban-client status
fail2ban-client status sshd

http://serverfault.com/questions/285256/how-to-unban-an-ip-properly-with-fail2ban
fail2ban-client get YOURJAILNAMEHERE actionunban IPADDRESSHERE # With Fail2Ban before v0.8.8:
fail2ban-client set YOURJAILNAMEHERE unbanip IPADDRESSHERE # With Fail2Ban v0.8.8 and later:

sudo fail2ban-client set sshd unbanip 6.1.64.92
sudo fail2ban-client set sshd unbanip 6.1.0.159
