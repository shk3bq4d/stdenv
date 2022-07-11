# /* ex: set filetype=sql fenc=utf-8 expandtab ts=4 sw=4 : */
psql -U postgres
sudo -u postgres psql

\list or \l: list all databases
\dt: list all tables in the current database
\du list roles
\d table -- describe table
\d+ table -- describe table + storage + stats + description
pg_dump -st tablename dbname -- show create table (ie: there is no such thing according to https://serverfault.com/questions/231952/is-there-an-equivalent-of-mysqls-show-create-table-in-postgres)
\c       database_name -- use
\connect database_name -- use
\x # toggles expanded display (vertical alignment)

sELECT c.relname FROM pg_class c WHERE c.relkind = 'S'; # list sequences

-v ON_ERROR_STOP=1

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

https://www.postgresql.org/docs/9.1/functions-string.html
select length('string length') as hehe;

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
sudo docker exec -e PAGER="vim -c 'set buftype=nofile nomod nowrap nolist nonumber ft=sql syntax=sql' -" -e EDITOR=vim -u 999 -it postgres bash -itc "psql -U jira jiradb"
sudo docker cp $RCD/.vimrc  postgres:/var/lib/postgresql/.vimrc
truncate table auditrecord , audit_affected_object, audit_changed_value;

PG_VERSION=10.19-1.pgdg90+1
POSTGRES_DB=jiradb
POSTGRES_PASSWORD=jira
POSTGRES_USER=jira
zcat jiradb-2022.01.09.sql.gz  | sudo docker exec -u 999 -t postgres bash -c 'PGPASSWORD=$POSTGRES_PASSWORD pg_restore -d$POSTGRES_DB -U$POSTGRES_USER'
sudo docker exec -u 999 -it postgres bash -c 'PGPASSWORD=$POSTGRES_PASSWORD psql -d$POSTGRES_DB -U$POSTGRES_USER'

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

select lower('HABON');


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


docker exec -u 999 -it postgres psql -U bitbucket bitbucketdb


```sql
select to_timestamp(timestamp), type, affecteduser, case when type = 'file_changed' then subjectparams else file end as file from oc_activity where timestamp > 1596031681 and subject like '%_self' and type in ('file_changed', 'file_created', 'file_deleted') order by affecteduser, file, timestamp;

vacuum full mytablename;
vacuum      mytablename;
analyze     mytablename;

-- https://wiki.postgresql.org/wiki/Disk_Usage all tables disk usage
with recursive pg_inherit(inhrelid, inhparent) as
    (select inhrelid, inhparent
    from pg_inherits
    union
    select child.inhrelid, parent.inhparent
    from pg_inherit child, pg_inherits parent
    where child.inhparent = parent.inhrelid),
pg_inherit_short as (select * from pg_inherit where inhparent not in (select inhrelid from pg_inherit))
select table_schema
    , table_name
    , row_estimate
    , pg_size_pretty(total_bytes) as total
    , pg_size_pretty(index_bytes) as index
    , pg_size_pretty(toast_bytes) as toast
    , pg_size_pretty(table_bytes) as table
  from (
    select *, total_bytes-index_bytes-coalesce(toast_bytes,0) as table_bytes
    from (
         select c.oid
              , nspname as table_schema
              , relname as table_name
              , sum(c.reltuples) over (partition by parent) as row_estimate
              , sum(pg_total_relation_size(c.oid)) over (partition by parent) as total_bytes
              , sum(pg_indexes_size(c.oid)) over (partition by parent) as index_bytes
              , sum(pg_total_relation_size(reltoastrelid)) over (partition by parent) as toast_bytes
              , parent
          from (
                select pg_class.oid
                    , reltuples
                    , relname
                    , relnamespace
                    , pg_class.reltoastrelid
                    , coalesce(inhparent, pg_class.oid) parent
                from pg_class
                    left join pg_inherit_short on inhrelid = oid
                where relkind in ('r', 'p')
             ) c
             left join pg_namespace n on n.oid = c.relnamespace
  ) a
  where oid = parent
) a
order by total_bytes desc;
```

# regexp regular expression
https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP
```sql
~ (Matches regular expression, case sensitive)
~* (Matches regular expression, case insensitive)
!~ (Does not match regular expression, case sensitive)
!~* (Does not match regular expression, case insensitive)
replace(string text, from text, to text)
regexp_replace # https://www.postgresql.org/docs/8.2/functions-matching.html
regexp_replace('foobarbaz', 'b..', 'X', 'g') --> fooXX
select (regexp_match('foobarbequebaz', 'bar.*que'))[1];
regexp_match
regexp_matches
textregexeq -- regexp
select * where 'abc' ~ '.b.' -- regexp_like
select * where 'abc' similar to '%(b|d)%' -- pseudo-regexp_like SQL regular expressions are a curious cross between LIKE notation and common regular expression notation.
update bandana set bandanavalue = regexp_replace(bandanavalue, '(<hostname>)[^<]*(</hostname>)', concat('\1', 'localhost', '\1')) where bandanakey = 'atlassian.confluence.smtp.mail.accounts';

'concat' || 'withme'
concat('bip', 'bop')
```

```markdown
# replication
* https://github.com/lesovsky/ansible-postgresql-sr-on-el6
* https://github.com/samdoran/ansible-role-pgsql-replication
* https://github.com/EnterpriseDB/edb-ansible/tree/master/roles/setup_replication
* https://severalnines.com/database-blog/postgresql-replication-setup-maintenance-using-ansible
* https://www.opensourceforu.com/2019/02/devops-series-configuring-a-postgresql-master-slave-setup-using-ansible/
* https://hub.docker.com/r/severalnines/clustercontrol
* https://www.enterprisedb.com/postgres-tutorials/postgresql-replication-and-automatic-failover-tutorial#log-shipping
* https://pgdash.io/blog/postgres-physical-replication.html#:~:text=Physical%20replication%20methods%20are%20used,)%2C%20typically%20on%20another%20machine.
* https://wiki.postgresql.org/wiki/Replication,_Clustering,_and_Connection_Pooling
* https://www.postgresql.org/docs/current/different-replication-solutions.html
* https://momjian.us/main/writings/pgsql/replication.pdf
* https://postgres-r.org/documentation/terms
* https://hevodata.com/learn/postgresql-streaming-replication/#meth2
* https://www.digitalocean.com/community/tutorials/how-to-set-up-physical-streaming-replication-with-postgresql-12-on-ubuntu-20-04

# failover
* https://www.enterprisedb.com/blog/where-my-recoveryconf-file-postgresql-v12
* https://www.enterprisedb.com/postgres-tutorials/how-manage-replication-and-failover-postgres-version-12-without-recoveryconf

```
```sql
select client_addr, state from pg_stat_replication;
select pg_is_in_recovery();
```

# json
```sql
select uid, json_extract_path(mycolumn::json, 'json-root', 'json-key') from oc_accounts limit 10; -- ::json is a cast
select uid, json_extract_path(data::json, 'email', 'value') from oc_accounts limit 10; -- nextcloud
select uid, json_extract_path(data::json, 'email', 'value') from oc_accounts where json_extract_path(data::json, 'email', 'value')::varchar like '"fa%' limit 20; -- please notice the leading " in the like operator right hand side member
