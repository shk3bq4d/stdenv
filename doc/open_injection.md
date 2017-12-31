==OPEN_CFD==
Apsys
 dbquart1
 STETRN
  A(ccess)
  F2

==REEVAL==
manual execution
 dbquart1/apsys/dbquart1/utils> ./launch_reeval_pgb.sh
"database waiting" message dans la queue apsys.injection.DAILY.response

==COMPARISON OF transient.csv s==
f=1,2,3,4,5,6,7,26 && cut -d';' -f $f dbdaily|sort>dbdaily_truncated && cut -d';' -f $f dbuat|sort>dbuat_truncated && kdiff3 *truncated &

==EOD OF manual procedure==
[ ] dbmonth/dbquart manual injection                                                                                                                                                                                                                                              
    [ ] CFD prices
        [ ] apsys_get_rates from srvptis01:/opt/talend/jobs/LoadSecPrices/dbdaily to dbmonth:/apsys/dbmonth/dat
        [ ] apsbatch WNC CRT_I002 0
        [ ] check errors in batch
        [ ] apsbatch WNC CRT_R002 0
        [ ] check errors in batch
    [ ] IBD SDL SDG
        [ ] pause email gateway injection
        [ ] srvptis01:/opt/talend/jobs/EOD_injection/dbdaily_20120601_030002/*.INT -> /apsys/dbmonth/interfaces/accounting
        [ ] apsbatch WNC TRC_I001 0
        [ ] check errors in batch
        [ ] resume email gateway injection
    [ ] CFD
        [ ] srvptis01:/opt/talend/jobs/EOD_injection/dbdaily_20120601_030002/dbdaily_open_cfd.xls.csv to local temp location
        [ ] check target env and source file in OPENED_REPROCESS_CSV context
        [ ] make sure you have selected the right context and run locally OPENED_REPROCESS_CSV
    [ ] FX
        [ ] srvptis01:/opt/talend/jobs/EOD_injection/dbdaily_20120601_030002/dbdaily_open_fx.xls.csv to local temp location
        [ ] check target env and source file in OPENED_REPROCESS_CSV context
        [ ] make sure you have selected the right context and run locally OPENED_REPROCESS_CSV
    [ ] FX Integral
        [ ] srvptis01:/opt/talend/jobs/EOD_injection/dbdaily_20120601_030002/dbdaily_open_fx_inl.xls.csv to local temp location
        [ ] check target env and source file in OPENED_REPROCESS_CSV context
        [ ] make sure you have selected the right context and run locally OPENED_REPROCESS_CSV
    [ ] fxinj.jar dbmonth on srvpapi01
    [ ] wait 10 minutes then launch /apsys/specific/launch_reeval_pgb.sh
    [ ] inform finance
 
~                                                                                                                                                                                                                                                                                 
~                                                                                                                 
