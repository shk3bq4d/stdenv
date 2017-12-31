# /* ex: set ft=sql: */

select * from all_objects;
select * from all_objects where lower(object_name) like '%space%';
select * from all_objects where object_type ='INDEX';
select * from all_objects where object_name like 'ALL_%';
select * from user_tablespaces;


-- list roles
select * from role_tab_privs where role like '%FLOW%';

-- grant role
GRANT INSERT ON dataspace.amc_flow TO dataspace_ecriture_role;


-- rename table 
#rename table OLD_NAME to NEW_NAME;
#rename table OLD_NAME to NEW_NAME, OTHER_TABLE_OLD_NAME to OTHER_TABLE_NEW_NAME;
alter table MR_mytable rename to bipbip
alter table work.pvt_mytable rename column myref to myref;

describe table;


-- list columns for current schema
select * from user_tab_cols;

-- list tables in all database (may not have access to it)
SELECT owner, table_name FROM dba_tables;

-- list all tables current account can access
SELECT owner, table_name FROM all_tables;
SELECT table_name FROM all_tables where owner = 'myref' and table_name like 'stb%';

-- list all tables which current user owns
SELECT table_name FROM user_tables;


-- log
create table log(ts TIMESTAMP(3) default systimestamp,cat varchar2(64),line varchar2(4000));
insert into log (line) values('hehe');
CREATE OR REPLACE procedure mrlog(line varchar2, cat varchar2 default null) as begin insert into log (line, cat) values(line, cat); end;
/
begin
  mrlog('hehhabon');
end;
/



create table hehe as select 1 as bip, 2 as bup from dual;
create table myschema.mytable
(   idchamps      number(38, 0),
	myref     number(38,0),
	txlibcontrole varchar2(255 byte),
	nocontrole    integer,
	softwarecre      varchar2(10 byte),
	usercre      varchar2(15 byte),
	datecre      timestamp (6),
	softwaremod      varchar2(10 byte),
	usermod      varchar2(15 byte),
	datemode      timestamp (6),
	state      varchar2(1 byte),
	lock      number(*,0)
) tablespace mytablespace;

insert into hehe select 3 as bip, 6 as bup from dual;





SELECT table_name, column_name FROM cols;
SELECT table_name, column_name FROM all_tab_columns;


-- case
CASE status
	WHEN 'i' THEN 'Inactive'
	WHEN 't' THEN 'Terminated'
	ELSE 'Active'
END AS StatusText

CASE 
	WHEN bip='i' THEN 'Inactive'
	WHEN bip3='t' THEN 'Terminated'
	ELSE 'Active'
END AS StatusText


# time
select
	sysdate,  -- temps jusqu'a la seconde
	systimestamp -- temps plus précis
from dual;

export NLS_DATE_FORMAT="dd/mon/yyyy hh24:mi:ss"
alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';
alter session set nls_timestamp_format = 'yyyy-mm-dd hh24:mi:ss';

select * from nls_session_parameters;

COLUMN FIRST_NAME HEADING 'FIRST|NAME';
COLUMN LAST_NAME HEADING 'LAST|NAME';
COLUMN SALARY  HEADING 'MONTHLY|SALARY' FORMAT $99,999;


# details connection
  		  SELECT 'AUDITED_CURSORID'      AS Parameter, SYS_CONTEXT('USERENV','AUDITED_CURSORID')      AS Value, 'Returns the cursor ID of the SQL that triggered the audit'                                                                              AS Description FROM Dual
