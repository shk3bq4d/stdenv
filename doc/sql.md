# /* ex: set ft=sql: */


# filter group max on one column and still get the other columns
select 
  secident,  marketcode,  currencycode,  secpriceexpr,  quote,  quotedate,  ratetype,  genrateident
  from talend.snap_tit_prices, 
  ( select
      secid as mrtemp_secid,
      max(tit_lotnum) as mrtemp_tit_lotnum
      from talend.snap_tit_prices
    where 
      dtcptl='%s'
    group by
      secid
  ) mrtemp
  where
    dtcptl='%s' and
    secid = mrtemp_secid and
    tit_lotnum = mrtemp_tit_lotnum
  order by
    secident;

# statistics last few injections
SELECT
  injTot,
  injOK,
  injKO,
  NotProcessed,
  min_dtstamp,
  max_ts_processed,
  product_type,
  lotnum, name_,
  processed_,
  to_char(lmod_, 'YYYY.mm.dd HH24:MI') as lmod_,
  to_char(crea_, 'YYYY.mm.dd HH24:MI') as crea_
from
(select 
  sum(1) AS injTot,
  sum(case when apsys_error_code = 1 then 1 else 0 end) AS injOK, 
  sum(case when apsys_error_code <> 1 then 1 else 0 end) AS injKO, 
  sum(case when apsys_error_code is null then 1 else 0 end) AS NotProcessed,
  to_char(min(dtstamp), 'YYYY.mm.dd HH24:MI') as min_dtstamp,
  to_char(max(ts_processed), 'YYYY.mm.dd HH24:MI') as max_ts_processed,
  max(product_type) as product_type,
  lotnum
from TALEND.apsys_inj_java_api j
group by lotnum
) j
join talend.signals s on j.lotnum = s.int_param0_
order by lotnum desc
;



sqlplus -s apsys/apsys <<! | tee ~/public/sqlplus.out
select * from talend.signals;
!

#ReadyToExecute
sqlplus -s apsys/apsys <<! | tee ~/public/sqlplus.out
MERGE INTO talend.signals d
USING
        (SELECT 'ReadyToExecute-OPENED_MAIN_INJ_JOB-'||trim(to_char(dtcptl)) name_, 0 processed_ , SYSTIMESTAMP lmod_
                from apsys.parmsgen) s
ON (d.name_ = s.name_)
WHEN MATCHED THEN UPDATE SET d.processed_ = s.processed_, d.lmod_ = s.lmod_
WHEN NOT MATCHED THEN INSERT (name_, processed_, lmod_) VALUES (s.name_, s.processed_, s.lmod_);
COMMIT;
!

#statistics to choose the order of the where clauses on mt4_reporting mt4_trades
SELECT 
  sum(1) AS total,
  sum(case when LOGIN <= 1999 then 1 else 0 end) AS LOGIN1999,
  sum(case when CMD in (0,1) then 1 else 0 end) AS cmd01,
 sum(case when CLOSE_TIME>'2012-01-12 00:00:00' then 1 else 0 end) as close_time0,
 sum(case when  CLOSE_TIME='1970-01-01 00:00:00' then 1 else 0 end) as close_time1,
sum(case when OPEN_TIME < '2012-01-12 00:00:00' then 1 else 0 end) as open_time0,
0 as lastcolumn
  from `real2`.`mt4_trades`;


# switch between meta trade mt titre names and apsys name
select * from apsys.rcptiex;
select (idtis || '.' || gres || '.' || grecps), idiexs from apsys.rtitiex where 
(idtis || '.' || gres || '.' || grecps) in ( '100000011.671.L08', '100000011.671.S08', '100010011.670.L03', '100010011.670.S03', '100010021.670.S03');

#pl sql example
declare
	var_lotnum number(16);
	var_rowcount number(16);
begin
	DBMS_OUTPUT.PUT_LINE('begin '|| systimestamp);
	select talend.fx_lotnum_seq.nextval into var_lotnum from dual;
	insert into TALEND.apsys_inj_java_api (id, dtstamp, xml_msg, src_platform, product_type, lotnum, comment_)
	(	select
			talend.fx_order_seq.nextval as id,
			systimestamp as dtstamp,
			xml_msg,
			src_platform,
			product_type,
			var_lotnum as lotnum,
			'reprocess id:'||id as comment_
		from TALEND.apsys_inj_java_api
		where
			lotnum = 471
	);
	var_rowcount := SQL%ROWCOUNT;
	DBMS_OUTPUT.PUT_LINE(var_rowcount);
	if var_rowcount = 0
	then
		DBMS_OUTPUT.PUT_LINE('no signals generated');		
	else
		insert into TALEND.signals (name_, processed_, lmod_, crea_, int_param0_, str_param0_, num_param0_)
		values
		(
			'ReadyToExecute-ApsysInjJavaApi-' || var_lotnum,
			0,
			systimestamp,
			systimestamp,
			var_lotnum,
			(select product_type from TALEND.apsys_inj_java_api where lotnum = var_lotnum and rownum <= 1),
			var_rowcount
		);
	end if;
	commit;
exception
	when others then
		rollback;
end;


# list internal accounts used in injection that don t have NOK currency
select distinct(bip) from
(
select a.idcll || '.' || a.grecpts || a.seqc as bip, a.idcll as idcll, a.grecpts as grecpts, a.seqc as seqc, a.devs as adevs, b.devs as bdevs from compte a
left join compte b on
a.idcll = b.idcll and
a.grecpts = b.grecpts and
a.seqc = b.seqc and
b.devs = 'NOK'
where
b.devs is null and
a.idcll || '.' || a.grecpts  || a.seqc in (
'84900150.100',
'84900100.100',
'84900600.100',
'84900700.100',
'82000300.100',
'84801200.100',
'84801100.100',
'84901800.100',
'84801300.100',
'84900450.100',
'84900300.100',
'79999900.100',
'80699999.741'
	)
order by b.devs
) order by bip;

