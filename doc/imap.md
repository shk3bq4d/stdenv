openssl s_client -connect outlook.office365.com:993 -crlf
a0006 login myusername mypassord
a0006 NO LOGIN failed.


a0006 is a random client string which the server will reuse so requests can be correlated
-crlf is essential for the connection to go through


# absent in my case, https://portal.office.com/account/#security
https://support.office.com/en-us/article/create-an-app-password-for-office-365-3e7c860f-bda4-4441-a618-b53953ee1183
