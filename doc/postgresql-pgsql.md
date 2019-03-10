psql -U postgres

\list or \l: list all databases
\dt: list all tables in the current database
\du list roles
\connect database_name

sELECT c.relname FROM pg_class c WHERE c.relkind = 'S'; # list sequences


@begin=sql@
SELECT datname FROM pg_database WHERE datistemplate = false; -- list databases
SELECT table_schema,table_name FROM information_schema.tables ORDER BY table_schema,table_name; -- list tables in current database
CREATE USER tom WITH PASSWORD 'myPassword';
CREATE DATABASE jerry;
GRANT ALL PRIVILEGES ON DATABASE jerry to tom;
grant connect on database confdb to myuser;
grant usage   on schema public   to myuser;
grant select  on cwd_user        to myuser;
grant select  on user_mapping    to myuser;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO user;
@end=sql@

psql confdb myuser -c "select count(1) from cwd_user;"


export LD_LIBRARY_PATH=/usr/lib64:/opt/rh/postgresql92/root/usr/lib64/
export PATH=$PATH:/opt/rh/postgresql92/root/usr/bin
set -o vi
ncvsdlakfnsd%34
sudo su - postgres
psql -d template1 -c "ALTER USER postgres WITH PASSWORD 'fdla@#$fdB';"

CREATE USER zabbix WITH PASSWORD 'myPasswordFSD0.fs8';
GRANT ALL PRIVILEGES ON DATABASE zabbix to zabbix;

vi /opt/rh/postgresql92/root/var/lib/pgsql/data/pg_hba.conf
host    all             all             127.0.0.1/32            md5
grant all   on schema public   to zabbix;
GRANT all ON ALL TABLES IN SCHEMA public TO zabbix;
SELECT * FROM information_schema.tables where table_name='dbversion';

psql -U zabbix -h localhost
java -jar schemaSpy_5.0.0.jar -t pgsql -host localhost:5432 -db zabbix -s public -o /tmp/bip -u zabbix -p myPasswordFSD0.fs8 -dp postgresql-42.1.4.jar

pg_dumpall -U django -oc 
postgres postgres -f -

psql -U postgres -d device42 -c "select * from rowmgmt_password_view_edit_groups where group_id = 9;"


# backups backup
https://github.com/wal-e/wal-e
```sh
echo $POSTGRES_HOSTNAME:"*:*":$POSTGRES_USER:$(cat /conf/postgres-password) > ~/.pgpass;
chmod 0400 ~/.pgpass
pg_dumpall --host $POSTGRES_HOSTNAME | gzip -c > /backupdata/$(date +'%Y.%m.%d-%H.%M.%S')-all.dump.gz
```
19 mai
