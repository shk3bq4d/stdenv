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
