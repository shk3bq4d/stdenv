* https://docs.netbox.dev/en/stable/release-notes/version-3.7/ # changelog
* https://docs.netbox.dev/en/stable/installation/upgrading/
* https://github.com/netbox-community/netbox/releases
* https://github.com/netbox-community/migration-scripts
* https://docs.netbox.dev/en/stable/customization/custom-scripts/
* [docker builder](https://github.com/netbox-community/netbox-docker)
* https://hub.docker.com/r/netboxcommunity/netbox/tags


https://demo.netbox.dev/static/docs/configuration/optional-settings/
https://demo.netbox.dev/static/docs/configuration/required-settings/

~/git/github/netbox-community/netbox-docker/docker/docker-entrypoint.sh
https://github.com/netbox-community/netbox-docker/commits/release/docker/docker-entrypoint.sh



 ~/git/github/netbox-community/netbox-docker   release  ack environ.get | sed -r -e 's/.*environ.get..([a-zA-Z_0-9]+).*/\1/' | sort -u
ALLOWED_HOSTS
ariable_name
AUTH_LDAP_ATTR_FIRSTNAME
AUTH_LDAP_ATTR_LASTNAME
AUTH_LDAP_ATTR_MAIL
AUTH_LDAP_BIND_AS_AUTHENTICATING_USER
AUTH_LDAP_BIND_DN
AUTH_LDAP_BIND_PASSWORD
AUTH_LDAP_CACHE_TIMEOUT
AUTH_LDAP_FIND_GROUP_PERMS
AUTH_LDAP_GROUP_SEARCH_BASEDN
AUTH_LDAP_GROUP_SEARCH_CLASS
AUTH_LDAP_GROUP_TYPE
AUTH_LDAP_IS_ADMIN_DN
AUTH_LDAP_IS_SUPERUSER_DN
AUTH_LDAP_MIRROR_GROUPS
AUTH_LDAP_REQUIRE_GROUP_DN
AUTH_LDAP_SERVER_URI
AUTH_LDAP_START_TLS
AUTH_LDAP_USER_DN_TEMPLATE
AUTH_LDAP_USER_SEARCH_ATTR
AUTH_LDAP_USER_SEARCH_BASEDN
BANNER_BOTTOM
BANNER_LOGIN
BANNER_TOP
configuration/ldap/ldap_config.py:64:AUTH_LDAP_USER_SEARCH_FILTER: str = environ.get(
configuration/ldap/ldap_config.py:78:AUTH_LDAP_GROUP_SEARCH_FILTER: str = environ.get(
CSRF_COOKIE_NAME
DATE_FORMAT
DATETIME_FORMAT
DB_HOST
DB_NAME
DB_PASSWORD
DB_PORT
DB_SSLMODE
DB_USER
EMAIL_FROM
EMAIL_PASSWORD
EMAIL_SERVER
EMAIL_SSL_CERTFILE
EMAIL_SSL_KEYFILE
EMAIL_USERNAME
LDAP_CA_CERT_DIR
LDAP_CA_CERT_FILE
LDAP_IGNORE_CERT_ERRORS
LOGLEVEL
MAPS_URL
MEDIA_ROOT
nd_map
REDIS_HOST
REDIS_INSECURE_SKIP_TLS_VERIFY
REDIS_PASSWORD
REDIS_PORT
REDIS_SSL
REDIS_USERNAME
RELEASE_CHECK_URL
REMOTE_AUTH_HEADER
SECRET_KEY
SESSION_COOKIE_NAME
SESSIONS_ROOT
SHORT_DATE_FORMAT
SHORT_DATETIME_FORMAT
SHORT_TIME_FORMAT
TIME_FORMAT
TIME_ZONE


# upgrade script
```sql
select id from dcim_device where lower(name) in (select lower(name) from dcim_device group by lower(name) having count(1) > 1);
create table mrfix_dcim_device_name as select id from dcim_device where lower(name) in (select lower(name) from dcim_device group by lower(name) having count(1) > 1);
select name || ' - #' || id || ' DBfix 2024.02.22' from dcim_device where id in (select id from mrfix_dcim_device_name);
update dcim_device set name = name || ' - #' || id || ' DBfix 2024.02.22' where id in (select id from mrfix_dcim_device_name);
