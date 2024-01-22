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
show full tables where table_type like 'VIEW'; -- show views
show full tables in database_name where table_type like 'VIEW'; -- show views
desc mytable; -- show table schema
create database bip;
HOW GRANTS for someuser_dbuser@localhost;
select user, host, password from mysql.user order by user, host;
CREATE USER 'donald'@'%' IDENTIFIED BY password('duck');
CREATE USER 'donald'@'%' IDENTIFIED BY 'duck'; -- plain text value
CREATE USER 'donald'@'%' IDENTIFIED BY passsword '*8656F71D1D5128F9BD83D4A2EB09241B71D2BE3B'; -- hash value
CREATE USER 'donald' IDENTIFIED BY 'duck';
drop USER 'donald'@'%';
SET PASSWORD FOR 'donald'@'%' = PASSWORD('duck');
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%';
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES; # if modified PRIVILEGES through an insert update or delete statement instead of a grant, revoke, set password or rename user

begin; update low_priority problem set r_eventid=640652792 where  eventid=640652792 limit 5;

select sleep(5);
do sleep(5);

select current_user() as authenticated_name, user() as tried_logon_name;  -- whoami

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

create user ansible@127.0.0.1 identified by 'square-root-minus-one';

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

select * from mysql.user order by user, host \G -- vertical line alignement (the \G at the end of the query does the trick)

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
select itemid, date_format(from_unixtime(clock), "%Y.%m.%d %H:%i:%s"), num, value_min, value_avg, value_max from trends_uint where itemid = 29020;

