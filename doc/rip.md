
select 
messagetechid,
messagetype,
businessprocessid,
action,
ripdecreeinventoryelements.decreeinventorytechid,
ripdecreeinventoryelements.decreeinventoryelementtechid,
ripmessage.datecre
from myref.ripmessage
left join myref.ripheader on ripmessage.headertechid = ripheader.headertechid
left join myref.ripcontent on ripmessage.contenttechid = ripcontent.contenttechid
left join myref.ripdecreeinventory on myref.ripcontent.decreeinventorytechid = ripdecreeinventory.decreeinventorytechid
left join myref.ripdecreeinventoryelements on ripdecreeinventory.decreeinventorytechid = ripdecreeinventoryelements.decreeinventorytechid
left join myref.ripdecreeinventoryelement  on ripdecreeinventoryelements.decreeinventoryelementtechid = ripdecreeinventoryelement.decreeinventoryelementtechid
where
messagetechid=221006 and
messagetype=5203 and
ripmessage.usercre = user

order by ripmessage.datecre desc
;