UNION ALL SELECT 'AUTHENTICATION_DATA'   AS Parameter, SYS_CONTEXT('USERENV','AUTHENTICATION_DATA')   AS Value, 'Authentication data'                                                                                                                    AS Description FROM Dual
UNION ALL SELECT 'AUTHENTICATION_TYPE'   AS Parameter, SYS_CONTEXT('USERENV','AUTHENTICATION_TYPE')   AS Value, 'Describes how the user was authenticated. Can be one of the following values: Database, OS, Network, or Proxy'                          AS Description FROM Dual
UNION ALL SELECT 'BG_JOB_ID'             AS Parameter, SYS_CONTEXT('USERENV','BG_JOB_ID')             AS Value, 'If the session was established by an Oracle background process, this parameter will return the Job ID. Otherwise, it will return NULL.' AS Description FROM Dual
UNION ALL SELECT 'CLIENT_IDENTIFIER'     AS Parameter, SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER')     AS Value, 'Returns the client identifier (global context)'                                                                                         AS Description FROM Dual
UNION ALL SELECT 'CLIENT_INFO'           AS Parameter, SYS_CONTEXT('USERENV','CLIENT_INFO')           AS Value, 'User session information'                                                                                                               AS Description FROM Dual
UNION ALL SELECT 'CURRENT_SCHEMA'        AS Parameter, SYS_CONTEXT('USERENV','CURRENT_SCHEMA')        AS Value, 'Returns the default schema used in the current schema'                                                                                  AS Description FROM Dual
UNION ALL SELECT 'CURRENT_SCHEMAID'      AS Parameter, SYS_CONTEXT('USERENV','CURRENT_SCHEMAID')      AS Value, 'Returns the identifier of the default schema used in the current schema'                                                                AS Description FROM Dual
UNION ALL SELECT 'CURRENT_SQL'           AS Parameter, SYS_CONTEXT('USERENV','CURRENT_SQL')           AS Value, 'Returns the SQL that triggered the audit event'                                                                                         AS Description FROM Dual
UNION ALL SELECT 'CURRENT_USER'          AS Parameter, SYS_CONTEXT('USERENV','CURRENT_USER')          AS Value, 'Name of the current user'                                                                                                               AS Description FROM Dual
UNION ALL SELECT 'CURRENT_USERID'        AS Parameter, SYS_CONTEXT('USERENV','CURRENT_USERID')        AS Value, 'Userid of the current user'                                                                                                             AS Description FROM Dual
UNION ALL SELECT 'DB_DOMAIN'             AS Parameter, SYS_CONTEXT('USERENV','DB_DOMAIN')             AS Value, 'Domain of the database from the DB_DOMAIN initialization parameter'                                                                     AS Description FROM Dual
UNION ALL SELECT 'DB_NAME'               AS Parameter, SYS_CONTEXT('USERENV','DB_NAME')               AS Value, 'Name of the database from the DB_NAME initialization parameter'                                                                         AS Description FROM Dual
UNION ALL SELECT 'ENTRYID'               AS Parameter, SYS_CONTEXT('USERENV','ENTRYID')               AS Value, 'Available auditing entry identifier'                                                                                                    AS Description FROM Dual
UNION ALL SELECT 'EXTERNAL_NAME'         AS Parameter, SYS_CONTEXT('USERENV','EXTERNAL_NAME')         AS Value, 'External of the database user'                                                                                                          AS Description FROM Dual
UNION ALL SELECT 'FG_JOB_ID'             AS Parameter, SYS_CONTEXT('USERENV','FG_JOB_ID')             AS Value, 'If the session was established by a client foreground process, this parameter will return the Job ID. Otherwise, it will return NULL.'  AS Description FROM Dual
UNION ALL SELECT 'GLOBAL_CONTEXT_MEMORY' AS Parameter, SYS_CONTEXT('USERENV','GLOBAL_CONTEXT_MEMORY') AS Value, 'The number used in the System Global Area by the globally accessed context'                                                             AS Description FROM Dual
UNION ALL SELECT 'HOST'                  AS Parameter, SYS_CONTEXT('USERENV','HOST')                  AS Value, 'Name of the host machine from which the client has connected'                                                                           AS Description FROM Dual
UNION ALL SELECT 'INSTANCE'              AS Parameter, SYS_CONTEXT('USERENV','INSTANCE')              AS Value, 'The identifier number of the current instance'                                                                                          AS Description FROM Dual
UNION ALL SELECT 'IP_ADDRESS'            AS Parameter, SYS_CONTEXT('USERENV','IP_ADDRESS')            AS Value, 'IP address of the machine from which the client has connected'                                                                          AS Description FROM Dual
UNION ALL SELECT 'ISDBA'                 AS Parameter, SYS_CONTEXT('USERENV','ISDBA')                 AS Value, 'Returns TRUE if the user has DBA privileges. Otherwise, it will return FALSE.'                                                          AS Description FROM Dual
UNION ALL SELECT 'LANG'                  AS Parameter, SYS_CONTEXT('USERENV','LANG')                  AS Value, 'The ISO abbreviate for the language'                                                                                                    AS Description FROM Dual
UNION ALL SELECT 'LANGUAGE'              AS Parameter, SYS_CONTEXT('USERENV','LANGUAGE')              AS Value, 'The language, territory, and character of the session. In the following format:language_territory.characterset'                         AS Description FROM Dual
UNION ALL SELECT 'NETWORK_PROTOCOL'      AS Parameter, SYS_CONTEXT('USERENV','NETWORK_PROTOCOL')      AS Value, 'Network protocol used'                                                                                                                  AS Description FROM Dual
UNION ALL SELECT 'NLS_CALENDAR'          AS Parameter, SYS_CONTEXT('USERENV','NLS_CALENDAR')          AS Value, 'The calendar of the current session'                                                                                                    AS Description FROM Dual
UNION ALL SELECT 'NLS_CURRENCY'          AS Parameter, SYS_CONTEXT('USERENV','NLS_CURRENCY')          AS Value, 'The currency of the current session'                                                                                                    AS Description FROM Dual
UNION ALL SELECT 'NLS_DATE_FORMAT'       AS Parameter, SYS_CONTEXT('USERENV','NLS_DATE_FORMAT')       AS Value, 'The date format for the current session'                                                                                                AS Description FROM Dual
UNION ALL SELECT 'NLS_DATE_LANGUAGE'     AS Parameter, SYS_CONTEXT('USERENV','NLS_DATE_LANGUAGE')     AS Value, 'The language used for dates'                                                                                                            AS Description FROM Dual
UNION ALL SELECT 'NLS_SORT'              AS Parameter, SYS_CONTEXT('USERENV','NLS_SORT')              AS Value, 'BINARY or the linguistic sort basis'                                                                                                    AS Description FROM Dual
UNION ALL SELECT 'NLS_TERRITORY'         AS Parameter, SYS_CONTEXT('USERENV','NLS_TERRITORY')         AS Value, 'The territory of the current session'                                                                                                   AS Description FROM Dual
UNION ALL SELECT 'OS_USER'               AS Parameter, SYS_CONTEXT('USERENV','OS_USER')               AS Value, 'The OS username for the user logged in'                                                                                                 AS Description FROM Dual
UNION ALL SELECT 'PROXY_USER'            AS Parameter, SYS_CONTEXT('USERENV','PROXY_USER')            AS Value, 'The name of the user who opened the current session on behalf of SESSION_USER'                                                          AS Description FROM Dual
UNION ALL SELECT 'PROXY_USERID'          AS Parameter, SYS_CONTEXT('USERENV','PROXY_USERID')          AS Value, 'The identifier of the user who opened the current session on behalf of SESSION_USER'                                                    AS Description FROM Dual
UNION ALL SELECT 'SESSION_USER'          AS Parameter, SYS_CONTEXT('USERENV','SESSION_USER')          AS Value, 'The database user name of the user logged in'                                                                                           AS Description FROM Dual
UNION ALL SELECT 'SESSION_USERID'        AS Parameter, SYS_CONTEXT('USERENV','SESSION_USERID')        AS Value, 'The database identifier of the user logged in'                                                                                          AS Description FROM Dual
UNION ALL SELECT 'SESSIONID'             AS Parameter, SYS_CONTEXT('USERENV','SESSIONID')             AS Value, 'The identifier of the auditing session'                                                                                                 AS Description FROM Dual
UNION ALL SELECT 'TERMINAL'              AS Parameter, SYS_CONTEXT('USERENV','TERMINAL')              AS Value, 'The OS identifier of the current session'                                                                                               AS Description FROM Dual