select now(); -- today date datetime
select curdate(); -- today date datetime


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
alter table history_str reorganize partition future into ( PARTITION `p2023_07_27` VALUES LESS THAN (1690416000) COMMENT = 'SF created on 2023.07.25 22:28:01' ENGINE = InnoDB, PARTITION `p2023_07_28` VALUES LESS THAN (1690502400) COMMENT = 'SF created on 2023.07.26 22:28:01' ENGINE = InnoDB, PARTITION `p2023_07_29` VALUES LESS THAN (1690588800) COMMENT = 'SF created on 2023.07.27 22:28:02' ENGINE = InnoDB, PARTITION `p2023_07_30` VALUES LESS THAN (1690675200) COMMENT = 'SF created on 2023.07.28 22:28:01' ENGINE = InnoDB, PARTITION `p2023_07_31` VALUES LESS THAN (1690761600) COMMENT = 'SF created on 2023.07.29 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_01` VALUES LESS THAN (1690848000) COMMENT = 'SF created on 2023.07.30 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_02` VALUES LESS THAN (1690934400) COMMENT = 'SF created on 2023.07.31 22:28:02' ENGINE = InnoDB, PARTITION `p2023_08_03` VALUES LESS THAN (1691020800) COMMENT = 'SF created on 2023.08.01 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_04` VALUES LESS THAN (1691107200) COMMENT = 'SF created on 2023.08.02 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_05` VALUES LESS THAN (1691193600) COMMENT = 'SF created on 2023.08.03 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_06` VALUES LESS THAN (1691280000) COMMENT = 'SF created on 2023.08.04 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_07` VALUES LESS THAN (1691366400) COMMENT = 'SF created on 2023.08.05 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_08` VALUES LESS THAN (1691452800) COMMENT = 'SF created on 2023.08.06 22:28:01' ENGINE = InnoDB, PARTITION `p2023_08_09` VALUES LESS THAN (1691539200) COMMENT = 'SF created on 2023.08.07 22:28:01' ENGINE = InnoDB, PARTITION `future` VALUES LESS THAN MAXVALUE ENGINE = InnoDB);
alter table history_uint drop partition p2023_08_09_13;
alter table e2 remove partitioning; -- halt stop drop
select count(1) from trends_uint partition(p2020_05);

rename table foo to foo_old, foo_new to foo; -- swap exchange switch tables

show variables like 'lock_wait_timeout'; -- see session duration for aquiring table / metadata lock
set lock_wait_timeout=10;

Select concat('KILL ',id,';') from information_schema.processlist where user='user';
Select concat('KILL ',id,';') from information_schema.processlist where host like '10.101.6.101:%' and time > 300;
kill 35; -- kill session 35
show engine innodb status; -- as root, better for looking at locks

select id, db, command, time, state, info from information_schema.processlist;
select id, db, command, time, state, info from information_schema.processlist where time > 300;
select id, db, command, time, state, info from information_schema.processlist where command not in ('Sleep') order by time asc;
show processlist; -- list sessions connections
show full processlist; -- see full query
show privileges; -- dislay list of available privileges
show grants for user@127.0.0.1;
show grants for 'root'@'localhost';
show grants for 'root'@'127.0.0.1';

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
regexp_like appear to not exist in mariadb
where regexp_replace('str', 't', 'SUCCESS') like '%SUCCESS%';
where regexp_replace(name, 'core\.(app|deskpro|install)', 'SUCCESS') like '%SUCCESS%';
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

## master slave switch
https://www.abelworld.com/mysql-slave-master-switch/
* check if replication user for current master exists on current slave
  select user, host, concat_ws('@', user, host) as userathost password from mysql.user order by user, host;
* change my.cnf on both hosts, but do not restart services
-read_only
-relay-log = relay-bin
-relay-log-index = relay-bin.index
+log_bin = mysql-bin
+log-bin-index = mysql-bin.index
+expire_logs_days = 5
+max_binlog_size = 100M
+binlog_format = ROW
+binlog_do_db = db1
+binlog_do_db = db2

* optional if you feel like it create a dummy table
create table if not exists dummy (id int not null auto_increment primary key, ts timestamp default current_timestamp, d varchar(255));
insert into dummy (d) values ('node1 is master');


* make sure no application can write to database
  either by stopping all write applications
  or dropping all traffic to 3306 except the slave /master
  /sbin/iptables -I INPUT 1 -p tcp --destination-port 3306 -j DROP
  /sbin/iptables -I INPUT 1 -p tcp -s 10.1.1.2 --destination-port 3306 -j ACCEPT
* on node1 make master read-only  and flush data
  set global read_only=ON; flush tables; flush logs; show variables like '%read_only%';
* on node1 check master status
  show master status\G
* on node2 stop slave
  stop slave;
  reset slave all;
  reset master;
* on node2 make slave writable
  set global read_only=OFF; show variables like '%read_only%';
  insert into dummy (d) values ('node2 is master');
  show slave status\G
  show master status\G
* on node1 make node2 the new master
  change master to master_host='10.1.1.2', master_user='repl', master_password='123';
  start slave;
* check slave status
  show slave status\G
  select * from dummy order by id desc limit 10;
* restart services and check slave status again


# json query
WARNING json_query can't be used to query string or int (scalars)
use json_value instead
https://mariadb.com/kb/en/json-functions/ -- json-query

# query logging
https://stackoverflow.com/questions/303994/log-all-queries-in-mysql
## file logging
```sql
set global log_output = 'TABLE';

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
show create event e_zbx_part_mgmt\G
create or replace table debug_scheduler (id int not null auto_increment, value varchar(255), clock timestamp default now(), primary key (id));
delimiter |
create or replace event debug_scheduler on schedule every 5 second do begin insert into debug_scheduler (value) values (5); end |
delimiter ;
show events;
select * from debug_scheduler order by id desc limit 10;
drop event debug_scheduler; drop table debug_scheduler;
```

# stop server
```sql
shutdown -- stops server
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
https://github.com/mariadb/server
https://hub.docker.com/_/mariadb
https://hub.docker.com/_/mysql
```sh


# high-availibility master-slave HA
```sql
show slave status\G
show master status\G
```

# repair/fix broken replication
```sql
stop slave;
change master to master_log_file = 'mysql-bin.126924', MASTER_LOG_POS = 1;
start slave;
stop slave;
set global sql_slave_skip_counter = 1;
start slave;
stop slave; set global sql_slave_skip_counter = 1; start slave; select sleep(5); show slave status\G
```

substring('str', 1, 10) WARNING, index is 1-based and returns empty on mariadb if 0 is used

# release dates
```sh
cd ~/tmp
git clone https://github.com/mariadb/server
cd server
git for-each-ref --sort=-creatordate --format '%(creatordate:iso) %(refname)' refs/tags
```
2023-02-22 15:40:26 -0500 refs/tags/mariadb-11.0.1
2023-02-16 10:44:08 -0500 refs/tags/mariadb-10.11.2
2023-02-06 09:07:28 -0500 refs/tags/mariadb-10.10.3
2023-02-06 09:06:45 -0500 refs/tags/mariadb-10.9.5
2023-02-06 09:05:57 -0500 refs/tags/mariadb-10.8.7
2023-02-06 09:05:07 -0500 refs/tags/mariadb-10.7.8
2023-02-06 09:04:29 -0500 refs/tags/mariadb-10.6.12
2023-02-06 09:03:57 -0500 refs/tags/mariadb-10.5.19
2023-02-06 09:03:04 -0500 refs/tags/mariadb-10.4.28
2023-02-06 09:01:21 -0500 refs/tags/mariadb-10.3.38
2022-11-16 10:23:49 -0500 refs/tags/mariadb-10.11.1
2022-11-16 10:22:37 -0500 refs/tags/mariadb-10.10.2-release
2022-11-07 09:43:23 -0500 refs/tags/mariadb-10.10.2
2022-11-07 09:42:49 -0500 refs/tags/mariadb-10.9.4
2022-11-07 09:42:09 -0500 refs/tags/mariadb-10.8.6
2022-11-07 09:41:34 -0500 refs/tags/mariadb-10.7.7
2022-11-07 09:40:55 -0500 refs/tags/mariadb-10.6.11
2022-11-07 09:16:46 -0500 refs/tags/mariadb-10.5.18
2022-11-07 08:34:30 -0500 refs/tags/mariadb-10.4.27
2022-11-07 08:07:32 -0500 refs/tags/mariadb-10.3.37
2022-09-19 09:36:06 -0400 refs/tags/mariadb-10.9.3
2022-09-19 09:35:44 -0400 refs/tags/mariadb-10.8.5
2022-09-19 09:35:03 -0400 refs/tags/mariadb-10.7.6
2022-09-19 09:34:16 -0400 refs/tags/mariadb-10.6.10
2022-08-15 02:48:37 -0400 refs/tags/mariadb-10.10.1
2022-08-15 01:44:14 -0400 refs/tags/mariadb-10.9.2
2022-08-15 00:55:10 -0400 refs/tags/mariadb-10.8.4
2022-08-15 00:27:02 -0400 refs/tags/mariadb-10.7.5
2022-08-14 23:30:42 -0400 refs/tags/mariadb-10.6.9
2022-08-14 22:52:34 -0400 refs/tags/mariadb-10.5.17
2022-08-14 22:18:27 -0400 refs/tags/mariadb-10.4.26
2022-08-14 21:43:40 -0400 refs/tags/mariadb-10.3.36
2022-05-20 13:18:56 -0400 refs/tags/mariadb-10.9.1
2022-05-20 13:16:56 -0400 refs/tags/mariadb-10.8.3
2022-05-20 10:57:35 -0400 refs/tags/mariadb-10.7.4
2022-05-20 10:57:15 -0400 refs/tags/mariadb-10.6.8
2022-05-20 10:56:52 -0400 refs/tags/mariadb-10.5.16
2022-05-20 10:56:31 -0400 refs/tags/mariadb-10.4.25
2022-05-20 10:56:01 -0400 refs/tags/mariadb-10.3.35
2022-05-20 10:53:41 -0400 refs/tags/mariadb-10.2.44
2022-02-12 15:42:37 -0500 refs/tags/mariadb-10.2.43
2022-02-12 15:17:27 -0500 refs/tags/mariadb-10.3.34
2022-02-12 14:59:47 -0500 refs/tags/mariadb-10.4.24
2022-02-12 14:24:16 -0500 refs/tags/mariadb-10.5.15
2022-02-12 13:57:09 -0500 refs/tags/mariadb-10.6.7
2022-02-12 13:38:44 -0500 refs/tags/mariadb-10.7.3
2022-02-12 13:07:19 -0500 refs/tags/mariadb-10.8.2
2022-02-08 18:32:57 -0500 refs/tags/mariadb-10.8.1
2022-02-08 18:14:32 -0500 refs/tags/mariadb-10.7.2
2022-02-08 17:50:49 -0500 refs/tags/mariadb-10.6.6
2022-02-08 17:30:59 -0500 refs/tags/mariadb-10.5.14
2022-02-08 17:09:37 -0500 refs/tags/mariadb-10.4.23
2022-02-08 16:46:47 -0500 refs/tags/mariadb-10.3.33
2022-02-08 16:27:15 -0500 refs/tags/mariadb-10.2.42
2021-11-08 12:55:30 -0500 refs/tags/mariadb-10.3.32
2021-11-08 12:38:50 -0500 refs/tags/mariadb-10.4.22
2021-11-08 12:20:23 -0500 refs/tags/mariadb-10.5.13
2021-11-08 12:02:51 -0500 refs/tags/mariadb-10.6.5
2021-11-08 11:35:20 -0500 refs/tags/mariadb-10.7.1
2021-11-08 11:23:24 -0500 refs/tags/mariadb-10.2.41
2021-08-05 10:41:54 -0400 refs/tags/mariadb-10.6.4
2021-08-05 10:17:02 -0400 refs/tags/mariadb-10.5.12
2021-08-05 09:58:25 -0400 refs/tags/mariadb-10.4.21
2021-08-05 09:34:33 -0400 refs/tags/mariadb-10.3.31
2021-08-05 09:10:12 -0400 refs/tags/mariadb-10.2.40
2021-07-05 12:44:09 +0200 refs/tags/mariadb-10.6.3
2021-06-18 10:55:46 +0200 refs/tags/mariadb-10.5.11
2021-06-17 19:30:25 +0200 refs/tags/mariadb-10.6.2
2021-06-09 14:28:57 +0300 refs/tags/mariadb-10.4.20
2021-06-09 14:23:20 +0300 refs/tags/mariadb-10.3.30
2021-06-08 13:21:33 +0300 refs/tags/mariadb-10.2.39
2021-05-21 01:00:37 +0200 refs/tags/mariadb-10.6.1
2021-05-05 23:57:11 +0300 refs/tags/mariadb-10.5.10
2021-05-05 23:06:12 +0300 refs/tags/mariadb-10.4.19
2021-05-05 17:21:05 +0200 refs/tags/mariadb-10.3.29
2021-05-04 16:55:45 +0200 refs/tags/mariadb-10.2.38
2021-04-23 10:07:08 +0300 refs/tags/mariadb-10.6.0
2021-02-19 10:37:51 +0100 refs/tags/mariadb-10.5.9
2021-02-19 00:19:42 +0100 refs/tags/mariadb-10.4.18
2021-02-18 22:09:53 +0100 refs/tags/mariadb-10.3.28
2021-02-18 19:03:01 +0100 refs/tags/mariadb-10.2.37
2020-11-10 14:09:05 +0100 refs/tags/mariadb-10.5.8
2020-11-10 11:24:13 +0100 refs/tags/mariadb-10.4.17
2020-11-10 12:29:20 +0300 refs/tags/mariadb-10.3.27
2020-11-09 13:51:32 -0800 refs/tags/mariadb-10.2.36
2020-11-03 12:41:41 +0200 refs/tags/mariadb-10.5.7
2020-11-02 01:29:52 +0200 refs/tags/mariadb-10.4.16
2020-11-01 02:56:29 +0200 refs/tags/mariadb-10.3.26
2020-10-31 19:49:24 +0200 refs/tags/mariadb-10.2.35
2020-10-30 02:47:21 +0200 refs/tags/mariadb-10.1.48
2020-10-05 18:31:57 +0200 refs/tags/mariadb-10.5.6
2020-10-05 18:18:05 +0200 refs/tags/mariadb-10.4.15
2020-10-05 18:05:38 +0200 refs/tags/mariadb-10.3.25
2020-10-05 17:53:10 +0200 refs/tags/mariadb-10.2.34
2020-10-05 17:52:00 +0200 refs/tags/mariadb-10.1.47
2020-08-07 13:43:08 +0200 refs/tags/mariadb-10.5.5
2020-08-06 17:13:02 +0200 refs/tags/mariadb-10.4.14
2020-08-06 17:01:44 +0200 refs/tags/mariadb-10.3.24
2020-08-06 16:47:39 +0200 refs/tags/mariadb-10.2.33
2020-08-06 14:02:01 +0200 refs/tags/mariadb-10.1.46
2020-06-23 17:07:03 +0200 refs/tags/mariadb-10.5.4
2020-05-11 16:23:46 +0200 refs/tags/mariadb-10.5.3
2020-05-09 22:20:04 +0300 refs/tags/mariadb-10.4.13
2020-05-09 20:20:02 +0200 refs/tags/mariadb-10.3.23
2020-05-08 13:38:36 +0200 refs/tags/mariadb-10.2.32
2020-05-08 09:19:44 +0200 refs/tags/mariadb-10.1.45
2020-05-06 13:47:55 +0300 refs/tags/mariadb-5.5.68
2020-03-25 12:09:47 +0200 refs/tags/mariadb-10.5.2
2020-02-13 18:59:38 +0100 refs/tags/mariadb-10.5.1
2020-01-26 22:39:52 +0200 refs/tags/mariadb-10.4.12
2020-01-26 20:34:09 +0200 refs/tags/mariadb-10.3.22
2020-01-26 18:40:22 +0200 refs/tags/mariadb-10.2.31
2020-01-25 23:50:41 +0200 refs/tags/mariadb-10.1.44
2020-01-18 00:05:16 +0100 refs/tags/mariadb-5.5.67
2019-12-10 15:43:56 +0200 refs/tags/mariadb-10.4.11
2019-12-06 00:18:10 +0200 refs/tags/mariadb-10.3.21
2019-12-05 01:28:11 +0200 refs/tags/mariadb-10.2.30
2019-11-25 15:02:08 +0100 refs/tags/mariadb-10.5.0
2019-11-07 07:39:55 +0200 refs/tags/mariadb-10.4.10
2019-11-06 17:56:56 +0200 refs/tags/mariadb-10.3.20
2019-11-06 13:01:34 +0200 refs/tags/mariadb-10.2.29
2019-11-06 08:17:03 +0200 refs/tags/mariadb-10.1.43
2019-11-03 20:41:47 +0200 refs/tags/mariadb-10.4.9
2019-11-03 17:59:48 +0200 refs/tags/mariadb-10.3.19
2019-10-31 20:42:08 +0200 refs/tags/mariadb-10.2.28
2019-10-31 18:07:19 +0200 refs/tags/mariadb-10.1.42
2019-10-30 14:44:56 +0100 refs/tags/mariadb-5.5.66
2019-09-08 23:58:53 +0300 refs/tags/mariadb-10.4.8
2019-09-08 19:49:40 +0300 refs/tags/mariadb-10.3.18
2019-09-08 16:21:48 +0300 refs/tags/mariadb-10.2.27
2019-07-30 14:28:46 +0300 refs/tags/mariadb-10.4.7
2019-07-28 03:14:33 +0300 refs/tags/mariadb-10.3.17
2019-07-27 00:19:28 +0300 refs/tags/mariadb-10.2.26
2019-07-26 18:17:55 +0300 refs/tags/mariadb-10.1.41
2019-07-25 16:36:32 +0200 refs/tags/mariadb-5.5.65
2019-06-17 23:41:43 +0200 refs/tags/mariadb-10.4.6
2019-06-15 01:21:40 +0300 refs/tags/mariadb-10.3.16
2019-06-14 21:23:53 +0300 refs/tags/mariadb-10.2.25
2019-05-20 09:38:08 +0200 refs/tags/mariadb-10.4.5
2019-05-13 20:53:34 +0300 refs/tags/mariadb-10.3.15
2019-05-08 07:01:20 +0300 refs/tags/mariadb-10.2.24
2019-05-07 16:41:07 -0400 refs/tags/mariadb-10.1.40
2019-04-30 23:58:14 +0300 refs/tags/mariadb-10.1.39
2019-04-26 15:31:31 +0300 refs/tags/mariadb-5.5.64
2019-04-06 12:33:51 +0300 refs/tags/mariadb-10.4.4
2019-04-01 16:58:37 +0300 refs/tags/mariadb-10.3.14
2019-03-23 14:33:36 +0100 refs/tags/mariadb-10.2.23
2019-02-24 15:58:17 +0100 refs/tags/mariadb-10.4.3
2019-02-20 08:44:08 +0100 refs/tags/mariadb-10.3.13
2019-02-10 00:21:43 +0100 refs/tags/mariadb-10.2.22
2019-02-04 18:55:35 +0200 refs/tags/mariadb-10.1.38
2019-02-01 13:41:23 +0200 refs/tags/mariadb-galera-10.0.38
2019-01-31 14:00:22 +0200 refs/tags/mariadb-galera-5.5.63
2019-01-29 20:33:43 +0200 refs/tags/mariadb-10.0.38
2019-01-28 14:41:39 +0100 refs/tags/mariadb-10.4.2
2019-01-27 18:54:12 +0100 refs/tags/mariadb-5.5.63
2019-01-04 17:25:19 +0200 refs/tags/mariadb-10.3.12
2018-12-30 18:30:29 +0100 refs/tags/mariadb-10.2.21
2018-12-21 19:45:30 +0100 refs/tags/mariadb-10.2.20
2018-12-18 16:38:08 +0100 refs/tags/mariadb-10.4.1
2018-11-16 19:58:52 +0200 refs/tags/mariadb-10.3.11
2018-11-12 18:19:31 +0200 refs/tags/mariadb-10.2.19
2018-11-08 10:19:55 +0200 refs/tags/mariadb-10.4.0
2018-11-01 10:49:53 +0200 refs/tags/mariadb-galera-10.0.37
2018-10-31 23:48:29 +0200 refs/tags/mariadb-10.1.37
2018-10-30 18:15:58 +0200 refs/tags/mariadb-10.0.37
2018-10-29 18:45:19 +0200 refs/tags/mariadb-galera-5.5.62
2018-10-24 11:09:16 +0200 refs/tags/mariadb-5.5.62
2018-10-02 13:42:44 +0400 refs/tags/mariadb-10.3.10
2018-09-25 02:45:40 +0300 refs/tags/mariadb-10.2.18
2018-09-07 16:49:39 +0300 refs/tags/mariadb-10.1.36
2018-08-20 13:32:37 +0200 refs/tags/mysql-5.5.62
2018-08-14 03:35:06 +0300 refs/tags/mariadb-10.3.9
2018-08-12 14:25:53 +0300 refs/tags/mariadb-10.2.17
2018-08-04 22:53:16 +0100 refs/tags/mariadb-10.1.35
2018-08-04 11:28:25 +0300 refs/tags/mariadb-galera-10.0.36
2018-08-02 10:37:03 +0300 refs/tags/mariadb-galera-5.5.61
2018-07-31 15:19:01 +0300 refs/tags/mariadb-10.0.36
2018-07-30 15:32:22 +0300 refs/tags/mariadb-5.5.61
2018-07-02 09:30:10 +0200 refs/tags/mariadb-10.3.8
2018-06-25 14:04:16 +0300 refs/tags/mariadb-10.2.16
2018-06-16 01:20:44 +0200 refs/tags/mariadb-10.1.34
2018-06-15 18:31:38 +0200 refs/tags/mysql-5.5.61
2018-05-23 23:31:21 +0300 refs/tags/mariadb-10.3.7
2018-05-16 23:24:14 +0200 refs/tags/mariadb-10.2.15
2018-05-08 09:33:48 +0300 refs/tags/mariadb-galera-10.0.35
2018-05-08 02:13:07 +0300 refs/tags/mariadb-10.1.33
2018-05-01 11:50:34 +0200 refs/tags/mariadb-galera-5.5.60
2018-05-01 11:47:43 +0200 refs/tags/mariadb-10.0.35
2018-04-20 01:04:43 +0200 refs/tags/mariadb-5.5.60
2018-04-13 21:46:24 +0200 refs/tags/mariadb-10.3.6
2018-03-26 19:36:39 +0300 refs/tags/mariadb-10.2.14
2018-03-26 17:14:08 +0300 refs/tags/mariadb-10.1.32
2018-02-26 14:37:39 +0530 refs/tags/mysql-5.5.60
2018-02-25 21:08:19 +0400 refs/tags/mariadb-10.3.5
2018-02-12 16:56:01 +0200 refs/tags/mariadb-10.2.13
2018-02-04 04:28:14 +0200 refs/tags/mariadb-10.1.31
2018-02-01 14:09:48 +0200 refs/tags/mariadb-galera-10.0.34
2018-01-27 20:37:09 +0200 refs/tags/mariadb-10.0.34
2018-01-19 20:08:03 +0200 refs/tags/mariadb-galera-5.5.59
2018-01-18 17:56:28 +0100 refs/tags/mariadb-5.5.59
2018-01-17 00:45:02 +0100 refs/tags/mariadb-10.3.4
2018-01-03 11:56:24 +0200 refs/tags/mariadb-10.2.12
2017-12-22 22:12:52 +0200 refs/tags/mariadb-10.3.3
2017-12-21 17:40:01 +0200 refs/tags/mariadb-10.1.30
2017-11-27 12:04:51 +0200 refs/tags/mariadb-10.2.11
2017-11-27 14:51:04 +0530 refs/tags/mysql-5.5.59
2017-11-13 18:41:55 +0000 refs/tags/mariadb-10.1.29
2017-11-08 17:22:11 +0200 refs/tags/mariadb-galera-10.0.33
2017-10-30 10:06:47 +0200 refs/tags/mariadb-10.2.10
2017-10-27 03:19:59 +0300 refs/tags/mariadb-10.0.33
2017-10-19 15:02:14 +0300 refs/tags/mariadb-galera-5.5.58
2017-10-17 11:04:09 +0200 refs/tags/mariadb-5.5.58
2017-10-06 12:28:56 +0200 refs/tags/mariadb-10.3.2
2017-09-27 10:22:15 +0200 refs/tags/mariadb-10.1.28
2017-09-25 09:29:27 +0300 refs/tags/mariadb-10.2.9
2017-09-22 17:54:23 +0300 refs/tags/mariadb-10.1.27
2017-09-13 20:45:34 +0530 refs/tags/mysql-5.5.58
2017-08-26 22:01:03 +0000 refs/tags/mariadb-10.3.1
2017-08-17 11:41:46 +0200 refs/tags/mariadb-10.2.8
2017-08-16 13:10:01 +0300 refs/tags/mariadb-galera-10.0.32
2017-08-09 16:15:30 +0300 refs/tags/mariadb-10.1.26
2017-08-04 09:32:40 +0200 refs/tags/mariadb-10.0.32
2017-07-24 20:24:03 +0300 refs/tags/mariadb-galera-5.5.57
2017-07-18 19:50:11 +0200 refs/tags/mariadb-5.5.57
2017-07-10 00:05:45 +0300 refs/tags/mariadb-10.2.7
2017-07-01 21:12:26 +0300 refs/tags/mariadb-10.1.25
2017-06-05 08:33:48 +0200 refs/tags/mysql-5.5.57
2017-06-01 16:40:57 +0530 refs/tags/mariadb-galera-10.0.31
2017-05-29 00:27:14 -0700 refs/tags/mariadb-10.1.24
2017-05-20 00:59:40 +0200 refs/tags/mariadb-10.0.31
2017-05-15 02:09:28 +0300 refs/tags/mariadb-10.2.6
2017-05-03 11:11:33 +0530 refs/tags/mariadb-galera-5.5.56
2017-05-02 08:09:16 +0300 refs/tags/mariadb-10.1.23
2017-04-30 15:06:01 +0400 refs/tags/mariadb-5.5.56
2017-04-27 12:24:30 +0530 refs/tags/mysql-5.5.56
2017-04-21 09:27:23 +0530 refs/tags/mariadb-galera-5.5.55
2017-04-13 21:39:05 +0200 refs/tags/mariadb-10.3.0
2017-04-11 10:18:04 -0400 refs/tags/mariadb-5.5.55
2017-04-04 22:00:03 +0300 refs/tags/mariadb-10.2.5
2017-03-21 14:26:19 +0530 refs/tags/mariadb-galera-10.0.30
2017-03-18 10:12:04 +0530 refs/tags/mysql-5.5.55
2017-03-11 20:59:52 +0200 refs/tags/mariadb-10.1.22
2017-03-06 21:50:42 +0200 refs/tags/mariadb-10.0.30
2017-02-16 09:18:46 +0200 refs/tags/mariadb-10.2.4
2017-01-17 20:17:35 +0100 refs/tags/mariadb-10.1.21
2017-01-13 13:57:17 -0500 refs/tags/mariadb-galera-10.0.29
2017-01-12 03:37:35 +0200 refs/tags/mariadb-10.0.29
2016-12-27 21:39:05 -0500 refs/tags/mariadb-galera-5.5.54
2016-12-22 13:02:32 +0100 refs/tags/mariadb-5.5.54
2016-12-22 14:02:27 +0400 refs/tags/mariadb-10.2.3
2016-12-14 19:20:17 +0000 refs/tags/mariadb-10.1.20
2016-11-28 17:26:28 +0530 refs/tags/mysql-5.5.54
2016-11-04 14:04:24 +0300 refs/tags/mariadb-10.1.19
2016-11-02 21:10:39 -0400 refs/tags/mariadb-galera-10.0.28
2016-10-27 19:07:55 +0200 refs/tags/mariadb-10.0.28
2016-10-17 12:10:12 -0400 refs/tags/mariadb-galera-5.5.53
2016-10-14 12:51:53 +0200 refs/tags/mariadb-5.5.53
2016-09-29 15:00:20 -0400 refs/tags/mariadb-10.1.18
2016-09-28 20:06:46 +0530 refs/tags/mysql-5.5.53
2016-09-25 17:29:10 -0700 refs/tags/mariadb-10.2.2
2016-09-19 12:12:33 -0400 refs/tags/mariadb-galera-5.5.52
2016-09-12 16:42:05 +0200 refs/tags/mariadb-5.5.52
2016-08-29 16:17:46 +0200 refs/tags/mariadb-10.1.17
2016-08-26 16:44:32 +0530 refs/tags/mysql-5.5.52
2016-08-25 21:19:25 -0400 refs/tags/mariadb-galera-10.0.27
2016-08-24 17:39:57 +0300 refs/tags/mariadb-10.0.27
2016-08-10 14:58:12 -0400 refs/tags/mariadb-galera-5.5.51
2016-08-09 23:34:44 +0300 refs/tags/mariadb-5.5.51
2016-07-14 03:55:33 +0300 refs/tags/mariadb-10.1.16
2016-07-07 10:53:11 +0530 refs/tags/mysql-5.5.51
2016-07-02 14:52:23 +0200 refs/tags/mariadb-10.2.1
2016-06-30 10:24:54 -0400 refs/tags/mariadb-galera-10.0.26
2016-06-29 16:50:53 -0400 refs/tags/mariadb-10.1.15
2016-06-23 12:54:38 -0400 refs/tags/mariadb-galera-5.5.50
2016-06-23 12:44:28 +0400 refs/tags/mariadb-10.0.26
2016-06-16 22:04:24 +0300 refs/tags/mariadb-5.5.50
2016-05-16 11:34:20 +0200 refs/tags/mysql-5.5.50
2016-05-08 13:37:12 +0300 refs/tags/mariadb-10.1.14
2016-04-29 16:59:25 -0400 refs/tags/mariadb-galera-10.0.25
2016-04-28 22:18:15 +0200 refs/tags/mariadb-10.0.25
2016-04-25 16:10:57 -0400 refs/tags/mariadb-galera-5.5.49
2016-04-20 20:25:46 +0200 refs/tags/mariadb-5.5.49
2016-04-16 20:43:54 +0300 refs/tags/mariadb-10.2.0
2016-03-24 09:45:28 +0100 refs/tags/mariadb-10.1.13
2016-02-26 11:53:56 +0530 refs/tags/mysql-5.5.49
2016-02-24 17:40:12 -0500 refs/tags/mariadb-galera-10.0.24
2016-02-24 17:18:53 +0300 refs/tags/mariadb-10.1.12
2016-02-17 15:50:01 -0500 refs/tags/mariadb-galera-5.5.48
2016-02-17 21:42:57 +0100 refs/tags/mariadb-10.0.24
2016-02-10 10:03:47 +0400 refs/tags/mariadb-5.5.48
2016-01-28 14:06:05 +0200 refs/tags/mariadb-10.1.11
2016-01-15 10:26:08 +0800 refs/tags/mysql-5.5.48
2015-12-23 16:22:48 +0100 refs/tags/mariadb-10.1.10
2015-12-23 09:51:32 -0500 refs/tags/mariadb-galera-10.0.23
2015-12-22 14:58:02 -0500 refs/tags/mariadb-galera-5.5.47
2015-12-16 19:39:00 +0400 refs/tags/mariadb-10.0.23
2015-12-09 17:11:55 +0100 refs/tags/mariadb-5.5.47
2015-11-20 19:49:16 -0500 refs/tags/mariadb-10.1.9
2015-11-16 12:39:56 -0500 refs/tags/mariadb-galera-10.0.22
2015-11-07 22:03:47 +0530 refs/tags/mysql-5.5.47
2015-10-28 13:13:45 +0100 refs/tags/mariadb-10.0.22
2015-10-15 18:25:54 +0400 refs/tags/mariadb-10.1.8
2015-10-15 05:47:06 -0400 refs/tags/mariadb-galera-5.5.46
2015-10-09 16:43:59 +0200 refs/tags/mariadb-5.5.46
2015-09-18 16:13:38 +0200 refs/tags/mysql-5.5.46
2015-09-08 17:46:03 -0400 refs/tags/mariadb-10.1.7
2015-08-14 14:59:43 -0400 refs/tags/mariadb-galera-10.0.21
2015-08-14 13:45:52 -0400 refs/tags/mariadb-galera-5.5.45
2015-08-05 20:07:46 +0200 refs/tags/mariadb-10.0.21
2015-08-04 23:42:44 +0200 refs/tags/mariadb-5.5.45
2015-07-23 15:48:26 +0200 refs/tags/mariadb-10.1.6
2015-06-25 15:04:44 +0200 refs/tags/mysql-5.5.45
2015-06-24 23:28:42 -0400 refs/tags/mariadb-galera-10.0.20
2015-06-23 13:48:39 -0400 refs/tags/mariadb-galera-5.5.44
2015-06-17 16:13:02 +0200 refs/tags/mariadb-10.0.20
2015-06-09 22:16:26 +0200 refs/tags/mariadb-5.5.44
2015-06-03 11:12:50 +0200 refs/tags/mariadb-10.1.5
2015-05-14 21:53:48 -0400 refs/tags/mariadb-galera-10.0.19
2015-05-12 17:05:57 -0400 refs/tags/mariadb-galera-5.5.43
2015-05-08 17:06:35 +0300 refs/tags/mariadb-10.0.19
2015-05-06 12:41:21 +0200 refs/tags/mariadb-10.0.18
2015-04-29 16:24:52 +0200 refs/tags/mariadb-5.5.43
2015-04-29 13:51:29 +0530 refs/tags/mysql-5.5.44
2015-04-12 10:48:20 +0200 refs/tags/mariadb-10.1.4
2015-03-07 22:56:33 -0500 refs/tags/mariadb-galera-5.5.42
2015-03-06 13:22:15 -0500 refs/tags/mariadb-galera-10.0.17
2015-02-27 09:14:35 +0100 refs/tags/mysql-5.5.43
2015-02-26 00:02:10 +0300 refs/tags/mariadb-10.1.3
2015-02-25 16:34:33 +0100 refs/tags/mariadb-10.0.17
2015-02-13 12:57:11 +0100 refs/tags/mariadb-5.5.42
2015-01-27 20:22:06 -0500 refs/tags/mariadb-galera-10.0.16
2015-01-25 16:16:25 +0100 refs/tags/mariadb-10.0.16
2015-01-06 21:23:21 +0100 refs/tags/mysql-5.5.42
2014-12-31 19:28:20 -0500 refs/tags/mariadb-galera-5.5.41
2014-12-19 11:44:03 +0100 refs/tags/mariadb-5.5.41
2014-12-10 06:24:56 -0500 refs/tags/mariadb-galera-10.0.15
2014-12-05 11:01:51 +0400 refs/tags/mariadb-10.1.2
2014-11-21 20:20:39 +0100 refs/tags/mariadb-10.0.15
2014-11-04 08:30:23 +0100 refs/tags/mysql-5.5.41
2014-10-16 00:30:29 +0200 refs/tags/mariadb-10.1.1
2014-10-14 18:04:04 -0400 refs/tags/mariadb-galera-5.5.40
2014-10-08 13:30:45 -0400 refs/tags/mariadb-galera-10.0.14
2014-10-08 09:35:00 +0200 refs/tags/mariadb-5.5.40
2014-09-24 15:41:42 +0200 refs/tags/mariadb-10.0.14
2014-09-08 11:33:55 +0200 refs/tags/mysql-5.5.40
2014-08-29 09:42:13 +0300 refs/tags/mariadb-galera-10.0.13
2014-08-15 18:41:36 -0400 refs/tags/mariadb-galera-5.5.39
2014-08-08 17:58:45 +0200 refs/tags/mariadb-10.0.13
2014-08-03 13:38:54 +0200 refs/tags/mariadb-5.5.39
2014-07-19 11:24:21 +0530 refs/tags/mysql-5.5.39
2014-07-01 02:47:25 +0400 refs/tags/mariadb-10.1.0
2014-06-26 12:11:12 -0400 refs/tags/mariadb-galera-10.0.12
2014-06-23 09:37:46 -0400 refs/tags/mariadb-galera-5.5.38
2014-06-12 10:57:03 +0200 refs/tags/mariadb-10.0.12
2014-06-09 16:13:30 -0400 refs/tags/mariadb-galera-10.0.11
2014-06-05 19:25:51 +0200 refs/tags/mariadb-5.5.38
2014-05-11 18:24:12 +0200 refs/tags/mysql-5.5.38
2014-05-10 23:42:01 +0200 refs/tags/mariadb-10.0.11
2014-04-25 18:23:14 -0400 refs/tags/mariadb-galera-5.5.37
2014-04-17 14:10:22 -0400 refs/tags/mariadb-galera-10.0.10
2014-04-15 13:20:26 +0300 refs/tags/mariadb-5.5.37
2014-04-02 22:35:12 -0400 refs/tags/mariadb-galera-10.0.7a
2014-03-29 17:32:46 +0100 refs/tags/mariadb-10.0.10
2014-03-20 18:33:23 -0400 refs/tags/mariadb-galera-5.5.36a
2014-03-14 19:46:27 +0100 refs/tags/mysql-5.5.37
2014-03-08 12:33:51 +0100 refs/tags/mariadb-10.0.9
2014-03-06 18:44:16 -0500 refs/tags/mariadb-galera-5.5.36
2014-02-26 14:39:06 -0500 refs/tags/tokudb-7.1.5
2014-02-26 14:39:06 -0500 refs/tags/tokudb-7.1.5-rc.4
2014-02-24 09:46:24 -0500 refs/tags/tokudb-7.1.5-rc.3
2014-02-22 22:51:20 +0100 refs/tags/mariadb-5.5.36
2014-02-21 19:57:19 -0500 refs/tags/tokumx-1.4.0+hotfix.0
2014-02-14 17:03:44 -0500 refs/tags/mariadb-galera-10.0.7
2014-02-14 12:08:18 -0500 refs/tags/tokudb-7.1.5-rc.2
2014-02-10 23:54:18 -0500 refs/tags/mariadb-galera-5.5.35
2014-02-07 12:58:10 -0500 refs/tags/tokudb-7.1.5-rc.1
2014-02-06 21:58:38 +0100 refs/tags/mariadb-10.0.8
2014-01-28 10:58:18 +0100 refs/tags/mariadb-5.5.35
2014-01-08 11:09:04 +0100 refs/tags/mysql-5.5.36
2014-01-06 10:52:35 +0530 refs/tags/clone-5.5.36-build
2013-12-23 10:29:25 +0100 refs/tags/mariadb-10.0.7
2013-12-11 21:09:18 +0100 refs/tags/mariadb-galera-5.5.34
2013-11-18 15:48:01 +0400 refs/tags/mariadb-5.5.34
2013-11-14 19:56:55 +0100 refs/tags/mariadb-10.0.6
2013-11-07 13:39:46 +0100 refs/tags/mariadb-10.0.5
2013-11-05 08:03:43 +0100 refs/tags/mysql-5.5.35
2013-11-01 16:52:21 +0100 refs/tags/clone-5.5.35-build
2013-11-01 16:39:19 +0100 refs/tags/clone-5.1.73-build
2013-11-01 16:39:19 +0100 refs/tags/mysql-5.1.73
2013-10-23 14:44:49 -0400 refs/tags/tokudb-ps-2
2013-10-16 10:07:41 -0400 refs/tags/tokudb-ps-1
2013-10-14 14:32:35 -0400 refs/tags/tokumx-1.3.0-rc.0
2013-10-14 14:32:35 -0400 refs/tags/tokumx-1.3.0-rc.1
2013-10-07 18:50:26 -0400 refs/tags/tokudb-7.1.0
2013-09-29 23:53:10 +0300 refs/tags/mariadb-galera-5.5.32a
2013-09-19 22:24:59 +0200 refs/tags/mariadb-5.5.33a
2013-09-16 21:21:15 +0200 refs/tags/mariadb-5.5.33
2013-09-09 20:07:12 +0200 refs/tags/mysql-5.1.72
2013-09-09 19:49:44 +0200 refs/tags/mysql-5.5.34
2013-08-27 23:40:49 +0300 refs/tags/mariadb-galera-5.5.32
2013-08-27 00:15:43 +0200 refs/tags/clone-5.5.34-build
2013-08-23 16:54:25 +0530 refs/tags/clone-5.1.72-build
2013-08-21 16:10:43 -0400 refs/tags/tokumx-1.2.0-rc.2
2013-08-15 18:15:32 +0400 refs/tags/mariadb-10.0.4
2013-07-17 17:03:59 +0300 refs/tags/mariadb-5.5.32
2013-07-15 13:41:27 +0200 refs/tags/mysql-5.5.33
2013-07-05 14:30:15 +0530 refs/tags/clone-5.5.33-build
2013-07-01 15:30:55 +0200 refs/tags/clone-5.1.71-build
2013-07-01 15:30:55 +0200 refs/tags/mysql-5.1.71
2013-06-10 08:40:25 +0200 refs/tags/mariadb-10.0.3
2013-05-30 16:04:30 -0700 refs/tags/tokumx-1.0.0-rc.0
2013-05-21 18:56:35 +0200 refs/tags/mariadb-5.5.31
2013-05-16 17:33:32 +0200 refs/tags/mysql-5.5.32
2013-05-13 15:26:11 +0200 refs/tags/mysql-5.1.70
2013-05-03 16:39:17 +0300 refs/tags/clone-5.5.32-build
2013-04-30 20:39:12 +0200 refs/tags/clone-5.1.70-build
2013-04-21 19:37:35 -0700 refs/tags/mariadb-10.0.2
2013-04-20 12:28:22 +0530 refs/tags/mysql-5.1.69
2013-04-12 12:11:38 +0200 refs/tags/mysql-5.5.31
2013-03-11 13:50:17 +0400 refs/tags/mariadb-5.5.30
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.0-rc.2
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.0-rc.4
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.0-rc.5
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.0-rc.6
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.2
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.4
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.4-rc.0
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.4-rc.1
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.0.4-rc.2
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.1.0
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.1.1
2013-03-09 12:23:02 +0000 refs/tags/tokumx-1.1.1-rc.0
2013-03-05 00:01:20 +0200 refs/tags/mariadb-galera-5.5.29
2013-03-01 12:10:09 +0100 refs/tags/clone-5.5.31-build
2013-02-28 09:52:55 +0530 refs/tags/clone-5.1.69-build
2013-02-28 09:52:55 +0530 refs/tags/mysql-5.1.69-retag
2013-02-04 17:30:39 +0200 refs/tags/mariadb-10.0.1
2013-01-29 12:27:31 +0100 refs/tags/mariadb-5.5.29
2013-01-28 09:12:23 +0100 refs/tags/mariadb-5.3.12
2013-01-28 09:10:01 +0100 refs/tags/mariadb-5.2.14
2013-01-25 14:29:46 +0100 refs/tags/mariadb-5.1.67
2013-01-16 08:09:26 +0100 refs/tags/mysql-5.5.30
2013-01-08 13:29:11 +0100 refs/tags/mysql-5.1.68
2013-01-07 16:58:02 +0530 refs/tags/clone-5.5.30-build
2013-01-07 16:56:16 +0530 refs/tags/clone-5.1.68-build
2012-12-20 12:34:37 +0100 refs/tags/mariadb-galera-5.5.28a
2012-12-10 10:06:37 +0400 refs/tags/mysql-5.5.29
2012-12-07 10:47:57 +0100 refs/tags/mysql-5.1.67
2012-11-27 12:26:15 +0100 refs/tags/mariadb-5.5.28a
2012-11-23 13:11:31 +0100 refs/tags/mariadb-5.3.11
2012-11-22 18:29:53 +0100 refs/tags/mariadb-5.2.13
2012-11-22 18:27:02 +0100 refs/tags/mariadb-5.1.66
2012-11-11 10:58:52 +0100 refs/tags/mariadb-10.0.0
2012-11-10 00:10:06 +0200 refs/tags/mariadb-5.3.10
2012-11-01 17:33:55 +0100 refs/tags/clone-5.5.29-build
2012-11-01 17:23:06 +0100 refs/tags/clone-5.1.67-build
2012-10-19 11:21:35 +0200 refs/tags/mariadb-5.5.28
2012-10-01 15:42:49 +0200 refs/tags/mariadb-5.3.9
2012-09-11 12:47:32 +0200 refs/tags/mysql-5.1.66
2012-09-06 10:08:09 +0200 refs/tags/mariadb-5.5.27
2012-09-05 17:40:13 +0200 refs/tags/clone-5.1.66-build
2012-08-30 12:22:37 +0300 refs/tags/mariadb-galera-5.5.25
2012-08-28 16:13:03 +0200 refs/tags/mysql-5.5.28
2012-08-24 23:43:18 +0200 refs/tags/mariadb-5.3.8
2012-08-24 11:56:14 +0200 refs/tags/clone-5.5.28-build
2012-07-12 10:00:14 +0200 refs/tags/mysql-5.1.65
2012-07-11 15:34:38 +0200 refs/tags/clone-5.5.27-build
2012-07-11 15:34:38 +0200 refs/tags/mysql-5.5.27
2012-07-10 18:55:07 +0530 refs/tags/clone-5.1.65-build
2012-06-21 21:17:34 +0200 refs/tags/mariadb-5.5.25
2012-06-20 13:10:13 +0200 refs/tags/serg-5.1.64
2012-05-30 20:20:54 +0200 refs/tags/mariadb-5.5.24
2012-05-10 10:33:16 +0530 refs/tags/clone-5.5.25-build
2012-05-10 10:33:16 +0530 refs/tags/mysql-5.5.25
2012-05-02 22:02:17 +0200 refs/tags/mariadb-5.3.7
2012-04-12 15:04:22 +0200 refs/tags/clone-5.5.24-build
2012-04-12 15:04:22 +0200 refs/tags/mysql-5.5.24
2012-04-10 14:21:57 +0300 refs/tags/clone-5.1.63-build
2012-04-10 14:21:57 +0300 refs/tags/mysql-5.1.63
2012-04-10 08:30:20 +0200 refs/tags/mariadb-5.5.23
2012-04-07 17:27:00 -0700 refs/tags/mariadb-5.3.6
2012-04-05 12:01:52 +0200 refs/tags/mariadb-5.2.12
2012-04-05 10:49:38 +0200 refs/tags/mariadb-5.1.62
2012-03-30 16:12:21 +0200 refs/tags/mariadb-5.2.11
2012-03-30 13:42:52 +0300 refs/tags/mariadb-5.1.61
2012-03-29 15:07:54 +0200 refs/tags/clone-5.5.23-build
2012-03-29 15:07:54 +0200 refs/tags/mysql-5.5.23
2012-03-28 20:25:31 +0200 refs/tags/mariadb-5.5.22-rc
2012-03-14 19:47:15 +0100 refs/tags/mariadb-5.5.21-beta
2012-03-02 13:23:52 +0100 refs/tags/mysql-5.5.22
2012-03-02 13:18:12 +0100 refs/tags/mysql-5.1.62
2012-03-02 13:12:07 +0100 refs/tags/mysql-5.0.96
2012-02-28 15:41:55 +0100 refs/tags/mariadb-5.3.5-ga
2012-02-24 14:37:00 +0100 refs/tags/mariadb-5.5.20-alpha
2012-02-19 09:33:55 +0200 refs/tags/clone-5.5.22-build
2012-02-18 10:58:19 +0200 refs/tags/clone-5.1.62-build
2012-02-17 11:51:14 +0200 refs/tags/clone-5.0.96-build
2012-01-30 20:34:47 +0400 refs/tags/mariadb-5.3.4
2012-01-30 10:23:21 -0500 refs/tags/clone-5.5.21-build
2012-01-30 10:23:21 -0500 refs/tags/mysql-5.5.21
2012-01-11 18:40:29 +0100 refs/tags/mysql-5.1.61
2011-12-20 12:13:47 +0400 refs/tags/mariadb-5.3.3-rc
2011-12-16 12:17:13 +0400 refs/tags/clone-5.5.20-build
2011-12-16 12:17:13 +0400 refs/tags/mysql-5.5.20
2011-12-15 16:59:18 +0100 refs/tags/clone-5.1.61-build
2011-12-14 14:05:22 +0100 refs/tags/clone-5.0.95-build
2011-12-14 14:05:22 +0100 refs/tags/mysql-5.0.95
2011-12-03 22:44:33 +0100 refs/tags/mariadb-5.2.10
2011-11-22 07:06:19 -0800 refs/tags/clone-5.5.19-build
2011-11-22 07:06:19 -0800 refs/tags/mysql-5.5.19
2011-11-02 15:28:18 +0000 refs/tags/mysql-5.5.18
2011-10-29 20:08:40 +0200 refs/tags/mysql-5.1.60
2011-10-26 12:28:40 +0300 refs/tags/clone-5.5.18-build
2011-10-26 12:23:57 +0300 refs/tags/clone-5.1.60-build
2011-10-13 00:15:51 +0400 refs/tags/mariadb-5.3.2-beta
2011-10-04 12:28:30 +0200 refs/tags/mysql-5.5.17
2011-09-27 17:44:31 +0530 refs/tags/clone-5.5.17-build
2011-09-16 18:30:46 +0200 refs/tags/mariadb-5.2.9
2011-09-09 10:39:44 -0400 refs/tags/mysql-5.5.16
2011-09-08 23:24:47 +0400 refs/tags/mariadb-5.3.1
2011-08-16 19:01:31 +0300 refs/tags/mariadb-5.2.8
2011-08-10 14:56:14 +0300 refs/tags/clone-5.1.59-build
2011-08-10 14:56:14 +0300 refs/tags/mysql-5.1.59
2011-07-22 23:47:28 -0700 refs/tags/mariadb-5.3.0-beta
2011-07-12 12:13:02 +0100 refs/tags/clone-5.5.15-build
2011-07-12 12:13:02 +0100 refs/tags/mysql-5.5.15
2011-07-01 17:18:27 +0200 refs/tags/mysql-5.1.58
2011-06-21 19:24:44 +0400 refs/tags/mysql-5.5.14
2011-06-13 12:46:11 +0300 refs/tags/mariadb-5.2.7
2011-06-08 11:56:11 +0300 refs/tags/clone-5.5.14-build
2011-06-06 16:53:46 +0300 refs/tags/clone-5.1.58-build
2011-05-10 18:19:11 +0200 refs/tags/mariadb-5.2.6
2011-05-10 16:49:13 +0300 refs/tags/clone-5.0.94-build
2011-05-10 16:49:13 +0300 refs/tags/mysql-5.0.94
2011-05-10 16:24:34 +0300 refs/tags/clone-5.5.13-build
2011-05-10 16:24:34 +0300 refs/tags/mysql-5.5.13
2011-04-12 01:36:38 +0200 refs/tags/mysql-5.1.57
2011-04-08 18:07:59 +0400 refs/tags/clone-5.5.12-build
2011-04-08 18:07:59 +0400 refs/tags/mysql-5.5.12
2011-04-08 14:49:41 +0400 refs/tags/clone-5.1.57-build
2011-04-07 12:17:36 +0300 refs/tags/clone-5.0.93-build
2011-04-07 12:17:36 +0300 refs/tags/mysql-5.0.93
2011-03-31 16:08:31 +0300 refs/tags/mysql-5.5.11
2011-03-18 17:00:13 +0200 refs/tags/clone-5.5.11-build
2011-03-01 23:24:17 +0200 refs/tags/mariadb-5.2.5
2011-02-27 01:25:56 +0100 refs/tags/mariadb-5.1.55
2011-02-17 19:36:19 +0100 refs/tags/mysql-5.5.10
2011-02-11 12:54:16 +0300 refs/tags/clone-5.5.10-build
2011-02-10 12:10:28 +0200 refs/tags/clone-5.1.56-build
2011-02-10 12:10:28 +0200 refs/tags/mysql-5.1.56
2011-02-09 23:07:08 +0100 refs/tags/mysql-5.1.52sp1
2011-01-25 15:42:40 +0100 refs/tags/mysql-5.1.55
2011-01-19 23:27:25 +0100 refs/tags/mysql-5.5.9
2011-01-12 20:32:38 +0300 refs/tags/clone-5.5.9-build
2011-01-12 17:08:52 +0200 refs/tags/clone-5.1.55-build
2011-01-07 15:28:36 +0200 refs/tags/clone-5.0.92-build
2011-01-07 15:28:36 +0200 refs/tags/mysql-5.0.92
2010-12-05 19:46:39 +0200 refs/tags/mariadb-5.2.4
2010-12-05 14:25:01 +0200 refs/tags/mariadb-5.1.53
2010-12-03 20:49:08 +0300 refs/tags/mysql-5.5.8
2010-11-25 18:38:01 +0200 refs/tags/clone-5.1.54-build
2010-11-25 18:38:01 +0200 refs/tags/mysql-5.1.54
2010-11-24 18:55:23 +0300 refs/tags/clone-5.5.8-build
2010-11-18 16:10:11 +0200 refs/tags/mariadb-5.1.51
2010-11-09 10:17:36 +0200 refs/tags/mariadb-5.2.3
2010-11-03 12:24:47 +0200 refs/tags/clone-5.1.53-build
2010-11-03 12:24:47 +0200 refs/tags/mysql-5.1.53
2010-10-14 19:29:14 +0100 refs/tags/mysql-5.5.7
2010-10-13 13:29:34 +0400 refs/tags/clone-5.5.7-rc-build
2010-10-11 22:13:47 +0200 refs/tags/mysql-5.1.52
2010-10-06 03:41:26 -0700 refs/tags/clone-5.1.52-build
2010-09-28 12:39:22 +0200 refs/tags/mysql-5.1.49sp1
2010-09-28 01:18:06 +0300 refs/tags/mariadb-5.2.2-gamma
2010-09-17 17:34:15 -0300 refs/tags/mysql-5.5.6-rc
2010-09-10 11:49:57 +0100 refs/tags/clone-5.1.51-build
2010-09-10 11:49:57 +0100 refs/tags/mysql-5.1.51
2010-09-08 02:00:12 +0300 refs/tags/mariadb-5.1.50
2010-08-25 14:22:34 +0400 refs/tags/clone-5.5.6-m3-build
2010-08-07 19:08:59 +0300 refs/tags/mariadb-5.1.49
2010-08-03 12:52:02 +0100 refs/tags/clone-5.1.50-build
2010-08-03 12:52:02 +0100 refs/tags/mysql-5.1.50
2010-07-09 14:23:48 +0200 refs/tags/mysql-5.1.49
2010-07-06 11:28:11 +0100 refs/tags/mysql-5.5.5-m3
2010-07-04 10:12:44 +0300 refs/tags/clone-5.1.49-build
2010-06-23 12:22:05 +0200 refs/tags/mysql-5.1.46sp1
2010-06-23 10:23:41 +0200 refs/tags/clone-5.5.5-m3-build
2010-06-17 15:53:05 +0200 refs/tags/mariadb-5.2.1-beta
2010-06-02 11:44:11 +0300 refs/tags/clone-5.1.48-build
2010-06-02 11:44:11 +0300 refs/tags/mysql-5.1.48
2010-05-27 20:18:31 +0300 refs/tags/mariadb-5.1.47
2010-05-09 21:30:06 +0200 refs/tags/mariadb-5.1.44b
2010-05-06 17:14:10 +0200 refs/tags/mysql-5.1.47
2010-05-05 17:57:53 +0300 refs/tags/clone-5.1.47-build
2010-05-05 15:33:46 +0200 refs/tags/mysql-5.0.91
2010-05-01 16:46:04 +0300 refs/tags/clone-5.0.91-build
2010-04-29 09:57:25 +0200 refs/tags/mariadb-5.1.44a
2010-04-28 14:52:24 +0200 refs/tags/mariadb-merge-mysql-5.1.46
2010-04-16 10:27:18 +0200 refs/tags/mysql-5.5.3-m3
2010-04-08 23:03:07 +0200 refs/tags/mariadb-5.2.0-beta
2010-04-06 10:56:11 +0300 refs/tags/clone-5.1.46-build
2010-04-06 10:56:11 +0300 refs/tags/mysql-5.1.46
2010-03-25 11:17:29 +0100 refs/tags/mysql-5.1.43sp1
2010-03-12 20:05:21 +0100 refs/tags/mariadb-5.1.44
2010-03-12 21:11:31 +0300 refs/tags/clone-5.5.3-build
2010-03-04 09:03:07 +0100 refs/tags/mariadb-merge-mysql-5.1.44
2010-03-01 20:18:09 +0100 refs/tags/mysql-5.1.45
2010-03-01 11:42:44 +0100 refs/tags/clone-5.1.45-build
2010-02-17 18:39:28 +0100 refs/tags/mysql-5.1.44
2010-02-12 17:41:00 +0100 refs/tags/clone-5.5.2-m2-build
2010-02-12 17:41:00 +0100 refs/tags/mysql-5.5.2-m2
2010-02-04 12:14:44 +0200 refs/tags/clone-5.1.44-build
2010-02-03 16:43:18 +0100 refs/tags/mysql-5.0.87sp1
2010-01-31 10:13:21 +0100 refs/tags/mariadb-5.1.42
2010-01-28 08:20:46 +0100 refs/tags/mariadb-5.1.42-rc
2010-01-15 17:27:55 +0200 refs/tags/mariadb-merge-mysql-5.1.42
2010-01-15 10:51:39 +0200 refs/tags/clone-5.1.43-build
2010-01-15 10:51:39 +0200 refs/tags/mysql-5.1.43
2010-01-14 10:24:02 +0200 refs/tags/clone-5.0.90-build
2010-01-14 10:24:02 +0200 refs/tags/mysql-5.0.90
2010-01-07 14:03:54 +0100 refs/tags/mariadb-5.1.41
2010-01-07 14:03:54 +0100 refs/tags/mariadb-5.1.41-rc
2010-01-04 15:03:09 +0100 refs/tags/mysql-5.5.1-m2
2009-12-22 09:31:24 +0300 refs/tags/clone-5.5.1-build
2009-12-16 14:21:02 +0100 refs/tags/mysql-5.1.42
2009-12-07 19:00:02 +0100 refs/tags/mysql-5.5.0
2009-12-02 15:17:49 +0530 refs/tags/clone-5.1.42-build
2009-12-02 09:58:30 +0200 refs/tags/clone-5.0.89-build
2009-11-25 23:43:37 +0100 refs/tags/mysql-5.1.40sp1
2009-11-18 12:47:59 +0100 refs/tags/mariadb-merge-mysql-5.1.41
2009-11-14 10:53:18 +0100 refs/tags/mariadb-5.1.39-beta
2009-11-12 05:20:39 +0300 refs/tags/clone-5.5.0-build
2009-11-05 21:22:17 +0100 refs/tags/mysql-5.1.41
2009-11-04 11:21:52 +0200 refs/tags/clone-5.1.41-build
2009-11-04 11:13:55 +0200 refs/tags/clone-5.0.88-build
2009-11-04 11:13:55 +0200 refs/tags/mysql-5.0.88
2009-10-26 17:01:05 +0200 refs/tags/mariadb-5.1.38-beta
2009-10-16 19:59:23 +0200 refs/tags/mysql-5.4.3
2009-10-15 23:38:29 +0200 refs/tags/mariadb-merge-mysql-5.1.39
2009-10-15 00:40:40 +0200 refs/tags/mysql-5.0.87
2009-10-06 14:37:37 +0200 refs/tags/clone-5.1.40-build
2009-10-06 14:37:37 +0200 refs/tags/mysql-5.1.40
2009-10-06 10:32:02 +0300 refs/tags/clone-5.0.87-build
2009-10-05 20:14:43 +0200 refs/tags/mysql-5.1.37sp1
2009-09-30 14:26:15 +0200 refs/tags/mysql-5.0.84sp1
2009-09-18 19:23:44 +0400 refs/tags/clone-5.4.3-build
2009-09-09 20:52:17 +0200 refs/tags/mysql-5.0.86
2009-09-08 16:10:06 +0200 refs/tags/mysql-5.4.2
2009-09-08 00:50:10 +0400 refs/tags/mariadb-merge-mysql-5.1.38minus
2009-09-04 17:45:07 +0200 refs/tags/mysql-5.1.39
2009-09-03 01:48:06 +0200 refs/tags/clone-5.1.39-build
2009-09-02 15:33:18 +0300 refs/tags/clone-5.0.86-build
2009-09-01 08:40:13 +0200 refs/tags/mysql-5.1.38
2009-08-25 17:12:44 +0200 refs/tags/clone-5.4.2-build
2009-08-12 17:46:12 +0500 refs/tags/clone-5.1.38-build
2009-08-10 19:47:28 -0300 refs/tags/clone-5.0.85-build
2009-08-10 19:47:28 -0300 refs/tags/mysql-5.0.85
2009-07-21 20:00:26 +0200 refs/tags/mysql-5.0.82sp1
2009-07-13 20:45:43 +0300 refs/tags/clone-5.1.37-build
2009-07-13 20:45:43 +0300 refs/tags/mysql-5.1.37
2009-07-07 10:49:38 +0300 refs/tags/clone-5.0.84-build
2009-07-07 10:49:38 +0300 refs/tags/mysql-5.0.84
2009-06-25 00:15:51 +0200 refs/tags/mysql-5.1.34sp1
2009-06-24 01:24:20 +0200 refs/tags/mysql-5.4.1
2009-06-16 13:21:55 +0300 refs/tags/clone-5.1.36-build
2009-06-16 13:21:55 +0300 refs/tags/mysql-5.1.36
2009-05-28 10:35:29 +0300 refs/tags/clone-5.0.83-build
2009-05-28 10:35:29 +0300 refs/tags/mysql-5.0.83
2009-05-22 21:50:02 +0200 refs/tags/clone-5.4.1-build
2009-05-20 23:04:34 +0200 refs/tags/mysql-5.0.82
2009-05-13 12:51:39 +0500 refs/tags/clone-5.1.35-build
2009-05-13 12:51:39 +0500 refs/tags/mysql-5.1.35
2009-05-07 20:07:14 +0200 refs/tags/clone-5.0.82-build
2009-05-01 19:37:23 +0200 refs/tags/mysql-5.0.81
2009-05-01 19:35:04 +0200 refs/tags/mysql-5.0.80
2009-04-30 15:38:00 +0200 refs/tags/clone-5.0.74sp1-build
2009-04-30 15:38:00 +0200 refs/tags/mysql-5.0.74sp1
2009-04-25 12:04:38 +0300 refs/tags/mariadb-merge-mysql-5.1.34plus
2009-04-14 13:20:13 -0400 refs/tags/clone-5.0.81-build
2009-04-03 14:52:59 +0100 refs/tags/clone-5.4.0-build
2009-04-02 13:17:38 +0200 refs/tags/mysql-5.1.34
2009-03-27 16:34:48 +0200 refs/tags/clone-5.1.34-build
2009-03-27 16:29:56 +0200 refs/tags/clone-5.0.80-build
2009-03-24 22:10:22 +0100 refs/tags/mysql-5.1.31sp1
2009-03-13 13:13:55 +0200 refs/tags/clone-5.1.33-build
2009-03-13 13:13:55 +0200 refs/tags/mysql-5.1.33
2009-03-09 22:16:24 +0100 refs/tags/mysql-5.0.79
2009-03-09 15:59:22 +0200 refs/tags/clone-5.0.79-build
2009-02-14 01:43:21 +0100 refs/tags/mysql-5.1.32
2009-02-11 12:07:22 +0200 refs/tags/clone-5.1.32-build
2009-02-06 19:38:39 +0100 refs/tags/clone-5.0.78-build
2009-02-06 19:38:39 +0100 refs/tags/mysql-5.0.78
2009-01-28 15:01:04 +0100 refs/tags/mysql-5.0.77
2009-01-26 22:06:42 +0100 refs/tags/mysql-5.0.72sp1
2009-01-19 17:48:05 +0100 refs/tags/mysql-5.1.31
2009-01-15 07:31:47 +0200 refs/tags/clone-5.1.31-build
2009-01-12 22:02:40 +0100 refs/tags/clone-5.0.72sp1-build
2009-01-05 18:04:14 +0200 refs/tags/clone-5.0.76-build
2009-01-05 18:04:14 +0200 refs/tags/mysql-5.0.76
2008-12-30 14:27:21 +0300 refs/tags/clone-5.1.31-pv-0.2.0-build
2008-12-17 15:01:34 -0500 refs/tags/clone-5.0.75-build
2008-12-17 15:01:34 -0500 refs/tags/mysql-5.0.75
2008-12-15 22:44:25 -0800 refs/tags/percona-xtradb-1.0.2-1
2008-12-03 05:11:48 +0100 refs/tags/mysql-5.0.74
2008-12-02 14:50:40 +0200 refs/tags/clone-5.0.74-build
2008-11-14 17:29:38 +0100 refs/tags/mysql-5.1.30
2008-11-06 17:30:33 +0100 refs/tags/clone-5.1.30-build
2008-10-24 17:34:17 +0200 refs/tags/mysql-5.0.72
2008-10-23 18:56:03 -0200 refs/tags/clone-5.0.72-build
2008-10-23 21:46:46 +0200 refs/tags/mysql-5.0.66sp1
2008-10-11 23:51:58 +0200 refs/tags/mysql-5.1.29
2008-10-09 20:57:41 +0500 refs/tags/clone-5.1.29-build
2008-09-27 02:23:39 +0200 refs/tags/mysql-5.0.70
2008-09-10 12:40:58 +0300 refs/tags/clone-5.0.70-build
2008-08-28 16:16:43 +0200 refs/tags/mysql-5.1.28
2008-08-28 12:54:50 +0300 refs/tags/clone-5.1.28-build
2008-08-13 00:11:11 -0600 refs/tags/clone-5.0.68-build
2008-08-13 00:11:11 -0600 refs/tags/mysql-5.0.68
2008-08-04 13:45:50 +0200 refs/tags/mysql-5.0.67
2008-07-26 14:39:31 +0500 refs/tags/clone-4.1.25-build
2008-07-17 01:33:45 +0200 refs/tags/clone-5.0.66sp1-build
2008-07-17 01:33:45 +0200 refs/tags/mysql-5.0.66a
2008-07-16 17:47:30 +0200 refs/tags/clone-5.0.67-build
2008-07-14 16:46:35 +0200 refs/tags/clone-5.1.27-build
2008-07-09 13:03:48 +0300 refs/tags/mysql-5.0.66
2008-07-08 16:39:44 +0200 refs/tags/clone-5.0.66-build
2008-06-30 22:52:26 +0200 refs/tags/mysql-5.1.26
2008-06-27 18:43:45 +0200 refs/tags/mysql-5.0.60sp1
2008-06-20 13:57:25 +0300 refs/tags/clone-5.1.26-build
2008-06-17 19:05:56 -0600 refs/tags/mysql-5.1.25
2008-06-10 21:10:56 +0200 refs/tags/mysql-5.0.64
2008-06-03 13:12:37 +0300 refs/tags/clone-5.0.64-build
2008-05-20 22:43:26 +0400 refs/tags/clone-5.1.25-build
2008-05-14 13:32:09 +0300 refs/tags/clone-5.0.62-build
2008-05-14 13:32:09 +0300 refs/tags/mysql-5.0.62
2008-04-28 21:53:52 +0200 refs/tags/clone-5.0.60sp1-build
2008-04-28 21:53:52 +0200 refs/tags/mysql-5.0.60
2008-04-08 12:52:11 +0300 refs/tags/mysql-5.1.24
2008-04-01 12:29:53 +0200 refs/tags/clone-5.0.60-build
2008-03-31 14:13:42 +0300 refs/tags/clone-5.1.24-build
2008-03-17 09:18:44 +0100 refs/tags/mysql-4.1.24
2008-03-12 10:53:15 +0300 refs/tags/clone-4.1.24-build
2008-03-05 14:03:05 +0100 refs/tags/mysql-5.0.58
2008-02-28 20:22:11 -0300 refs/tags/clone-5.0.58-build
2008-02-21 23:34:22 +0100 refs/tags/mysql-5.1.23a-maria-alpha
2008-02-11 23:13:15 +0200 refs/tags/clone-5.1.23a-maria-alpha-build
2008-02-06 14:13:05 +0100 refs/tags/clone-5.0.56-build
2008-02-06 14:13:05 +0100 refs/tags/mysql-5.0.56
2008-01-29 21:44:25 +0100 refs/tags/mysql-5.1.23
2008-01-15 17:01:58 +0100 refs/tags/clone-5.1.23-build
2008-01-11 15:37:18 +0100 refs/tags/mysql-5.0.51a
2008-01-11 14:47:31 +0100 refs/tags/mysql-5.0.54a
2007-12-14 21:38:58 +0100 refs/tags/mysql-5.0.54
2007-12-13 23:46:29 +0400 refs/tags/clone-5.0.54-build
2007-11-30 06:14:43 +0100 refs/tags/mysql-5.0.52
2007-11-15 14:59:40 +0100 refs/tags/mysql-5.0.51
2007-11-14 18:56:14 +0400 refs/tags/clone-5.0.52-build
2007-11-07 13:25:20 -0500 refs/tags/clone-5.0.51-build
2007-10-19 17:07:08 +0200 refs/tags/mysql-5.0.50
2007-09-28 17:33:14 +0200 refs/tags/mysql-5.1.22
2007-09-25 17:42:25 +0200 refs/tags/clone-5.0.50-build
2007-08-30 14:13:05 -0600 refs/tags/clone-5.1.22-build
2007-08-28 16:06:08 +0200 refs/tags/mysql-5.0.48
2007-08-27 11:24:54 +0200 refs/tags/clone-5.0.48-build
2007-08-20 16:35:16 +0200 refs/tags/mysql-5.1.21
2007-08-06 08:33:20 +0200 refs/tags/clone-5.1.21-build
2007-07-19 23:30:26 +0200 refs/tags/mysql-5.0.46
2007-07-09 15:38:36 -0600 refs/tags/clone-5.0.46-build
2007-07-03 12:20:19 -0400 refs/tags/clone-5.0.45-build
2007-07-03 12:20:19 -0400 refs/tags/mysql-5.0.45
2007-06-26 13:15:43 +0200 refs/tags/mysql-5.1.20
2007-06-26 13:15:43 +0200 refs/tags/mysql-5.1.20-beta
2007-06-22 23:02:41 +0200 refs/tags/clone-5.1.20-build
2007-06-21 08:58:39 +0200 refs/tags/clone-5.0.44-build
2007-06-21 08:58:39 +0200 refs/tags/mysql-5.0.44
2007-06-12 10:25:24 +0200 refs/tags/mysql-4.1.23
2007-05-25 23:08:31 +0200 refs/tags/mysql-5.1.19
2007-05-24 15:32:14 +0200 refs/tags/clone-5.1.19-build
2007-05-23 12:38:34 +0500 refs/tags/clone-4.1.23-build
2007-05-14 15:11:29 +0200 refs/tags/mysql-5.0.42
2007-05-12 23:42:36 +0200 refs/tags/clone-5.0.42-build
2007-05-07 12:32:09 -0700 refs/tags/clone-5.1.18-build
2007-05-07 12:32:09 -0700 refs/tags/mysql-5.1.18
2007-05-07 08:25:47 +0200 refs/tags/mysql-5.0.41
2007-04-30 13:00:36 +0200 refs/tags/mysql-5.1.18-ndb-6.2.1
2007-04-26 19:03:31 +0200 refs/tags/clone-5.0.41-build
2007-04-20 15:52:49 +0200 refs/tags/mysql-5.0.40
2007-04-15 09:54:16 +0400 refs/tags/clone-5.0.40-build
2007-04-05 10:00:04 +0200 refs/tags/mysql-5.1.17
2007-03-22 11:48:49 -0600 refs/tags/clone-5.1.17-build
2007-03-20 19:57:22 +0100 refs/tags/mysql-5.0.38
2007-03-16 01:28:29 +0400 refs/tags/clone-5.0.38-build
2007-03-05 16:10:42 +0100 refs/tags/mysql-5.0.37
2007-02-27 20:04:58 -0500 refs/tags/clone-5.0.37-build
2007-02-26 00:44:12 +0100 refs/tags/mysql-5.1.16
2007-02-20 10:05:22 +0100 refs/tags/clone-5.1.16-build
2007-02-16 16:31:31 +0100 refs/tags/mysql-4.0.30
2007-02-14 10:47:39 -0500 refs/tags/clone-5.0.36-build
2007-02-14 10:47:39 -0500 refs/tags/mysql-5.0.36
2007-02-09 13:03:37 +0200 refs/tags/clone-4.0.30-build
2007-01-29 14:47:38 +0100 refs/tags/mysql-5.1.15
2007-01-25 13:12:02 +0100 refs/tags/clone-5.1.15-build
2007-01-17 10:41:52 +0100 refs/tags/mysql-5.0.34
2007-01-15 12:13:11 +0100 refs/tags/clone-5.0.34-build
2007-01-11 19:17:27 +0100 refs/tags/clone-4.0.29-build
2007-01-09 17:21:54 +0100 refs/tags/mysql-4.0.28
2007-01-09 13:02:15 +0100 refs/tags/mysql-5.0.33
2006-12-20 13:23:33 +0100 refs/tags/mysql-5.0.32
2006-12-14 22:52:38 +0100 refs/tags/clone-5.0.32-build
2006-12-06 16:15:20 +0100 refs/tags/mysql-5.1.14
2006-12-05 10:51:30 +0100 refs/tags/clone-5.1.14-build
2006-11-23 20:04:18 +0100 refs/tags/mysql-5.0.30
2006-11-14 12:47:53 +0100 refs/tags/clone-5.0.30-build
2006-11-13 20:44:22 +0100 refs/tags/mysql-5.1.13
2006-11-13 12:10:12 +0100 refs/tags/clone-5.1.13-build
2006-11-07 23:19:44 +0100 refs/tags/clone-4.0.28-build
2006-11-02 21:03:41 -0500 refs/tags/mysql-4.1.22
2006-11-02 01:08:39 +0300 refs/tags/clone-4.1.22-build
2006-10-24 19:05:11 +0200 refs/tags/mysql-5.1.12
2006-10-24 12:31:18 +0200 refs/tags/mysql-5.0.28
2006-10-21 00:57:08 +0200 refs/tags/mysql-5.0.27
2006-10-11 10:21:49 +0200 refs/tags/clone-5.1.12-build
2006-10-03 17:42:00 +0400 refs/tags/mysql-5.0.26
2006-09-29 01:35:11 +0400 refs/tags/clone-5.0.26-build
2006-09-15 02:18:30 +0400 refs/tags/mysql-5.0.25
2006-09-06 02:14:50 +0200 refs/tags/clone-5.0.25-build
2006-08-25 11:56:19 -0400 refs/tags/mysql-5.0.24a
2006-07-27 13:59:15 +0400 refs/tags/mysql-5.0.24
2006-07-19 15:55:04 +0200 refs/tags/mysql-4.1.21
2006-07-14 16:58:51 +0500 refs/tags/clone-4.1.21-build
2006-07-04 12:30:08 +0200 refs/tags/clone-5.0.24-build
2006-07-04 12:30:08 +0200 refs/tags/mysql-5.0.23
2006-06-28 10:11:43 -0700 refs/tags/clone-5.0.23-build
2006-06-02 16:23:49 +0500 refs/tags/mysql-5.1.11
2006-05-24 14:22:36 +0200 refs/tags/mysql-5.0.22
2006-05-24 14:12:19 +0200 refs/tags/mysql-4.1.20
2006-05-22 22:12:48 +0200 refs/tags/clone-5.1.11-build
2006-05-08 18:09:01 +0200 refs/tags/clone-5.1.10-build
2006-05-06 16:42:59 +0200 refs/tags/clone-4.0.27-build
2006-05-06 16:42:59 +0200 refs/tags/mysql-4.0.27
2006-05-02 23:49:21 +0200 refs/tags/mysql-5.0.17b
2006-04-29 01:28:04 +0200 refs/tags/clone-4.1.19-build
2006-04-29 01:28:04 +0200 refs/tags/mysql-4.1.19
2006-04-26 18:26:26 +0200 refs/tags/mysql-5.0.21
2006-04-25 22:39:59 -0700 refs/tags/clone-5.0.21-build
2006-04-18 13:26:41 +0200 refs/tags/mysql-5.0.20a
2006-04-12 23:16:15 -0400 refs/tags/mysql-5.1.9
2006-03-31 11:48:08 +0200 refs/tags/mysql-5.0.20
2006-03-30 00:20:14 +0400 refs/tags/clone-5.0.20-build
2006-03-24 18:24:03 -0500 refs/tags/clone-5.1.8-build
2006-03-17 12:10:08 +0100 refs/tags/mysql-5.0.19a
2006-03-04 23:04:48 +0300 refs/tags/mysql-5.0.19
2006-03-02 11:09:16 +0100 refs/tags/clone-5.0.19-build
2006-02-27 22:14:46 +0100 refs/tags/mysql-5.1.7
2006-02-17 14:14:56 +0100 refs/tags/clone-5.1.7-build
2006-02-08 19:01:54 +0100 refs/tags/mysql-5.1.6
2006-02-06 09:55:20 +0200 refs/tags/base_4_16217
2006-02-01 13:16:36 +0100 refs/tags/clone-5.1.6-build
2006-01-27 13:38:15 +0100 refs/tags/mysql-4.1.18
2006-01-27 01:38:05 +0100 refs/tags/clone-4.1.18-build
2006-01-17 18:35:17 +0100 refs/tags/mysql-5.1.5-for-windows
2006-01-17 09:05:18 +0100 refs/tags/clone-4.1.17-build
2006-01-10 10:35:43 +0100 refs/tags/mysql-5.1.5
2006-01-09 16:37:24 +0100 refs/tags/clone-5.1.5-build
2005-12-28 18:35:22 +0100 refs/tags/mysql-5.0.18
2005-12-21 16:05:13 +0100 refs/tags/clone-5.0.18-build
2005-12-21 06:02:04 +0100 refs/tags/clone-5.1.4-build
2005-12-21 06:02:04 +0100 refs/tags/mysql-5.1.4
2005-12-14 21:42:08 +0400 refs/tags/mysql-5.0.17
2005-12-07 08:50:14 +0100 refs/tags/clone-5.0.17-build
2005-12-05 10:27:46 -0800 refs/tags/import-bdb-4.4.16
2005-11-29 11:52:58 -0800 refs/tags/clone-4.1.16-build
2005-11-29 11:52:58 -0800 refs/tags/mysql-4.1.16
2005-11-29 15:18:31 +0100 refs/tags/mysql-5.1.3
2005-11-24 14:57:14 +0100 refs/tags/clone-5.1.3-build
2005-11-18 18:25:46 +0100 refs/tags/mysql-5.0.16a
2005-11-14 18:10:16 +0300 refs/tags/mysql-5.0.16
2005-11-09 12:45:34 +0100 refs/tags/clone-5.0.16-build
2005-10-19 22:00:12 +0200 refs/tags/mysql-5.0.15
2005-10-14 00:29:33 +0300 refs/tags/clone-5.0.15-build
2005-10-11 22:34:40 +0200 refs/tags/mysql-4.1.15
2005-10-07 04:02:53 +0300 refs/tags/clone-4.1.15-build
2005-10-04 21:37:50 +0200 refs/tags/mysql-5.0.14
2005-09-30 12:49:14 +0200 refs/tags/clone-5.0.14-build
2005-09-22 18:57:07 +0200 refs/tags/mysql-5.0.13
2005-09-15 14:53:38 +0200 refs/tags/clone-5.0.13-build
2005-09-02 11:11:29 +0200 refs/tags/mysql-4.0.26
2005-08-29 22:35:48 -0500 refs/tags/clone-4.0.26-build
2005-08-27 01:50:38 +0200 refs/tags/mysql-5.0.12
2005-08-24 13:56:54 +0200 refs/tags/clone-5.1.1-build
2005-08-24 11:14:41 +0200 refs/tags/clone-5.0.12-build
2005-08-17 15:11:29 +0200 refs/tags/mysql-4.1.14
2005-08-17 04:32:29 -0400 refs/tags/clone-4.1.14-build
2005-08-09 10:22:48 -0700 refs/tags/import-zlib-1.2.3
2005-08-06 03:31:01 +0200 refs/tags/mysql-5.0.11
2005-08-04 14:15:21 +0200 refs/tags/clone-5.0.11-build
2005-07-29 13:49:25 +0200 refs/tags/mysql-4.1.10b
2005-07-28 18:25:58 +0200 refs/tags/mysql-4.1.13a
2005-07-27 13:01:48 +0200 refs/tags/mysql-5.0.10a
2005-07-22 12:01:42 -0700 refs/tags/mysql-5.0.10
2005-07-20 15:48:22 -0700 refs/tags/import-bdb-4.3.28
2005-07-20 14:17:06 +0400 refs/tags/clone-5.0.10-build
2005-07-20 07:53:10 +0200 refs/tags/clone-5.1.0-build
2005-07-18 17:22:38 -0700 refs/tags/import-readline-5.0
2005-07-15 13:30:01 +0200 refs/tags/mysql-4.1.13
2005-07-13 13:49:35 +0200 refs/tags/clone-4.1.13-build
2005-07-08 15:52:15 +0200 refs/tags/mysql-5.0.9
2005-07-06 12:29:20 +0300 refs/tags/clone-5.0.9-build
2005-06-30 17:33:23 +0200 refs/tags/mysql-4.0.25
2005-06-24 18:23:59 +0200 refs/tags/mysql-5.0.8
2005-06-23 11:30:40 +0200 refs/tags/clone-4.0.25-build
2005-06-22 18:51:48 -0500 refs/tags/clone-5.0.8-build
2005-06-10 21:31:39 +0200 refs/tags/mysql-5.0.7
2005-06-07 09:11:37 -0700 refs/tags/clone-5.0.7-build
2005-05-26 15:21:01 +0200 refs/tags/mysql-5.0.6
2005-05-17 17:08:43 +0200 refs/tags/clone-5.0.6-build
2005-05-13 10:04:35 +0200 refs/tags/mysql-4.1.12
2005-05-09 20:55:06 +0500 refs/tags/clone-4.1.12-build
2005-04-27 10:01:41 -0700 refs/tags/mysql-5.0.5
2005-04-25 12:02:34 +0200 refs/tags/clone-5.0.5-build
2005-04-16 23:57:15 +0400 refs/tags/mysql-5.0.4
2005-04-06 23:12:10 +0200 refs/tags/clone-5.0.4-build
2005-04-01 18:38:19 +0200 refs/tags/mysql-4.1.10a
2005-04-01 12:35:49 +0200 refs/tags/mysql-4.1.11
2005-03-22 21:57:03 +0100 refs/tags/mysql-5.0.3
2005-03-17 16:44:25 +0100 refs/tags/clone-5.0.3-build
2005-03-04 12:31:30 +0100 refs/tags/mysql-4.0.24
2005-02-12 19:17:33 +0100 refs/tags/mysql-4.1.10
2005-01-11 23:09:10 +0100 refs/tags/mysql-4.1.9
2004-12-18 11:57:17 +0000 refs/tags/mysql-4.0.23
2004-12-14 15:58:30 +0400 refs/tags/mysql-4.1.8
2004-12-01 00:30:42 +0100 refs/tags/mysql-5.0.2
2004-12-01 00:30:42 +0100 refs/tags/mysql-5.0.2-alpha
2004-10-27 21:51:27 +0200 refs/tags/mysql-4.0.22
2004-10-23 10:24:59 +0500 refs/tags/mysql-4.1.7
2004-10-13 00:38:43 +0000 refs/tags/mysql-4.1.6
2004-09-16 22:13:24 +0400 refs/tags/mysql-4.1.5
2004-09-06 23:20:33 +0200 refs/tags/mysql-4.0.21
2004-08-26 16:44:01 -0500 refs/tags/mysql-4.1.4
2004-07-27 00:00:01 +0200 refs/tags/mysql-5.0.1
2004-06-28 11:06:22 +0200 refs/tags/mysql-4.1.3
2004-05-28 22:33:49 +0300 refs/tags/mysql-4.1.2
2004-05-14 16:48:56 +0300 refs/tags/mysql-4.0.20
2004-05-03 18:26:50 +0200 refs/tags/mysql-4.0.19
2004-02-12 17:12:08 +0100 refs/tags/mysql-4.0.18
2003-12-22 14:42:20 +0100 refs/tags/mysql-5.0.0
2003-12-14 21:31:02 +0100 refs/tags/mysql-4.0.17
2003-12-01 13:13:16 +0200 refs/tags/mysql-4.1.1
2003-10-17 02:32:09 +0200 refs/tags/mysql-4.0.16
2003-09-11 13:36:08 +0200 refs/tags/mysql-3.23.58
2003-09-05 14:44:21 +0200 refs/tags/mysql-4.0.15
2003-07-18 12:35:29 +0300 refs/tags/mysql-4.0.14
2003-06-06 14:13:26 +0200 refs/tags/mysql-3.23.57
2003-05-16 13:36:13 +0200 refs/tags/mysql-4.0.13
2003-04-03 21:19:14 +0300 refs/tags/mysql-4.1.0
2003-03-15 18:42:55 +0100 refs/tags/mysql-4.0.12
2003-03-13 18:46:40 +0100 refs/tags/mysql-3.23.56
2003-02-20 15:13:47 +0100 refs/tags/mysql-4.0.11
2003-01-29 14:00:08 +0500 refs/tags/mysql-4.0.10
2003-01-23 16:41:26 +0100 refs/tags/mysql-3.23.55
2003-01-09 11:11:06 +0200 refs/tags/mysql-4.0.9
2003-01-05 20:18:49 +0200 refs/tags/mysql-4.0.8
2002-12-20 14:59:35 +0200 refs/tags/mysql-4.0.7
2002-12-14 22:38:33 +0200 refs/tags/mysql-4.0.6
2002-12-05 01:01:38 +0100 refs/tags/mysql-3.23.54
2002-11-13 06:11:56 +0200 refs/tags/mysql-4.0.5
2002-10-09 22:16:40 +0200 refs/tags/mysql-3.23.53
2002-09-26 15:36:31 +0200 refs/tags/mysql-4.0.4
2002-08-26 12:28:49 +0300 refs/tags/mysql-4.0.3
2002-08-14 00:41:33 +0300 refs/tags/mysql-3.23.52
2002-07-01 12:58:30 +0200 refs/tags/mysql-4.0.2
2002-05-31 16:56:02 -0700 refs/tags/mysql-3.23.51
2002-04-21 12:06:34 +0200 refs/tags/mysql-3.23.50
2002-02-07 23:46:29 +0200 refs/tags/mysql-3.23.48
2001-12-27 15:16:08 +0200 refs/tags/mysql-3.23.47
2001-12-23 03:03:09 +0200 refs/tags/mysql-4.0.1
2001-11-29 15:34:37 +0200 refs/tags/mysql-3.23.46
2001-11-22 13:15:17 +0200 refs/tags/mysql-3.23.45
2001-10-31 22:24:33 +0200 refs/tags/mysql-3.23.44
2001-09-08 22:04:17 +0300 refs/tags/mysql-3.23.42
2001-08-11 14:10:27 +0300 refs/tags/mysql-3.23.41
2001-06-12 13:10:23 +0300 refs/tags/mysql-3.23.39
2001-05-09 23:09:17 +0300 refs/tags/mysql-3.23.38
2001-04-17 23:42:24 -0600 refs/tags/mysql-3.23.37
2001-03-27 13:05:48 +0300 refs/tags/mysql-3.23.36
2001-03-15 15:00:39 +0200 refs/tags/mysql-3.23.35
2001-03-10 17:05:10 +0200 refs/tags/mysql-3.23.34
2001-02-09 04:09:03 +0200 refs/tags/mysql-3.23.33
2001-01-22 15:33:34 +0200 refs/tags/mysql-3.23.32
2001-01-17 11:36:16 +0200 refs/tags/mysql-3.23.31
2001-01-04 02:56:38 +0200 refs/tags/mysql-3.23.30-gamma
2000-12-16 23:41:45 +0200 refs/tags/mysql-3.23.29a-gamma
2000-11-22 12:17:52 -0500 refs/tags/mysql-3.23.28-gamma
2000-10-24 03:55:04 +0300 refs/tags/mysql-3.23.27-beta
2000-09-08 09:49:25 +0200 refs/tags/mysql-3.23.24-beta
2000-09-01 00:53:34 +0200 refs/tags/beta-3.23.23
2000-08-02 03:48:07 +0200 refs/tags/mysql_4.0
2000-07-31 21:51:36 -0600 refs/tags/mysql-3.23.22-beta
