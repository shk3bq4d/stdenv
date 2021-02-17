# https://stackoverflow.com/questions/40653238/mariadb-galera-error-when-a-node-shutdown-error-1047-wsrep-has-not-yet-prepare
ERROR 1047 WSREP has not yet prepared node for application use
```sql
SET GLOBAL wsrep_provider_options='pc.bootstrap=YES';
```

https://github.com/bitnami/charts/tree/master/bitnami/mariadb-galera/
