# /* ex: set filetype=sql fenc=utf-8 expandtab ts=4 sw=4 : */
psql -U postgres
sudo -u postgres psql

port TCP/5432

```sql
\list or \l: list all databases
\dt: list all tables in the current database
\du list roles
\dn list schemas
\dp list privileges for current user on current database
\dp TABLENAME list privileges for current user on TABLENAME database
\d table -- describe table , create table alternative
\d+ table -- describe table + storage + stats + description, show create table, show create view
\! pwd -- execute shell command
\! for i in $(seq 5); do echo $i; done
\! echo $0 # sh
pg_dump -st tablename dbname -- show create table (ie: there is no such thing according to https://serverfault.com/questions/231952/is-there-an-equivalent-of-mysqls-show-create-table-in-postgres)
sudo docker exec -u 999 -it postgres pg_dump -st repository -U bitbucket bitbucketdb -- show create table repository
\c       database_name -- use
\connect database_name -- use
\conninfo -- whoami
set role to username; -- to change the current user without relogin
\x # toggles expanded display (vertical alignment)
show config_file; -- display filepath of main config file

select schema_name from information_schema.schemata;
select * from information_schema.table_privileges;
select * from information_schema.tables;
select table_catalog, table_schema, table_name, table_type from information_schema.tables;
select table_catalog, table_schema, table_name, table_type from information_schema.tables where table_name like '%priv%';
select table_catalog, table_schema, table_name, table_type from information_schema.tables where table_schema not in ('pg_catalog', 'information_schema');
substring(column, start_pos, length)

show search_path;
set search_path to myotherschema, public;

coalesce -- nvl
select c.relname from pg_class c where c.relkind = 'S'; # list sequences
```

-v ON_ERROR_STOP=1
\set ON_ERROR_STOP on

```sql
create schema coucou;
select datname from pg_database where datistemplate = false; -- list databases
select table_schema,table_name from information_schema.tables order by table_schema,table_name; -- list tables in current database
create user tom with password 'myPassword';
create database jerry;
grant all privileges on database jerry to tom;
grant connect on database confdb to myuser;
grant usage   on schema public   to myuser;
grant select  on cwd_user        to myuser;
grant select  on user_mapping    to myuser;
grant select on all tables in schema public to user;
grant execute on all functions in schema public to user;
```

select "user" from oc_activity; -- escape column name table protected values keyword

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
sudo docker exec -e DEBIAN_FRONTEND=noninteractive posgres sh -c "apt update && apt install less"
pager less --raw-control-chars --quit-if-one-screen --ignore-case --status-column --no-init;
pager less --raw-control-chars --quit-if-one-screen --ignore-case --status-column --no-init --chop-long-lines; -- truncate lines instead of wrapping
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

select "quoted_protected_column_escaped" from "my_table_name";

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

