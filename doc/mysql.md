```sh
mysql  -u root --password=root # long  password with equal
mysql  -u root -proot          # short password no equal
```
```sql
show databases;
use DATABASENAME;
show tables;
desc mytable; -- show table schema
create database bip;
select Host, User, password from mysql.user;
CREATE USER 'donald'@'%' IDENTIFIED BY password('duck');
CREATE USER 'donald'@'%' IDENTIFIED BY 'duck';
CREATE USER 'donald' IDENTIFIED BY 'duck';
drop USER 'donald'@'%';
SET PASSWORD FOR 'donald'@'%' = PASSWORD('duck');
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%';
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES; # if modified PRIVILEGES through an insert update or delete statement instead of a grant, revoke, set password or rename user

create user 'mrowncloud'@'localhost' identified by 'habon123.';
drop user mrowncloud;
grant all on mrowncloud.* to mrowncloud;

select distinct(mt) from mt where cast(mt as signed integer) < 100;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass';
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

select UNIX_TIMESTAMP(); -- now
select UNIX_TIMESTAMP("2021-04-15 00:00:00"); -- 1618444800
SELECT UNIX_TIMESTAMP('2021-11-27 12:35:03.123456') AS Result; -- as a float
select date_format(from_unixtime(clock), "%Y.%m.%d %H:%i:%s") from bip; -- https://www.w3schools.com/sql/func_mysql_date_format.asp


Alter table Empolyee disable constraint pk_EmpNumer;
SHOW CREATE TABLE zabbix5.event_recovery; -- list constraints

mysqldump -h mariad.lan -u root -pblabla --single-transaction --column-statistics=0 --databases haha
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

select id, db, command, time, state, info from information_schema.processlist;
show processlist;
show full processlist; -- see full query
```

