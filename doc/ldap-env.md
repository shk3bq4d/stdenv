yum install openldap-clients
apt install ldap-utils

The LDAP RFC specifies that LDAP messages are ASN1 encoded. This means the messages are binary data in a special format, instead of text, following a special format. This makes it very hard to write ladap-queries by hand with telnet. # https://stackoverflow.com/questions/11549731/is-it-possible-to-send-ldap-requests-via-telnet
