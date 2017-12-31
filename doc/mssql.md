# /* ex: set ft=sql: */

select * from sys.tables left join sys.columns on tables.object_id = columns.object_id where columns.name='admod_partenaire_utilisateur_fk';

select tables.name, columns.name, len(columns.name) as length from sys.tables left join sys.columns on tables.object_id = columns.object_id where len(columns.name) >= 30 order by length desc;


SELECT len(name) as length, name FROM sys.Columns order by len(name) desc;

SELECT name FROM sys.Tables where name like 'GM_%' and name not in ('gm_adresse_modalite')


select * FROM sys.Columns;


-- renommer renommage de colonne
EXEC sp_RENAME 'gm_adresse_modalite.admod_partenaire_utilisateur_fk' , 'admod_partenaire_utilisateu_fk', 'COLUMN';
EXEC sp_RENAME 'gm_sedex_decree_detail.seddd_link_sedex_decree_detail_fk' , 'seddd_link_sedex_decree_dtl_fk', 'COLUMN'


-- trouble shoot sp_MSForEachTable
create table bip (id varchar(4000));
EXEC sp_MSForEachTable 'insert into bip values (''?'')'


-- http://stackoverflow.com/questions/155246/how-do-you-truncate-all-tables-in-a-database-using-tsql#156813
-- When dealing with deleting data from tables which have foreign key relationships - which is basically the
-- case with any properly designed database - we can disable all the constraints, delete all the data and then
-- re-enable constraints

-- disable all constraints
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- delete data in all tables
EXEC sp_MSForEachTable "DELETE FROM ?"

-- enable all constraints
exec sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"


-- truncate
EXEC sp_MSForEachTable 'TRUNCATE TABLE ?'


Select * into new_table  from  old_table 


SELECT * INTO bip FROM (SELECT 'fsdkfjsdfljsdklfjsdkljfksdjfjdslfjsdjflsd' as col1) as [fancy derived table] ;
insert into bip values ('hehe');



-- with constraint try multiple times
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
EXEC sp_MSForEachTable 'drop table ?'

jdbc:jtds:sqlserver://GMASSQL23:1433/SupraTransfert_GM;instance=MUT2S;domain=GROUPE-MUTUEL

SELECT * FROM sys.objects WHERE type_desc LIKE '%CONSTRAINT';

SELECT RC.CONSTRAINT_NAME FK_Name
, KF.TABLE_SCHEMA FK_Schema
, KF.TABLE_NAME FK_Table
, KF.COLUMN_NAME FK_Column
, RC.UNIQUE_CONSTRAINT_NAME PK_Name
, KP.TABLE_SCHEMA PK_Schema
, KP.TABLE_NAME PK_Table
, KP.COLUMN_NAME PK_Column
, RC.MATCH_OPTION MatchOption
, RC.UPDATE_RULE UpdateRule
, RC.DELETE_RULE DeleteRule
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KF ON RC.CONSTRAINT_NAME = KF.CONSTRAINT_NAME
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KP ON RC.UNIQUE_CONSTRAINT_NAME = KP.CONSTRAINT_NAME;
