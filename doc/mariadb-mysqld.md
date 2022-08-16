```sh
mysql  -u root --password=root # long  password with equal
mysql  -u root -proot          # short password no equal
mysql --version
show variables like 'version';
```
```sql
show databases;
use DATABASENAME;
show tables;
show tables like '%event%';
desc mytable; -- show table schema
create database bip;
HOW GRANTS for someuser_dbuser@localhost;
select user, host, password from mysql.user order by user, host;
CREATE USER 'donald'@'%' IDENTIFIED BY password('duck');
CREATE USER 'donald'@'%' IDENTIFIED BY 'duck';
CREATE USER 'donald' IDENTIFIED BY 'duck';
drop USER 'donald'@'%';
SET PASSWORD FOR 'donald'@'%' = PASSWORD('duck');
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%';
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES; # if modified PRIVILEGES through an insert update or delete statement instead of a grant, revoke, set password or rename user

begin; update low_priority problem set r_eventid=640652792 where  eventid=640652792 limit 5;

select lower('UPPERCASE');
select lcase('lowercase UPPERCASE');
select upper('lowercase UPPERCASE');
select ucase('lowercase UPPERCASE');
create user 'mrowncloud'@'localhost' identified by 'habon123.';
drop user mrowncloud;
grant all on mrowncloud.* to mrowncloud;
create user root_ansible@127.0.0.1 identified by 'square-root-minus-one';
grant all privileges on *.* to root_ansible@127.0.0.1 with grant option; flush privileges;
grant all on zabbix20211230.* to root_ansible@127.0.0.1;
grant all on zabbix20211230.* to root_ansible@localhost;

select distinct(mt) from mt where cast(mt as signed integer) < 100;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY 'MyNewPass';
ALTER TABLE tablename MODIFY columnname VARCHAR(20) ;
```



# https://dev.mysql.com/doc/refman/5.5/en/old-client.html
Client does not support authentication protocol requested by server
```sql
SET PASSWORD FOR 'some_user'@'some_host' = OLD_PASSWORD('new_password');
ALTER USER 'fw'@'10.1.1.120' IDENTIFIED WITH mysql_native_password BY 'fwpass';
```

mysql -U -h 127.0.0.1 -u root --password=mypasswordislongerasyours repository_sd2 <<<"select * from (select count(1) as co, formatbasic FROM SUBFIELD where \`release\` = '20171222' and formatbasic regexp '.*[0-9]{2,}.*' group by formatbasic) mralias where co > 35 order by formatbasic;"

```sql

-- disk usage by table
SELECT table_schema as `Database`,
     table_name AS `Table`,
     round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB`
FROM information_schema.TABLES
ORDER BY (data_length + index_length) DESC;



concat_ws("concat with first arg as word separator", "first word", "second word", ...)
concat("first word", "second word")


INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);
INSERT INTO table_name VALUES (value1, value2, value3, ...);

select Host, User, password from mysql.user \G; -- vertical line alignement (the \G at the end of the query does the trick)

desc c01_templatecachequeries;

show index from table_name from db_name; -- index indices
show index from db_name.table_name; -- index indices
select distinct table_name, index_name from information_schema.statistics where table_schema = `schema_name`; -- index indices
select distinct table_name, index_name from information_schema.statistics where table_name in ("bip", "bop"); -- index indices

create table bip as select * from bop limit 0; -- clone table without indices
create table bip as select * from bop;         -- clone table without indices
create table bip like bop;                     -- clone table with primary key index, without data, with partitions
show create table bip; -- table DDL (withouth index)
show table status; -- quickly see if tables have indice/index, are partitioned, when they've been created and updated

select "random select query to be further editor in $EDITOR as it contains backslash e" \e;
pager  vim -c 'set buftype=nofile nomod nowrap nolist nonumber ft=sql syntax=sql' -;
pager less --raw-control-chars --quit-if-one-screen --ignore-case --status-column --no-init;
pager less --raw-control-chars --quit-if-one-screen --ignore-case --status-column --no-init --chop-long-lines; -- truncate lines instead of wrapping
pager more

select UNIX_TIMESTAMP(); -- now
select UNIX_TIMESTAMP("2021-04-15 00:00:00"); -- 1618444800
SELECT UNIX_TIMESTAMP('2021-11-27 12:35:03.123456') AS Result; -- as a float
select date_format(from_unixtime(clock), "%Y.%m.%d %H:%i:%s") from bip; -- https://www.w3schools.com/sql/func_mysql_date_format.asp


Alter table Empolyee disable constraint pk_EmpNumer;
SHOW CREATE TABLE zabbix5.event_recovery; -- list constraints

CREATE TABLE bip (
    Personid int NOT NULL AUTO_INCREMENT,
    Age int,
    PRIMARY KEY (Personid)
);
timestamp(DATE_SUB(NOW(), INTERVAL 30 MINUTE))
SELECT * FROM x WHERE ts BETWEEN NOW() - INTERVAL 30 MINUTE AND NOW();


alter table `bip` partition by range (clock) (partition p0 values less than (0) engine = innodb); -- (re-)init partitioning for empty table. WARN: will destroy current partitions

alter table `bip` partition by range (clock) (
  partition p2021_04_14 values less than (unix_timestamp("2021-04-15 00:00:00")) engine = innodb,
  partition p2021_04_15 values less than (unix_timestamp("2021-04-16 00:00:00")) engine = innodb
  );

