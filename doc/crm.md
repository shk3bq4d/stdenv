#tables
do0 => 'do' as in 'dossier' PORTFOLIO
pe0 => 'pe' as in 'person'  PERSON
so0 => 'so' as in 'societe' COMPANIES

#describe table
exec sp_columns do0;

pe0
	adresse_prive
	adresse2_prive
	adresse2_2
	adresse3_2

#join
select * from SYSADM.pe0, SYSADM.do0 where do0.ref < '001000010' and pe0.nrid = do0.pe0_nrid  order by do0.ref ;

Structure CRM :

Companies : 
table                      SYSADM.so0
Key                        CD
Team                     xregion
Main owner       Titulaire
Other owners -> Table so3
                                                Lien so0.nrid = so3.so0_nrid


Individuals : 
table                      SYSADM.pe0
Key                        CD
Main owner       Titulaire
Other owners -> Table pe3
                                                Lien pe0.nrid = so3.pe0_nrid

Pour info :

Portfolios :
table                      SYSADM.do0
Key                        ref
Lien avec pe0 ou so0 : 

do0.pe0_nrid = pe0.nrid
ou
do0.so0_nrid = so0.nrid


Accès CRMTEST :

Server : CHECMDB02
DB : CRMTEST
Login : SYSADM
Password : SYSADM



-- 169 is Apsys idpersl
select  
 pe0.cd As ClientID, 
 pe0.prenom +' ' +  pe0.personne AS FullName,  
 sp0.societe as Company, 
 isnull(pe0.adresse_prive,'')   + ' ' + isnull(pe0.code_post_prive,'') + ' ' + isnull(pe0.loc_prive,'') + ' '  + isnull(pe0.pays_prive,'') as AddressOfOrigin, 
   pe0.xe_mail_1 as ContactEmailAdress,
   pe0.titulaire as Owner,
   (select replace(replace(replace((select personne as 'p' from sysadm.pe3
where pe0_nrid = pe0.nrid
for xml path ('')),'</p><p>',','),'<p>',''),'</p>','')) as AllOwners
from sysadm.pe0 pe0 
 left join sysadm.sp0 sp0 
  on pe0.nrid = sp0.pe0_nrid 
where pe0.cd = 169
union 
select  
 so0.cd As ClientID,  
 so0.societe as Fullname, 
 '' as Company,
isnull(so0.adresse,'')   + ' ' + isnull(so0.street_nb,'') + ' ' + isnull(so0.code_post,'') + ' ' + isnull(so0.loc,'') + ' '  + isnull(so0.pays,'') as AddressOfOrigin, 
 so0.e_mail as ContactEmailAdress,
    so0.titulaire as Owner,
   (select replace(replace(replace((select personne as 'p' from sysadm.so3
where so0_nrid = so0.nrid
for xml path ('')),'</p><p>',','),'<p>',''),'</p>','')) as AllOwners
from sysadm.so0 
where so0.cd = 169
