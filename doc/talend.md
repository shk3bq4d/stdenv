Jobscript temp directory: C:\Users\myuser\global\apps\Talend-4.2.2\cmdline\studio\workspace\EOD_INJECTION\temp

c:\local\apsys\apsys_eod_trc_i.properties

reprocess open fx: (local execution)
- switch branch to correct one
- open "log table" component, ensure SQL query is correct. Something along the line of 
"select xml_msg from talend.open_fx_injection_log
where apsys_error_code <> 1
and lotnum = (select max(lotnum) from talend.open_fx_injection_log)"
(no ending semi-column, don't forget to inclose in double quotes)
- ensures context is correct (params_file)
RUN



server talend
 reboot talend server srvptis01
#04DEC2012 now services stop and start automatically no need to do anything but "init 6"
  cd /opt/talend/jobserver
  ./stop_rs.sh
# screen -ls # (list screen sessions)
#  screen -r  # (reattach)
#  <Enter>
#  stopServer
#  <Ctrl-d>
  init 6
  # apache mysql blabla restart automatiquement, mais ni le job server, ni la command line qu'il faut starter a la main
  job server start stop `history | grep rs.sh`
   su -
   cd /opt/talend/jobserver
   ./start_rs.sh
   Ctrl-Z
   bg
   disown
  command line startup
   su -
#   screen
   cd /opt/talend/cmdline
   ./commandline.sh &
# <Ctrl-A d>
   disown
  check status
   login to web interface
   configuration (screen)
	GREEN	command line primary
	RED   	command line secondary
	GREEN	database
	RED		ESB
	GREEN	General
	GREEN	LDAP
	GREEN	Log4j
	RED		SMTP
	GREEN	Scheduler
	RED		Soa Manager
	GREEN	Svn
	GREEN	Talend Suite
   SRVPAPI01
    check daily injection process is still running and possibly restart it (as ActiveMQ was restarted)
 control status of command line
  screen -ls # (list screen sessions)
  screen -r  # (reattach)
  <Ctrl-A d> # (detach)
 trouver des commandes historique
  history | grep rs.sh


log directory
/opt/talend/jobserver/TalendJobServersFiles/jobexecutions/logs/

job conf directory
/opt/talend/jobs/config_files

files output
/opt/talend/jobs/EOD_injection


#meta servlet https://help.talend.com/display/TalendAdministrationCenterUserGuide53EN/C.5.2+Executing+a+task+with+context+parameters+using+metaServlet
#command-line
http://www.talendforge.org/wiki/doku.php?id=doc:first_steps_with_commandline



preferences
add_classpath_jar_for_export_job=true #located in workspace12/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.talend.designer.core.prefs


    <contextParameter comment="" name="Oracle_Login" prompt="Oracle_Login?" promptNeeded="false" type="id_String" value="DO_NOT_CHANGE_THIS_VALUE. ASK INSTEAD"/>
    <contextParameter comment="" name="Oracle_Password" prompt="Oracle_Password?" promptNeeded="false" type="id_Password" value="6REYRkcAXZk="/>
    <contextParameter comment="" name="Oracle_Port" prompt="Oracle_Port?" promptNeeded="false" type="id_String" value="1521"/>
    <contextParameter comment="" name="Oracle_Server" prompt="Oracle_Server?" promptNeeded="false" type="id_String" value="myhost.mydomain.local"/>
    <contextParameter comment="" name="Oracle_ServiceName" prompt="Oracle_ServiceName?" promptNeeded="false" type="id_String" value="novad.mydomain.local"/>
    <contextParameter comment="" name="Oracle_Schema" prompt="Oracle_Schema?" promptNeeded="false" type="id_String" value="myusername"/>
