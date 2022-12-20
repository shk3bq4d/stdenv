# /* ex: set filetype=sql fenc=utf-8 expandtab ts=4 sw=4 : */
https://zabbix.group.local/tr_events.php?triggerid=1146099&eventid=640652792
```bash
~/git/git.zabbix.com/scm/zbx/zabbix/create/bin/gen_schema.pl mysql # create table database schema
```

select * from triggers       where triggerid=1146099 limit 1\G;
select * from events         where eventid=640652792 limit 1\G;
select * from problem        where eventid=640652792 limit 1\G;
select * from event_recovery where eventid=640652792 or r_eventid=640652792 or c_eventid=64065272;
insert into events  (eventid) values (640652792);
begin; update low_priority problem set r_eventid=640652792 where  eventid=640652792 limit 5;
select count(1) as total from problem; -- total problems;
select count(1) as total from problem where r_eventid is null; -- total unresolved problems
select * from problem left join triggers on problem.objectid = triggers.triggerid where triggers.triggerid is null and problem.r_eventid is null limit 3\G -- unresolved problems where associated trigger does not exists
select count(1) from problem left join triggers on problem.objectid = triggers.triggerid where triggers.triggerid is null and problem.r_eventid is null; -- total unresolved problems where associated trigger does not exists
select count(1) from problem left join triggers on problem.objectid = triggers.triggerid where triggers.triggerid is null; -- total problems where associated trigger does not exists
select * from triggers       where triggerid=34960 limit 1\G;
select * from triggers       where triggerid=322523 limit 1\G;


-- clean up problems that appear on dashboard but shows up as "No permissions to referred object or it does not exist!"
--- case 1: unresolved problem that links to a non-existing event
select *        from problem left join events eventsa on problem.eventid = eventsa.eventid where eventsa.eventid is null and problem.r_eventid is null limit 3\G -- unresolved problem where associated created event does not exists
select count(1) from problem left join events eventsa on problem.eventid = eventsa.eventid where eventsa.eventid is null and problem.r_eventid is null;    -- total unresolved problem where associated created event does not exists
create table _problem_20220106_nonexistingevent_case1 as select problem.* from problem left join events eventsa on problem.eventid = eventsa.eventid where eventsa.eventid is null and problem.r_eventid is null limit 1000000;
select count(1) from problem where eventid in
select count(1) from problem where r_eventid is null and not exists (select * from events where events.eventid = problem.eventid);
begin; delete low_priority from problem where r_eventid is null and not exists (select * from events where events.eventid = problem.eventid);
-- commit
-- optimize table problem;

-- cleanup problems where eventid foreign key fails
select count(1) from problem where not exists (select * from events where events.eventid = problem.eventid);
select count(1) from problem where eventid not in (select eventid from events);
create table _problem_20220106_foreignkey_eventid_fails as select * from problem where not exists (select * from events where events.eventid = problem.eventid) limit 1000000;
-- set sql_safe_updates=0;
begin; delete low_priority from problem where eventid not in (select eventid from events);
-- commit
-- set sql_safe_updates=1;
-- optimize table problem;


select distinct tt.triggertagid,tt.triggerid,tt.tag,tt.value from
trigger_tag tt,
triggers t,
hosts h,
items i,
functions f
where t.triggerid=tt.triggerid and t.flags<>2 and h.hostid=i.hostid and i.itemid=f.itemid and f.triggerid=tt.triggerid and h.status in (0,1)

-- foreign key checks
select count(1) from problem     where eventid   not in (select eventid   from events);
select count(1) from trigger_tag where triggerid not in (select triggerid from triggers);
select count(1) from items       where hostid    not in (select hostid    from hosts);
select count(1) from functions   where itemid    not in (select itemid    from items);
select count(1) from functions   where triggerid not in (select triggerid from triggers);
select count(1) from hosts_groups where hostid not in (select hostid from hosts);
select count(1) from hosts_groups where groupid not in (select groupid from hstgrp);



select distinct t.triggerid,t.description,t.expression,t.error,t.priority,t.type,t.value,t.state,t.lastchange,t.status,t.recovery_mode,t.recovery_expression,t.correlation_mode,t.correlation_tag,t.opdata,t.event_name,null,null,null from hosts h,items i,functions f,triggers t where h.hostid=i.hostid and i.itemid=f.itemid and f.triggerid=t.triggerid and h.status in (0,1) and t.flags<>20;
select count(1) from (select distinct t.triggerid,t.description,t.expression,t.error,t.priority,t.type,t.value,t.state,t.lastchange,t.status,t.recovery_mode,t.recovery_expression,t.correlation_mode,t.correlation_tag,t.opdata,t.event_name,null,null,null from hosts h,items i,functions f,triggers t where h.hostid=i.hostid and i.itemid=f.itemid and f.triggerid=t.triggerid and h.status in (0,1) and t.flags<>20) b;
show index from hosts;