select SYS_CONTEXT('USERENV','DB_NAME') from dual;

# create sequence if not exists
DECLARE    v_dummy NUMBER;  begin  select count(*) into v_dummy from all_sequences where sequence_owner = 'myuser' and sequence_name = 'myseq';  if (v_dummy = 0) then  execute immediate 'CREATE SEQUENCE myuser.myseq INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCACHE ';  end if;  end;  

select lower('BIP') from dual; -- lowercase
select upper('bip') from dual; -- uppercase

select text from all_source where owner = 'CONT' and name=upper('mytable') and type='PROCEDURE' order by line; -- works better
select text from all_source where owner = 'myschema' and name=upper('mytable') and type='TABLE' order by line; -- works better
SELECT DBMS_METADATA.GET_DDL(object_type, object_name, owner) FROM all_OBJECTS WHERE OBJECT_TYPE = 'TABLE' and OWNER='MYUSER';
SELECT dbms_metadata.get_ddl('TABLE','ADRESSE', user) FROM DUAL;
SELECT dbms_metadata.get_ddl('PROCEDURE',upper('test_meta'), 'MYUSER') FROM DUAL; -- doesn't work on other user...

select count(1) from all_procedures where owner = 'myschema' and lower(object_name || '.' || procedure_name) = 'mypkg.myfunc';