describle explain:
	desc tdstrc;
	string.html:
		/^\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(.*)$/gmi
		tdstrc.$1 as tdstrc_$1,

extract xml:
select
	trim(substr(xml_msg,instr(xml_msg, '<SpotPrice>') + length('<SpotPrice>'),	instr(xml_msg, '</SpotPrice') - instr(xml_msg, '<SpotPrice') - length('<SpotPrice>'))) as SpotPrice,
	trim(substr(xml_msg,instr(xml_msg, '<NUCTRS>') + length('<NUCTRS>'),	instr(xml_msg, '</NUCTRS') - instr(xml_msg, '<NUCTRS') - length('<NUCTRS>'))) as NUCTRS,
	trim(substr(xml_msg,instr(xml_msg, '<DEV_1>') + length('<DEV_1>'),	instr(xml_msg, '</DEV_1') - instr(xml_msg, '<DEV_1') - length('<DEV_1>'))) as DEV_1,
	trim(substr(xml_msg,instr(xml_msg, '<DEV_2>') + length('<DEV_2>'),	instr(xml_msg, '</DEV_2') - instr(xml_msg, '<DEV_2') - length('<DEV_2>'))) as DEV_2,
	apsys_inj_java_api.*
from talend.apsys_inj_java_api where lotnum in (1032, 1034) and src_platform='real2' and (xml_msg like '%USD%RUB%' or xml_msg like '%USD%EUR%') order by NUCTRS, id desc;


update `apsys_gen_gateway`.`auth` set dbuk_auth=1, dbdaily_auth=1 where email_addr='d.paglia@migbank.com';
select to_date(to_char(20101231, '0000g00g00','nls_numeric_characters=,.') || ' ' || to_char('235959', '00g00g00','nls_numeric_characters=.:'), 'YYYY.MM.DD  HH24:MI:SS') from dual;
select to_char(20101231, '99G999G999G999D99', 'nls_numeric_characters = ''.''''') from dual;
select to_char(20101231.432, '99G999G999G999D99', 'nls_numeric_characters = ''.''''') from dual;

select tdsmee.cdtypmsgc, tdsmee.fiches, tdsmee.sndrs, tdsmee.msgtexts from tdsmee where cast(trim(tdsmee.fiches) as number) = ?


select
tdstrc.*,
tdsmpm.*,
tdsmpmax.*,
tdsmee.*
from apsys.tdstrc, apsys.tdsmpm, apsys.tdsmpmax, apsys.tdsmee
where
tdstrc.fiches = 754334
and tdstrc.cdops = 'BKD' and tdstrc.orddtcptl = tdsmpm.dtcptl and tdstrc.ordnusesi = tdsmpm.nusesi and tdstrc.ordfiches = tdsmpm.fiches and tdsmee.dtcptl = tdsmpmax.oridtcptl and tdsmee.nusesi = tdsmpmax.orinusesi and tdsmee.fiches = tdsmpmax.orifiches and tdsmpm.dtcptl = tdsmpmax.dtcptl and tdsmpm.nusesi = tdsmpmax.nusesi and tdsmpm.fiches = tdsmpmax.fiches;


#mysql
mysql -u root -p 
create user mrusername identified by 'mrpassword';
help
show
create database `mrdatabase`;
select Host, User from mysql.user;

# execute function oracle plsql pl/sql
begin
    CONT.USAFEACQUISITEURS_();
end;

#paramètre d exécution sur le tac

begin
	for s in (select sequence_name from user_sequences)
	loop
		execute immediate 'drop sequence ' || s.sequence_name;
	end loop;
end;
/

-- https://stackoverflow.com/questions/38549/difference-between-inner-and-outer-joins?rq=1
-- Assuming you're joining on columns with no duplicates, which is a very common case:
-- An inner join of A and B gives the result of A intersect B, i.e. the inner part of a venn diagram intersection.
-- An outer join of A and B gives the results of A union B, i.e. the outer parts of a venn diagram union.
-- Examples
-- Suppose you have two Tables, with a single column each, and data as follows:
-- 
-- A    B
-- -    -
-- 1    3
-- 2    4
-- 3    5
-- 4    6
-- Note that (1,2) are unique to A, (3,4) are common, and (5,6) are unique to B.
-- 
-- Inner join
-- 
-- An inner join using either of the equivalent queries gives the intersection of the two tables, i.e. the two rows they have in common.
-- 
-- select * from a INNER JOIN b on a.a = b.b;
-- select a.*,b.*  from a,b where a.a = b.b;
-- 
-- a | b
-- --+--
-- 3 | 3
-- 4 | 4
-- Left outer join
-- 
-- A left outer join will give all rows in A, plus any common rows in B.
-- 
-- select * from a LEFT OUTER JOIN b on a.a = b.b;
-- select a.*,b.*  from a,b where a.a = b.b(+);
-- 
-- a |  b  
-- --+-----
-- 1 | null
-- 2 | null
-- 3 |    3
-- 4 |    4
-- Full outer join
-- 
-- A full outer join will give you the union of A and B, i.e. All the rows in A and all the rows in B. If something in A doesn't have a corresponding datum in B, then the B portion is null, and vice versa.
-- 
-- select * from a FULL OUTER JOIN b on a.a = b.b;
-- 
 -- a   |  b  
-- -----+-----
--    1 | null
--    2 | null
--    3 |    3
--    4 |    4
-- null |    6
-- null |    5