-- add primary key after upgrade to zabbix 6
alter table history      add primary key (itemid,clock,ns);
alter table history_log  add primary key (itemid,clock,ns);
alter table history_text add primary key (itemid,clock,ns);
alter table history_str  add primary key (itemid,clock,ns);
alter table history_uint add primary key (itemid,clock,ns);

-- activate mysql scheduler for k8s zabbix partitioning
set global event_scheduler = on;

alter database zabbix character set utf8 collate utf8mb3_bin;


select itemid, date_format(from_unixtime(clock), "%Y.%m.%d %H:%i:%s"), num, value_min, value_avg, value_max from trends_uint where itemid = 29020;
select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43245 itemid, '2021-09-22' dt, 13586 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43245 itemid, '2021-09-22' dt, 13586 v) b;
delete from trends_uint where itemid = 43245 limit 1;
-- 1.82
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43245 itemid, '2021-09-22' dt, 19052 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43245 itemid, '2021-09-24' dt, 19076 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43245 itemid, '2021-09-27' dt, 19134 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43245 itemid, '2021-10-04' dt, 19236 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43245 itemid, '2021-10-12' dt, 19396 v) b;

-- 1.80
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43248 itemid, '2021-09-22' dt, 32639 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43248 itemid, '2021-09-24' dt, 32675 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43248 itemid, '2021-09-27' dt, 32738 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43248 itemid, '2021-10-04' dt, 32871 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43248 itemid, '2021-10-12' dt, 33121 v) b;

-- 1.81
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43246 itemid, '2021-09-22' dt, 13586 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43246 itemid, '2021-09-24' dt, 13598 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43246 itemid, '2021-09-27' dt, 13603 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43246 itemid, '2021-10-04' dt, 13635 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43246 itemid, '2021-10-12' dt, 13724 v) b;

-- 2.80
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43254 itemid, '2021-09-22' dt, 12621 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43254 itemid, '2021-09-24' dt, 12678 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43254 itemid, '2021-09-27' dt, 12741 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43254 itemid, '2021-10-04' dt, 12909 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43254 itemid, '2021-10-12' dt, 13050 v) b;

-- 2.81
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43250 itemid, '2021-09-22' dt, 9022 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43250 itemid, '2021-09-24' dt, 9078 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43250 itemid, '2021-09-27' dt, 9110 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43250 itemid, '2021-10-04' dt, 9243 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43250 itemid, '2021-10-12' dt, 9354 v) b;

-- 2.82
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43251 itemid, '2021-09-22' dt, 3593 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43251 itemid, '2021-09-24' dt, 3599 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43251 itemid, '2021-09-27' dt, 3630 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43251 itemid, '2021-10-04' dt, 3666 v) b;
insert into trends_uint (itemid, clock, num, value_min, value_avg, value_max) select itemid, unix_timestamp(concat(dt,' 12:00:00')), 1, v, v, v from ( select 43251 itemid, '2021-10-12' dt, 3696 v) b;

select itemid, date_format(from_unixtime(clock), "%Y.%m.%d %H:%i:%s"), num, value_min, value_avg, value_max from trends_uint where itemid in (43245, 43248, 43246, 43254, 43250, 43251);

select * from (select itemid, clock, ns, value from history_uint where itemid = 30253 order by clock desc, ns desc limit 1) b;
select itemid, clock, ns, value from history_uint where itemid = 30253 order by clock desc, ns desc limit 1;
with ab as (select itemid, clock, ns from history_uint where itemid = 30253 order by clock desc, ns desc limit 1) delete from history_uint where (itemid, clock, ns) in ab limit 5;
with ab as (select itemid, clock, ns from history_uint where itemid = 30253 order by clock desc, ns desc limit 1) select * from ab;
with ab as (select itemid, clock, ns from history_uint where itemid = 30253 order by clock desc, ns desc limit 1) delete from history_uint where (itemid, clock, ns) in ab limit 5;
delete from history_uint where (itemid, clock, ns) = (select itemid, clock, ns from history_uint where itemid = 30253 order by clock desc, ns desc limit 1) limit 1; -- slow as hell
delete from history_uint where (itemid, clock, ns) = (select itemid, clock, ns from history_uint where itemid = 43250 order by clock desc, ns desc limit 1) limit 1; -- slow as hell, 19 seconds on ly
