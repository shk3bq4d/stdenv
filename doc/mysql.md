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





INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);
INSERT INTO table_name VALUES (value1, value2, value3, ...);

select Host, User, password from mysql.user \G; -- vertical line alignement (the \G at the end of the query does the trick)

desc c01_templatecachequeries;
show index from c01_templatecachequeries;


Alter table Empolyee disable constraint pk_EmpNumer;
SHOW CREATE TABLE zabbix5.event_recovery; -- list constraints
```


mysqldump -h mariad.lan -u root -pblabla --single-transaction --column-statistics=0 --databases haha
