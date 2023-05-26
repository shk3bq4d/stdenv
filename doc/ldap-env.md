yum install openldap-clients
apt install ldap-utils

The LDAP RFC specifies that LDAP messages are ASN1 encoded. This means the messages are binary data in a special format, instead of text, following a special format. This makes it very hard to write ladap-queries by hand with telnet. # https://stackoverflow.com/questions/11549731/is-it-possible-to-send-ldap-requests-via-telnet

# https://stackoverflow.com/questions/6195812/ldap-nested-group-membership
# https://docs.microsoft.com/en-us/windows/win32/adsi/search-filter-syntax?redirectedfrom=MSDN
(memberOf:1.2.840.113556.1.4.1941:=CN=active-directory-recursive-member,OU=Groups,OU=Security,DC=hehe,DC=com)
(&(objectClass=group)(&(ou:dn:=Chicago)(!(ou:dn:=Wrigleyville)))) # (possibly jira specific) will find all Chicago groups except those with a Wrigleyville OU component.
(&(objectClass=group)(|(ou:dn:=Chicago)(ou:dn:=Miami))) # (possibly jira specific) will find groups with an OU component of their DN which is either 'Chicago' or 'Miami'.

sed ':a;$!{N;ba};s/\n //g' # ldapsearch