https://hub.docker.com/_/postgres
https://github.com/docker-library/docs/tree/master/postgres/README.md
https://github.com/docker-library/postgres/blob/master/14/bookworm/Dockerfile
https://github.com/docker-library/postgres/blob/master/14/bookworm/docker-entrypoint.sh
https://github.com/docker-library/postgres

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
* [https://wiki.postgresql.org/wiki/Replication,\_Clustering,\_and_Connection_Pooling](https://wiki.postgresql.org/wiki/Replication,_Clustering,_and_Connection_Pooling)
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
ect client_addr, state from pg_stat_replication;
select pg_is_in_recovery();
select pg_read_file('/etc/hostname') as hostname, setting as port from pg_settings where name='port';
```

# json
```sql
select uid, json_extract_path(mycolumn::json, 'json-root', 'json-key') from oc_accounts limit 10; -- ::json is a cast
select uid, json_extract_path(data::json, 'email', 'value') from oc_accounts limit 10; -- nextcloud
select uid, json_extract_path(data::json, 'email', 'value') from oc_accounts where json_extract_path(data::json, 'email', 'value')::varchar like '"fa%' limit 20; -- please notice the leading " in the like operator right hand side member
select name, json_extract_path_text(configuration::json, 'idp-entityId') from oc_user_saml_configurations;
select name, json_extract_path_text(configuration::json, 'idp-x509cert') from oc_user_saml_configurations;
select uid, json_extract_path_text(data::json, 'displayname', 'value') from oc_accounts limit 2;
select name, jsonb_set(configuration::jsonb, '{idp-entityId}', '"___________________________"', false) from oc_user_saml_configurations;

psql -At # batch mode --tuples-only --no-align skip headers column namse

# sessions
```
select * from pg_stat_activity where state in ('idle', 'active');
select pid ,datname ,usename ,application_name ,client_hostname ,client_port ,backend_start ,query_start ,query ,state from pg_stat_activity where state in ('idle', 'active');
select pid, usename as user_name, datname as database_name, client_addr as client_address, client_port, backend_start, state, query from pg_stat_activity; -- show connections lists sessions
```


string_agg https://hevodata.com/learn/postgresql-string-agg/ # group by string aggregate
string_agg ( expression, separator|delimiter [order_by] )

select to_char(now(), 'YYYY-MM-DD HH24:mi:ss') -- date sprintf formating minutes hour year seconds hh12
select extract(epoch from now()); -- unix timestamp
select to_timestamp(mycolumn::bigint);    -- postgresq psql from unixtime

select to_timestamp(configvalue::bigint) from oc_preferences where configkey in ('lastLogin'); -- cast string as bigint in nexcloud

```markdown
# major upgrades
are to be done by making a backup, trashing the data folder, restoring the backu

* [hehe](https://hub.docker.com/_/postgres)
* https://github.com/docker-library/docs/blob/master/postgres/README.md



https://www.postgresql.org/support/versioning/
Releases
Version	Current minor	Supported	First Release	Final Release
15	15.4	Yes	October 13, 2022	November 11, 2027
14	14.9	Yes	September 30, 2021	November 12, 2026
13	13.12	Yes	September 24, 2020	November 13, 2025
12	12.16	Yes	October 3, 2019	November 14, 2024
11	11.21	Yes	October 18, 2018	November 9, 2023
10	10.23	No	October 5, 2017	November 10, 2022
9.6	9.6.24	No	September 29, 2016	November 11, 2021
9.5	9.5.25	No	January 7, 2016	February 11, 2021
9.4	9.4.26	No	December 18, 2014	February 13, 2020
9.3	9.3.25	No	September 9, 2013	November 8, 2018
9.2	9.2.24	No	September 10, 2012	November 9, 2017
9.1	9.1.24	No	September 12, 2011	October 27, 2016
9.0	9.0.23	No	September 20, 2010	October 8, 2015
8.4	8.4.22	No	July 1, 2009	July 24, 2014
8.3	8.3.23	No	February 4, 2008	February 7, 2013
8.2	8.2.23	No	December 5, 2006	December 5, 2011
8.1	8.1.23	No	November 8, 2005	November 8, 2010
8.0	8.0.26	No	January 19, 2005	October 1, 2010
7.4	7.4.30	No	November 17, 2003	October 1, 2010
7.3	7.3.21	No	November 27, 2002	November 27, 2007
7.2	7.2.8	No	February 4, 2002	February 4, 2007
7.1	7.1.3	No	April 13, 2001	April 13, 2006
7.0	7.0.3	No	May 8, 2000	May 8, 2005
6.5	6.5.3	No	June 9, 1999	June 9, 2004
6.4	6.4.2	No	October 30, 1998	October 30, 2003
6.3	6.3.2	No	March 1, 1998	March 1, 2003

Select current_setting('server_version');

# copy
```bash
echo "Name,Age,Location" > data.csv
echo "John,25,New York" >> data.csv
echo "Alice,30,San Francisco" >> data.csv
echo "Bob,22,Los Angeles" >> data.csv
```
```sql
create table if not exists your_table ( name varchar(50), age integer, location varchar(50));
\copy your_table from '/var/lib/postgresql/data/pgdata/data.csv' with csv header; -- sql load
\copy your_table from 'data.csv' with csv header; -- sql load
-- Do not confuse COPY with the psql instruction \copy. \copy invokes COPY FROM STDIN or COPY TO STDOUT, and then fetches/stores the data in a file accessible to the psql client. Thus, file accessibility and access rights depend on the client rather than the server when \copy is used.
select * from your_table;
insert into your_table (name) values (current_timestamp);
```

https://www.postgresql.org/docs/14/ssl-tcp.html
ssl
ssl_key_file
ssl_cert_file
ssl_ca_file
ssl_min_protocol_version