# substring substr(string, 1-based index, length)
select substr('abcdef', 0, 2) from dual; -- 'ab'
select substr('abcdef', 1, 2) from dual; -- 'ab'
select substr('abcdef', 2, 2) from dual; -- 'bc'
select substr('abcdef', 3, 2) from dual; -- 'cd'


WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$')

REGEXP_REPLACE(country_name, '(.)', '\1 ')

# REGEXP_INSTR, Searches a string for a given occurrence of a regular expression pattern and returns an integer indicating the position in the string where the match is found. You specify which occurrence you want to find and the start position. For example, the following performs a boolean test for a valid email address in the email column:
REGEXP_INSTR(email, '\w+@\w+(\.\w+)+') > 0

#REGEXP_SUBSTR Returns the substring matching the regular expression pattern that you specify. The following function uses the x flag to match the first string by ignoring spaces in the regular expression:
REGEXP_SUBSTR('oracle', 'o r a c l e', 1, 1, 'x')


# exec procedure 1
select batm.BatchSuivisCreation(410,null,null,null,null,null,null,null,null,null,null,null,null,null,null) from dual;

# exec procedure 2
declare v number;
begin 
v:= batm.BatchSuivisCreation(410,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
end;
select * from v$version;

# jdbc url jdbc
jdbc:oracle:thin:[user[/pass]]@<hostName>:<portNumber>:<sid>;  (if you have sid)
jdbc:oracle:thin:[user[/pass]]@//<hostName>:<portNumber>/serviceName; (if you have oracle service name)
jdbc:oracle:thin:[user[/pass]]@(description=(address=(protocol=tcp)(host=<hostname>)(port=<port>))(connect_data=(service_name=<servicename>)))


View			Purpose
DBA_DB_LINKS	Lists all database links in the database.
ALL_DB_LINKS	Lists all database links accessible to the connected user.
USER_DB_LINKS	Lists all database links owned by the connected user.


# dba_data_files et dba_segments n est pas accessible. user_segments l est, mais aucun idée pour l équivalent de _data_files
select df.tablespace_name "Tablespace",
totalusedspace "Used MB",
(df.totalspace - tu.totalusedspace) "Free MB",
df.totalspace "Total MB",
round(100 * ( (df.totalspace - tu.totalusedspace)/ df.totalspace))
"Pct. Free"
from
(select tablespace_name,
round(sum(bytes) / 1048576) TotalSpace
from dba_data_files 
group by tablespace_name) df,
(select round(sum(bytes)/(1024*1024)) totalusedspace, tablespace_name
from dba_segments 
group by tablespace_name) tu
where df.tablespace_name = tu.tablespace_name ;

SELECT * FROM USER_CONSTRAINTS
select * from all_constraints where upper(constraint_name) like '%mytable%';
select table_name, COLUMN_NAME from user_cons_columns where CONSTRAINT_NAME ='W1244_T0238_FK';

drop table TABLE_NAME cascade constraints purge;
alter table mssql drop constraint SYS_C003635665 cascade;
alter table mssql drop column trust_center;
alter table table_name drop (col_name1, col_name2);
alter table mssql add trust_center varchar2(2);

select * from user_constraints where table_name = 'MSSQL';


begin
	for s in (select sequence_name from user_sequences)
	loop
		execute immediate 'drop sequence ' || s.sequence_name;
	end loop;
end;
/


begin
	for s in (select table_name from user_tables)
	loop
		execute immediate 'drop table ' || s.table_name || ' cascade constraints purge';
	end loop;
end;
/

grant alter, delete, update, insert on myuser.mytable to public;

begin
	for s in (select table_name from user_tables)
	loop
		execute immediate 'grant alter, delete, update, insert on myuser.' || s.table_name || ' to public';
	end loop;
end;
/

begin
	for s in (select table_name, owner from all_tables where owner='MYUSER')
	loop
		execute immediate 'grant alter, delete, update, insert on ' || s.owner || '.' || s.table_name || ' to public';
	end loop;
end;
/
begin for s in (select table_name, owner from all_tables where owner='MYUSER') loop execute immediate 'grant alter, delete, update, insert on ' || s.owner || '.' || s.table_name || ' to public'; end loop; end; /
begin for s in (select 'grant all on ' || owner || '.' || object_name || ' to public' as q from all_objects where object_type in ('SEQUENCE','TABLE') and owner='MYUSER') loop execute immediate s.q; end loop; end;


declare v number;
begin
  dbms_output.enable;
  for s in (select table_name from user_tables order by 1)
	loop
    execute immediate 'select count(1) from ' || s.table_name into v;
    dbms_output.put_line(rpad(s.table_name || ': ', 35) ||v);		
	end loop;
end;
/

set serveroutput on format wraped;
DBMS_OUTPUT.put_line('coucou');

"""
SET SERVEROUTPUT ON

Begin
 Dbms_Output.Put_Line(Systimestamp);
End;
/
""" F5 works in sqldeveloper and output in "Script Output" tag


echo " show serveroutput " | sqlplus_myinstance;
echo " exec begin dbms_output.put_line('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');end; " | sqlplus_myinstance;



echo "
exec
begin
	DBMS_OUTPUT.put_line('ready to go ');
	for s in (select table_name from user_tables where table_name in (
		'mytable', 'mytable', 'mytable', 'mytable',
		'mytable', 'mytable', 'mytable', 'mytable',
		'mytable', 'mytable', 'mytable', 'mytable',
		'mytable', 'mytable', 'mytable', 'mytable', 'mytable',
		'mytable', 'mytable', 'mytable', 'mytable', 'mytable',
		'mytable', 'mytable', 'mytable', 'mytable',
		'mytable', 'mytable', 'mytable',
		'fasdfasdfasdfad'))
	loop
		dbms_output.put_line('truncate table myuser.' || s.table_name || ' drop storage');
		execute immediate 'truncate table myuser.' || s.table_name || ' drop storage';
	end loop;
EXCEPTION when others then
    		DBMS_OUTPUT.put_line('exception');
end;
" | tr '\n' ' ' | sqlplus_myinstance;


glogin.sql:
SET HEADING OFF
SET HEADSEP OFF
SET FEEDBACK OFF
set pagesize 50000
set lines 9000
show errors;
set serveroutput on;
--WHENEVER ERROR EXIT 11;
WHENEVER OSERROR EXIT 9;
--WHENEVER SQLERROR EXIT SQL.SQLCODE;
WHENEVER SQLERROR EXIT 10;


create or replace procedure test_meta authid current_user
as
v_str varchar2(32767);
begin
	--SELECT DBMS_METADATA.GET_DDL('TABLE', 'EMP', 'SCOTT') into v_str from dual;
SELECT dbms_metadata.get_ddl('PROCEDURE',upper('mytable'), 'CONT') into v_str  FROM DUAL;
dbms_output.put_line (v_str);
end;
/
drop procedure test_meta;


# align sequence
# fast method but with limitation 1) only works in one direction 2) the automatic number of outputlimit of sqldeveloper needs to be routed around
select myschema.myseqf.nextval from dual connect by level <= 100; -- for a 100 upgrade
select myschema.myseqf.nextval from dual connect by level <= (select max(myref) from myschema.mytable);
# method 2: drop and recreat the sequence
# method 3: more precise method
alter sequence test_seq increment by -10; -- where -10 is the desired diff, or possibly the diff - 1 (to check)
select test_seq.nextval from dual;
alter sequence test_seq increment by 1; -- restore traditionnal value


## string aggregation
# native Oracle 10g nice (returns clob) but doesnt seem possible to change separator. Oracle says its internal function and may be removed in 12c
SELECT WM_CONCAT(tx_fileid) FROM myschema.mytable where rownum < 5; 
# wm_concat allows distinct
select wmsys.wm_concat(distinct Val) as concatV from diffT;
# wm_concat supports keep (I dont know what that means)
select wmsys.wm_concat(Val) Keep(Dense_Rank First order by Val) as concatV from diffT;
SELECT EXTRACT(XMLTYPE('<doc>' || XMLAGG(XMLTYPE('<ln>' || LEVEL || ','|| CHR(10) || '</ln>')).GetClobVal() || '</doc>'), '/doc/ln/text()').GetClobVal()   FROM Dual CONNECT BY LEVEL < 2000;
SELECT EXTRACT(XMLTYPE('<doc>' || XMLAGG(XMLTYPE('<ln>' || tx_fileid || ','|| CHR(10) || '</ln>')).GetClobVal() || '</doc>'), '/doc/ln/text()').GetClobVal()   FROM myschema.mytable where rownum < 5; 
# string aggregation with list agg (Oracle 11 and above)
# but limited to varchar2(4000) as exhibited in
SELECT LISTAGG(LEVEL, CHR(10)) WITHIN GROUP (ORDER BY NULL) FROM Dual CONNECT BY LEVEL < 2000; 
# allows changing order
select ListAgg(Val,',') within group(order by sortKey desc) as concatV from diffT;
# other possibility to investigate
* SYS_CONNECT_BY_PATH => the guy on internet doesnt like that option # http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions164.htm
* APEX_UTIL.TABLE_TO_STRING => slightly different handling (input is a PL/SQL table)


select xmltype(txrefexml).extract('//explanation/text()').getStringVal() explanation from myschema.mytable

# describe with comments
select tc.column_name
,      tc.nullable
,      tc.data_type || case when tc.data_type = 'NUMBER' and tc.data_precision is not null then '(' || tc.data_precision || ',' || tc.data_scale || ')'
                            when tc.data_type like '%CHAR%' then '(' || tc.data_length || ')'
                            else null
                       end type
,      cc.comments
from   user_col_comments cc
join   user_tab_columns  tc on  cc.column_name = tc.column_name
                            and cc.table_name  = tc.table_name
where  cc.table_name = upper('mytable')
order by tc.column_id;

select tc.column_name
,      tc.nullable
,      tc.data_type || case when tc.data_type = 'NUMBER' and tc.data_precision is not null then '(' || tc.data_precision || ',' || tc.data_scale || ')'
                            when tc.data_type like '%CHAR%' then '(' || tc.data_length || ')'
                            else null
                       end type
,      cc.comments
from   all_col_comments cc
join   all_tab_columns  tc on  cc.column_name = tc.column_name
                           and cc.table_name  = tc.table_name
                           and cc.owner       = tc.owner
where  cc.owner = 'DMS' and cc.table_name = 'GENDOCUMENT'
order by tc.column_id;


myhost
cd /batch/bin; ./runsql.ksh -UB_ALL -eintegration <<< "select user, SYS_CONTEXT('USERENV','DB_NAME') from dual;";


select * from all_users;
select * from all_users where username = 'MYUSER';
select username, user_id, created from all_users;

dba_hist_active_sess_history
dba_hist_bg_event_summary
dba_hist_buffer_pool_stat
dba_hist_db_cache_advice
dba_hist_enqueue_stat
dba_hist_evcmetric_history
dba_hist_event_name
dba_hist_filemetric_history
dba_hist_filestatxs
dba_hist_latch
dba_hist_latch_children
dba_hist_latch_misses_summary
dba_hist_latch_parent
dba_hist_metric_name
dba_hist_pga_target_advice
dba_hist_pgastat
dba_hist_seg_stat
dba_hist_sga
dba_hist_sgastat
dba_hist_shared_pool_advice
dba_hist_sql_plan
dba_undo_extents
dba_tablespaces dba_triggers	
dba_hist_sql_summary
dba_hist_sql_workarea_hstgrm
dba_hist_sqlstat
dba_hist_sqltext
dba_hist_sys_time_model
dba_hist_sysmetric_history
dba_hist_sysmetric_summary
dba_hist_sysstat
dba_hist_system_event
dba_hist_waitclassmet_history
dba_hist_waitstat
dba_ind_columns
dba_lmt_free_space
dba_lmt_used_extents
dba_lobs dba_objects
dba_segments
dba_tab_col_statistics
dba_tab_columns
dba_tab_histograms
dba_tab_partitions
dba_tables
dba_tablespace_groups


# search_condition in user_constraints is of a weird type, here is a oneliner which converts it to varchar2(4000). 
# one can then filter on search_condition__ 
select user_constraints.* from user_constraints left join (select * from xmltable('/ROWSET/ROW' passing dbms_xmlgen.getXMLType('select constraint_name, search_condition from user_constraints where search_condition is not null') columns constraint_name__  varchar2(30)   path 'CONSTRAINT_NAME', search_condition__ varchar2(4000) path 'SEARCH_CONDITION')) b on constraint_name = constraint_name__
where search_condition__ is not null
and search_condition__ like '%IS NOT NULL%' ;

# this works on all_contraints but is very slow, consider heavily filtering the inner part 'select owner, constraint_name, search_condition from all_constraints where search_condition is not null'
select search_condition__, all_constraints.* from all_constraints left join (select * from xmltable('/ROWSET/ROW' passing dbms_xmlgen.getXMLType('select owner, constraint_name, search_condition from all_constraints where owner=''MYUSER'' and search_condition is not null') columns owner__ varchar2(30) path 'OWNER',constraint_name__  varchar2(30)    path 'CONSTRAINT_NAME', search_condition__ varchar2(4000) path 'SEARCH_CONDITION')) b on owner = owner__ and constraint_name = constraint_name__
where search_condition__ is not null
and search_condition__ like '%IS NOT NULL%';


# deactivate string not null
begin
	for s in (
    select search_condition__, all_constraints.owner, all_constraints.table_name, all_constraints.constraint_name from all_constraints left join (select * from xmltable('/ROWSET/ROW' passing dbms_xmlgen.getXMLType('select owner, constraint_name, search_condition from all_constraints where owner=''MYUSER'' and status=''ENABLED'' and table_name=''AFFAIREMALADIEBRANCHE'' and search_condition is not null') columns owner__ varchar2(30) path 'OWNER',constraint_name__  varchar2(30)    path 'CONSTRAINT_NAME', search_condition__ varchar2(4000) path 'SEARCH_CONDITION')) b on owner = owner__ and constraint_name = constraint_name__
    left join all_tab_cols on all_constraints.owner = all_tab_cols.owner and all_constraints.table_name = all_tab_cols.table_name  and search_condition__ = '"' || all_tab_cols.column_name || '" IS NOT NULL'
    where search_condition__ is not null
    and search_condition__ like '%IS NOT NULL'
    and data_type = 'VARCHAR2'
  )
  loop
    --mrlog('alter table ''' || s.owner || '.' || s.table_name || ' disable constraint ' || s.constraint_name  || ' cascade');
    execute immediate 'alter table ''' || s.owner || '.' || s.table_name || ' disable constraint ' || s.constraint_name  || ' cascade';
	end loop;
  commit;
end;
/

select idadre, count(1) from work.pvt_adresses group by idadre having(count(1)) > 1

DECODE(E1, E2, E3, e4, e5, E4)-- IF E1 = E2 THEN E3 ELSE E4
DECODE(E1, E2, E3, E4)-- IF E1 = E2 THEN E3 ELSE E4
NULLIF(E1, E2)        -- IF E1 = E2 THEN NULL ELSE E1
NVL(E1, E2)           -- IF E1 IS NULL THEN E2 ELSE E1
NVL2(E1, E2, E3)      -- IF E1 IS NULL THEN E3 ELSE E2


TO_DATE( string1, [ format_mask ], [ nls_language ] )
YEAR	Year, spelled out
YYYY	4-digit year
YYY
YY
Y	Last 3, 2, or 1 digit(s) of year.
IYY
IY
I	Last 3, 2, or 1 digit(s) of ISO year.
IYYY	4-digit year based on the ISO standard
RRRR	Accepts a 2-digit year and returns a 4-digit year.
A value between 0-49 will return a 20xx year.
A value between 50-99 will return a 19xx year.
Q	Quarter of year (1, 2, 3, 4; JAN-MAR = 1).
MM	Month (01-12; JAN = 01).
MON	Abbreviated name of month.
MONTH	Name of month, padded with blanks to length of 9 characters.
RM	Roman numeral month (I-XII; JAN = I).
WW	Week of year (1-53) where week 1 starts on the first day of the year and continues to the seventh day of the year.
W	Week of month (1-5) where week 1 starts on the first day of the month and ends on the seventh.
IW	Week of year (1-52 or 1-53) based on the ISO standard.
D	Day of week (1-7).
DAY	Name of day.
DD	Day of month (1-31).
DDD	Day of year (1-366).
DY	Abbreviated name of day.
J	Julian day; the number of days since January 1, 4712 BC.
HH	Hour of day (1-12).
HH12	Hour of day (1-12).
HH24	Hour of day (0-23).
MI	Minute (0-59).
SS	Second (0-59).
SSSSS	Seconds past midnight (0-86399).
FF	Fractional seconds. Use a value from 1 to 9 after FF to indicate the number of digits in the fractional seconds. For example, 'FF4'.
AM, A.M., PM, or P.M.	Meridian indicator
AD or A.D	AD indicator
BC or B.C.	BC indicator
TZD	Daylight savings information. For example, 'PST'
TZH	Time zone hour.
TZM	Time zone minute.
TZR	Time zone region
TO_DATE('2003/07/09', 'yyyy/mm/dd')-- Result: date value of July 9, 2003
TO_DATE('070903', 'MMDDYY')-- Result: date value of July 9, 2003
TO_DATE('20020315', 'yyyymmdd')-- Result: date value of Mar 15, 2002
select to_timestamp(trim(mydate), 'yyyy-mm-dd hh24:mi:ss.FF9') as mydate from mytable where mydate is not null;
select to_timestamp(trim(mydate2), 'yyyy-mm-dd hh24:mi:ss.FF9') as mydate2 from mytable where rownum = 1;

select to_char(systimestamp, 'yyyy-mm-dd hh24:mi:ss') from dual;
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(hour from systimestamp) from dual;
select extract(second from systimestamp) from dual;


select regexp_substr('SMITH,ALLEN,WARD,JONES','[^,]+', 1, level) from dual
connect by regexp_substr('SMITH,ALLEN,WARD,JONES', '[^,]+', 1, level) is not null;
REGEXP_SUBSTR('SMITH,A'
----------------------
SMITH
ALLEN
WARD
JONES

select distinct column_value from table(sys.odcinumberlist(1,1,2,3,3,4,4,5));
select column_value from table(sys.dbms_debug_vc2coll('One', 'Two', 'Three', 'Four'));
select column_value from table(sys.dbms_debug_vc2coll(1,2,3,4));


alter table myschema.mytable add ( constraint mypk primary key (idtrans) using index myschema.myindex);
alter table myschema.mytable drop primary key;
ALTER TABLE Orders ADD FOREIGN KEY (P_Id) REFERENCES Persons(P_Id)
alter table mytable add ( constraint myconstraint unique (co_myref));


# https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions074.htm
SELECT last_name, datea, 
   LEAD(datea, 1) OVER (ORDER BY datea) AS "dateb" 
   FROM employees WHERE department_id = 30;

LAST_NAME                 datea dateb
------------------------- --------- ---------
Raphaely                  07-DEC-94 18-MAY-95
Khoo                      18-MAY-95 24-JUL-97
Tobias                    24-JUL-97 24-DEC-97
Baida                     24-DEC-97 15-NOV-98
Himuro                    15-NOV-98 10-AUG-99
Colmenares                10-AUG-99


# lookup, left join with single match, see /d/sql/test_partition_by.sql
SELECT * FROM (
  SELECT
    ROW_NUMBER() OVER (PARTITION BY bb.a ORDER BY bb.idid desC) AS nb_line,
	aa.a as aa_a,
	aa.b as aa_b,
    bb.idid,
    bb.b as bb_b
	FROM aa
	    left JOIN bb ON (aa.a = bb.a)
) t3 WHERE t3.nb_line = 1 or bb_b is null order by aa_a;

# example one line from all_constraints for each constraint type
select * from (
select row_number() over (partition by cc order by 1 desc) as dd, all_constraints.* from all_constraints 
inner join (
select distinct(constraint_type) as cc from all_constraints
) bip on all_constraints.constraint_type = cc
) where dd = 1
;

select greatest(3,7) from dual; -- 7 maximum of two numbers
select    least(3,7) from dual; -- 3 minimum of two numbers
