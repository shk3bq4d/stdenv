# /* ex: set ft=sql: */

       .backup ?DB? FILE      Backup DB (default "main") to FILE
       .bail on|off           Stop after hitting an error.  Default OFF
       .clone NEWDB           Clone data into NEWDB from the existing database
       .databases             List names and files of attached databases
       .dump ?TABLE? ...      Dump the database in an SQL text format
                                If TABLE specified, only dump tables matching
                                LIKE pattern TABLE.
       .echo on|off           Turn command echo on or off
       .eqp on|off            Enable or disable automatic EXPLAIN QUERY PLAN
       .exit                  Exit this program
       .explain ?on|off?      Turn output mode suitable for EXPLAIN on or off.
                                With no args, it turns EXPLAIN on.
       .fullschema            Show schema and the content of sqlite_stat tables
       .headers on|off        Turn display of headers on or off
       .help                  Show this message
       .import FILE TABLE     Import data from FILE into TABLE
       .indices ?TABLE?       Show names of all indices
                                If TABLE specified, only show indices for tables
                                matching LIKE pattern TABLE.
       .load FILE ?ENTRY?     Load an extension library
       .log FILE|off          Turn logging on or off.  FILE can be stderr/stdout
       .mode MODE ?TABLE?     Set output mode where MODE is one of:
                                csv      Comma-separated values
                                column   Left-aligned columns.  (See .width)
                                html     HTML <table> code
                                insert   SQL insert statements for TABLE
                                line     One value per line
                                list     Values delimited by .separator string
                                tabs     Tab-separated values
                                tcl      TCL list elements
       .nullvalue STRING      Use STRING in place of NULL values
       .once FILENAME         Output for the next SQL command only to FILENAME
       .open ?FILENAME?       Close existing database and reopen FILENAME
       .output ?FILENAME?     Send output to FILENAME or stdout
       .print STRING...       Print literal STRING
       .prompt MAIN CONTINUE  Replace the standard prompts
       .quit                  Exit this program
       .read FILENAME         Execute SQL in FILENAME
       .restore ?DB? FILE     Restore content of DB (default "main") from FILE
       .save FILE             Write in-memory database into FILE
       .schema ?TABLE?        Show the CREATE statements
                                If TABLE specified, only show tables matching
                                LIKE pattern TABLE.
       .separator STRING ?NL? Change separator used by output mode and .import
                                NL is the end-of-line mark for CSV
       .shell CMD ARGS...     Run CMD ARGS... in a system shell
       .show                  Show the current values for various settings
       .stats on|off          Turn stats on or off
       .system CMD ARGS...    Run CMD ARGS... in a system shell
       .tables ?TABLE?        List names of tables
                                If TABLE specified, only list tables matching
                                LIKE pattern TABLE.
       .timeout MS            Try opening locked tables for MS milliseconds
       .timer on|off          Turn SQL timer on or off
       .trace FILE|off        Output each SQL statement as it is run
       .vfsname ?AUX?         Print the name of the VFS stack
       .width NUM1 NUM2 ...   Set column widths for "column" mode
                                Negative values right-justify


# https://www.sqlite.org/lang_corefunc.html

select strftime('%Y.%m.%d %H:%M:%S', datetime(datecre / 1000, 'unixepoch')), * from mytable order by mycol desc;
select strftime('%Y.%m.%d %H:%M:%S', last_modified), * from qc order by last_modified desc;

select * from mytable where length(mycol) >= 100;
select length(mycol), * from mytable where length(mycol) >= 80 order by 1 desc;

create index myindex on mytable(mycol);

```markdown
# Substr
SQLite substr() returns the specified number of characters from a particular position of a given string.
Syntax:
substr(X,Y,Z);
Name	Description
X	A string from which a substring is to be returned.
Y	An integer indicating a string position within the string X.
Z	An integer indicating a number of characters to be returned.
If Z is omitted then substr(X,Y) returns all characters through the end of the string X beginning with the Y-th. The left-most character of X is number 1. If Y is negative then the first character of the substring is found by counting from the right rather than the left. If Z is negative then the abs(Z) characters preceding the Y-th character are returned.
```

SELECT replace(mycol1, 'prefix..', '.') AS mycol2,
strftime('%Y-%m-%d', datetime(datecre / 1000, 'unixepoch')) as txcreation,
strftime('%Y-%m-%d %H:%M:%S', datetime(datecre / 1000, 'unixepoch')) as txcreationfull,
datecre AS datec,
'TALEND' AS myref,
TXSTATUS
FROM mytable
WHERE datetime(datecre / 1000, 'unixepoch') BETWEEN  date(CURRENT_DATE, '-1 day')  AND CURRENT_DATE AND TXSTATUS <> 'replaymanuel'
and mycol in (5068783, 5008783);

select CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP;
select date(CURRENT_DATE, '-10 day'

SELECT date('now'); -- Compute the current date.

SELECT date('now','start of month','+1 month','-1 day'); -- Compute the last day of the current month.

SELECT datetime(1092941466, 'unixepoch'); -- Compute the date and time given a unix timestamp 1092941466.

SELECT datetime(1092941466, 'unixepoch', 'localtime'); -- Compute the date and time given a unix timestamp 1092941466, and compensate for your local timezone.

SELECT strftime('%s','now'); -- Compute the current unix timestamp.

SELECT julianday('now') - julianday('1776-07-04'); -- Compute the number of days since the signing of the US Declaration of Independence.

SELECT strftime('%s','now') - strftime('%s','2004-01-01 02:34:56'); -- Compute the number of seconds since a particular moment in 2004:

SELECT date('now','start of year','+9 months','weekday 2'); -- Compute the date of the first Tuesday in October for the current year.

SELECT (julianday('now') - 2440587.5)*86400.0; -- Compute the time since the unix epoch in seconds (like strftime('%s','now') except includes fractional part):


rowid

select owner, detected_by as detected, id, status, case when Livraison_cible is null then '' when Livraison_cible like '% SR %' then Livraison_cible else 'a' || Livraison_cible end as 'L.Cible', last_modified, name from qc
where
(      owner in('rutom','butryj','datessid','prettm','cavatera','trossart','spantonm') or
detected_by  in('rutom','butryj','datessid','prettm','cavatera','trossart','spantonm'))
and status not in ('Closed', 'Refused')
and detected_by not in ('penvent')
order by
case when Livraison_cible is null then 'b' when Livraison_cible like '% SR %' then Livraison_cible else 'a' || Livraison_cible end,
id
;


select ref, count(1) from mytable where total_count is not null group by ref
bip	9806
bip	582




select jour, ref, total_count, count(1) from (
select strftime('%Y.%m.%d', datetime(datecre / 1000, 'unixepoch')) as jour, ref, total_count  from mytable where mycol > 5200000
) group by jour, ref, total_count
order by jour, ref
2014.11.12 	 bip 	 <null> 	 901
2014.11.12 	 bip 	 <null> 	 382
2014.11.12 	 bip 	 2      	 35
2014.11.12 	 bip 	 <null> 	 171
2014.11.12 	 bip 	 <null> 	 1409
2014.11.12 	 bip 	 <null> 	 235
2014.11.12 	 bip 	 <null> 	 1780
2014.11.12 	 bip 	 <null> 	 27805
2014.11.13 	 bip 	 <null> 	 687
2014.11.13 	 bip 	 <null> 	 2248
2014.11.13 	 bip 	 2      	 74
2014.11.13 	 bip 	 <null> 	 942
2014.11.13 	 bip 	 <null> 	 6059
2014.11.13 	 bip 	 <null> 	 207
2014.11.13 	 bip 	 <null> 	 26
2014.11.13 	 bip 	 <null> 	 4899
2014.11.13 	 bip 	 <null> 	 4135
2014.11.14 	 bip 	 <null> 	 1573
2014.11.14 	 bip 	 <null> 	 2274
2014.11.14 	 bip 	 2      	 107
2014.11.14 	 bip 	 <null> 	 1607
2014.11.14 	 bip 	 <null> 	 3839
2014.11.14 	 bip 	 <null> 	 335
2014.11.14 	 bip 	 <null> 	 24
2014.11.14 	 bip 	 <null> 	 4580
2014.11.14 	 bip 	 <null> 	 25243
2014.11.15 	 bip 	 <null> 	 2
2014.11.16 	 bip 	 <null> 	 830
2014.11.16 	 bip 	 <null> 	 2531
2014.11.16 	 bip 	 2      	 72
2014.11.16 	 bip 	 <null> 	 2419
2014.11.16 	 bip 	 <null> 	 4872
2014.11.16 	 bip 	 <null> 	 223
2014.11.16 	 bip 	 <null> 	 2
2014.11.16 	 bip 	 <null> 	 3509
2014.11.16 	 bip 	 <null> 	 9580
2014.11.17 	 bip 	 2      	 6

select * from fec_ limit 1;

DROP TABLE [IF EXISTS] [schema_name.] table_name;
