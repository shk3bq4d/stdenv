psql -U postgres
sudo -u postgres psql

\list or \l: list all databases
\dt: list all tables in the current database
\du list roles
\connect database_name
\x # toggles expanded display (vertical alignment)

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
PGPASSWORD=auoehtnuhoeauaoetnuhoena psql \
	-h hostname \
	-U pgsqladmin@hostbip \
	-d "database" \
	-f my.sq

pg_dumpall -U django -oc
pg_dump    -U django -d myschema
postgres postgres -f -

psql -U postgres -d device42 -c "select * from rowmgmt_password_view_edit_groups where group_id = 9;"

docker exec -t postgres sh -c 'apt update && apt install -y vim'
docker exec -it postgres pg_dumpall -U docvault | gzip -c > /data/pgdump-$(date +'%Y.%m.%d-%H.%M.%S')-all.dump.gz
docker exec -u 999 -it postgres pg_dump -U confluence -d confluencedb 
echo -e '$include /etc/inputrc\nset editing-mode vi\nset keymap vi-command' | docker exec -i postgres sh -c 'cat - >  /var/lib/postgresql/.inputrc'
docker exec postgres cat /var/lib/postgresql/.psqlrc
echo -e '\\set lid 294913\n\\set ad 2195457' | docker exec -i postgres sh -c 'cat - >> /var/lib/postgresql/.psqlrc'
sudo docker exec -e PAGER="vim -c 'set buftype=nofile nomod nowrap nolist nonumber ft=sql syntax=sql' -" -e EDITOR=vim -u 999 -it postgres bash -itc "psql -U confluence confluencedb"
sudo docker cp $RCD/.vimrc  postgres:/var/lib/postgresql/.vimrc
truncate table auditrecord , audit_affected_object, audit_changed_value;


# backups backup
https://github.com/wal-e/wal-e
```sh
echo $POSTGRES_HOSTNAME:"*:*":$POSTGRES_USER:$(cat /conf/postgres-password) > ~/.pgpass;
chmod 0400 ~/.pgpass
pg_dumpall --host $POSTGRES_HOSTNAME | gzip -c > /backupdata/$(date +'%Y.%m.%d-%H.%M.%S')-all.dump.gz
```
19 mai

```sql
select 1; -- from dual

select * from users where username like 'jerem%';
select username, lastname from users where username like 'jerem%';
begin; -- or begin transaction;
update users set lastname='Bopton' where username like 'jere.bs%';
end transaction; -- or commit;
```

/var/lib/postgresql/.psql_history


create database docvault1304 with template docvault owner docvault;
create database mattermostdb504 with template mattermost owner sa;

select * from "escape_reserved_name_in_column_or_table_name";


# count for each table (may be slow on big databases, see https://stackoverflow.com/questions/2596670/how-do-you-find-the-row-count-for-all-your-tables-in-postgres )
select table_schema,
       table_name,
       (xpath('/row/cnt/text()', xml_count))[1]::text::int as row_count
from (
  select table_name, table_schema,
         query_to_xml(format('select count(*) as cnt from %I.%I', table_schema, table_name), false, true, '') as xml_count
  from information_schema.tables
  where table_schema = 'public' --<< change here for the schema you want
) t;

# regexp
~ (Matches regular expression, case sensitive)
~* (Matches regular expression, case insensitive)
!~ (Does not match regular expression, case sensitive)
!~* (Does not match regular expression, case insensitive)

docker exec -u 999 -it postgres psql -U bitbucket bitbucketdb


```sql
select to_timestamp(timestamp), type, affecteduser, case when type = 'file_changed' then subjectparams else file end as file from oc_activity where timestamp > 1596031681 and subject like '%_self' and type in ('file_changed', 'file_created', 'file_deleted') order by affecteduser, file, timestamp;

-- https://wiki.postgresql.org/wiki/Disk_Usage all tables disk usage
WITH RECURSIVE pg_inherit(inhrelid, inhparent) AS
    (select inhrelid, inhparent
    FROM pg_inherits
    UNION
    SELECT child.inhrelid, parent.inhparent
    FROM pg_inherit child, pg_inherits parent
    WHERE child.inhparent = parent.inhrelid),
pg_inherit_short AS (SELECT * FROM pg_inherit WHERE inhparent NOT IN (SELECT inhrelid FROM pg_inherit))
SELECT table_schema
    , TABLE_NAME
    , row_estimate
    , pg_size_pretty(total_bytes) AS total
    , pg_size_pretty(index_bytes) AS INDEX
    , pg_size_pretty(toast_bytes) AS toast
    , pg_size_pretty(table_bytes) AS TABLE
  FROM (
    SELECT *, total_bytes-index_bytes-COALESCE(toast_bytes,0) AS table_bytes
    FROM (
         SELECT c.oid
              , nspname AS table_schema
              , relname AS TABLE_NAME
              , SUM(c.reltuples) OVER (partition BY parent) AS row_estimate
              , SUM(pg_total_relation_size(c.oid)) OVER (partition BY parent) AS total_bytes
              , SUM(pg_indexes_size(c.oid)) OVER (partition BY parent) AS index_bytes
              , SUM(pg_total_relation_size(reltoastrelid)) OVER (partition BY parent) AS toast_bytes
              , parent
          FROM (
                SELECT pg_class.oid
                    , reltuples
                    , relname
                    , relnamespace
                    , pg_class.reltoastrelid
                    , COALESCE(inhparent, pg_class.oid) parent
                FROM pg_class
                    LEFT JOIN pg_inherit_short ON inhrelid = oid
                WHERE relkind IN ('r', 'p')
             ) c
             LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
  ) a
  WHERE oid = parent
) a
ORDER BY total_bytes DESC;
```
