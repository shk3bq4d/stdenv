@begin=sh@
mysql  -u root --password=root # long  password with equal
mysql  -u root -proot          # short password no equal
@end=sh@
@begin=sql@
show databases;
use DATABASENAME;
show tables;
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
@end=sql@



# https://dev.mysql.com/doc/refman/5.5/en/old-client.html
Client does not support authentication protocol requested by server
@begin=sql@
SET PASSWORD FOR 'some_user'@'some_host' = OLD_PASSWORD('new_password'); 
ALTER USER 'fw'@'10.1.1.120' IDENTIFIED WITH mysql_native_password BY 'fwpass';
@end=sql@

mysql -U -h 127.0.0.1 -u root --password=mypasswordislongerasyours repository_sd2 <<<"select * from (select count(1) as co, formatbasic FROM SUBFIELD where \`release\` = '20171222' and formatbasic regexp '.*[0-9]{2,}.*' group by formatbasic) mralias where co > 35 order by formatbasic;"