alter table `bip` add partition (partition p2021_04_15 values less than (unix_timestamp("2021-04-16 00:00:00")) engine = innodb);
alter table `bip` add partition (partition future values less than maxvalue engine = innodb);
alter table `bip` reorganize partition future into (partition p2021_04_15 values less than (unix_timestamp("2021-04-16 00:00:00")) engine = innodb, partition future values less than maxvalue engine = innodb);
alter table e2 remove partitioning; -- halt stop drop
select count(1) from trends_uint partition(p2020_05);

rename table foo to foo_old, foo_new to foo; -- swap exchange switch tables

show variables like 'lock_wait_timeout'; -- see session duration for aquiring table / metadata lock
set lock_wait_timeout=10;

kill 35; -- kill session 35
show engine innodb status; -- as root, better for looking at locks

select id, db, command, time, state, info from information_schema.processlist;
show processlist; -- list sessions connections
show full processlist; -- see full query
show privileges; -- dislay list of available privileges
show grant for user@127.0.0.1;

alter database craft character set utf8 collate utf8_general_ci;

show variables like '%char%'; -- character set
-- character_set_client     | latin1                     |
-- character_set_connection | latin1                     |
-- character_set_database   | utf8mb4                    |
-- character_set_filesystem | binary                     |
-- character_set_results    | latin1                     |
-- character_set_server     | utf8mb4                    |
-- character_set_system     | utf8mb3

select nvl(null,7); # coalesce
select nvl('',8); # coalesce
select isnull(null); -> 1
select isnull(''); -> 0
select isnull('a'); -> 0
select isnull(5); -> 0
select if(null is null, "was null", "wasnt null");
select if(5 is null, "was null", "wasnt null");

```

# regexp
```sql
-- a priori no standard character classes in mysql regexp, use standard custem [a-zA-Z0-9_.-]
regexp_replace(original_value, pattern, replacement[, pos[, occurrence[, match_type]]])
select regexp_substr(headers, '(?<=Date: ).*') as c from email_sources; -- extract date from email header, https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-substr
```

# safe mode
```sql
SET SQL_SAFE_UPDATES=0;


# Mysql binary logs
myslq-bin.003172
myslq-bin.index
https://dba.stackexchange.com/questions/41050/is-it-safe-to-delete-mysql-bin-files

```ini
# /etc/my.cnf.d/server.cnf or /etc/my.cnf
[mysqld]
expire_logs_days=3
```
```sql
optimize table auditlog; # bip
--alter table trends_uint optimize partition p2021_12; do not use as it rebuilds entire table, use rebuild + analyze instead
alter table trends_uint rebuild partition p2021_12; alter table trends_uint analyze partition p2021_12;
```

```sql
set global expire_logs_days = 3;
purge binary logs to 'mysql-bin.000223';
show variables where variable_name like 'expire%';
show variables where variable_name = 'expire_logs_days';
show variables where variable_name = 'hostname'; -- ip address
show variables where variable_name = 'port';
```

# replication
https://www.abelworld.com/mysql-slave-master-switch/

# json query
WARNING json_query can't be used to query string or int (scalars)
use json_value instead
https://mariadb.com/kb/en/json-functions/ -- json-query

# query logging
https://stackoverflow.com/questions/303994/log-all-queries-in-mysql
## file logging
```sql
set global log_output = 'FILE';
set global general_log_file='/var/log/mysql/query-logging.log';
set global general_log = 1; -- start logging
set global general_log = 0; -- turn off logging
-- /\<\(insert\|replace\|delete\|update\)\>  vim search for update
 nohup sh -c 'tail -f /var/log/mysql/query-logging.log | ts >> /var/log/mysql/query-logging.log.ts' < /dev/null &>/dev/null & # for timestamp'ed logs
```
## table logging
https://stackoverflow.com/a/14403905

## vim mode
echo 'set editing-mode vi' | docker exec -i mariadb tee -a /etc/inputrc
echo 'set editing-mode vi' | tee -a /etc/inputrc

## gzip'ed column
db.sh --binary-as-hex --skip-column-names -B <<< "select data from blobs_storage where blob_id = '774'" | xxd -r -p | gunzip # gzip hex binary

## with update
```sql
create table hehe (id int, value varchar(255)); insert into hehe values(1, 'one'), (2, 'two');
with a as (select 1 id) update hehe inner join a on hehe.id = a.id set value ='updated';
```

# mysql schedule
```sql
-- activate mysql scheduler for k8s zabbix partitioning
set global event_scheduler = on;
show variables like 'event_scheduler';
show create event e_zbx_part_mgmt\G;
create or replace table debug_scheduler (id int not null auto_increment, value varchar(255), clock timestamp default now(), primary key (id));
delimiter |
create or replace event debug_scheduler on schedule every 5 second do begin insert into debug_scheduler (value) values (5); end |
delimiter ;
show events;
select * from debug_scheduler order by id desc limit 10;
drop event debug_scheduler; drop table debug_scheduler;
```

```sh
mysqldump -h mariad.lan -u root -pblabla --single-transaction                       --databases haha # column-statistics is a mysql 8.0 thing, not compatible with mariadb
mysqldump -h mariad.lan -u root -pblabla --single-transaction --column-statistics=0 --databases haha # column-statistics is a mysql 8.0 thing, not compatible with mariadb
mysqldump --no-data
```

# docker
```sh
https://github.com/docker-library/docs/tree/master/mariadb
https://github.com/mariadb/mariadb-docker
https://hub.docker.com/_/mariadb
https://hub.docker.com/_/mysql
```sh
