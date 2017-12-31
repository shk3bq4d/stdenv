# redirect whole script execution to syslog
exec > >(logger -i -t "$(basename $0)" )  # linux or freebsd, see next line
exec > >(logger --id=$$ -t "$(basename $0)" ) # linux as it sends ppid which is more robust
exec 2>&1

echo hehe | logger -p emerg # write to every console, with default config on Ubuntu xenial 16.04

# /etc/rsyslog.d/50-default.conf
## writes to file and do not process further lines (the second line does the trick)
user.*				-/var/log/user.log 
& ~


# Facility
A facility code is used to specify the type of program that is logging the message. Messages with different facilities may be handled differently.[4] The list of facilities available[5] is defined by RFC 3164:
Facility code	Keyword	Description
0	kern	kernel messages
1	user	user-level messages
2	mail	mail system
3	daemon	system daemons
4	auth	security/authorization messages
5	syslog	messages generated internally by syslogd
6	lpr	line printer subsystem
7	news	network news subsystem
8	uucp	UUCP subsystem
9		clock daemon
10	authpriv	security/authorization messages
11	ftp	FTP daemon
12	-	NTP subsystem
13	-	log audit
14	-	log alert
15	cron	scheduling daemon
16	local0	local use 0 (local0)
17	local1	local use 1 (local1)
18	local2	local use 2 (local2)
19	local3	local use 3 (local3)
20	local4	local use 4 (local4)
21	local5	local use 5 (local5)
22	local6	local use 6 (local6)
23	local7	local use 7 (local7)
The mapping between facility code and keyword is not uniform between operating systems and different syslog implementations.[6]

#Severity level
The list of severities is also defined by RFC 5424:
Value	Severity	Keyword	Description	Examples
0	Emergency	emerg	System is unusable	This level should not be used by applications.
1	Alert	alert	Should be corrected immediately	Loss of the primary ISP connection.
Ski Haus Delta has not reported status within status_timeout (120)
2	Critical	crit	Critical conditions	A failure in the system's primary application.
Ski Haus Delta reports temperature < low_critical (30)
3	Error	err	Error conditions	An application has exceeded its file storage limit and attempts to write are failing.
Ski Haus Delta reports temperature < low_error (32)
4	Warning	warn	May indicate that an error will occur if action is not taken.	A non-root file system has only 2GB remaining.
Ski Haus Delta reports temperature < low_warning (36)
5	Notice	notice	Events that are unusual, but not error conditions.	Ski Haus Delta reports temperature < low_notice(50)
6	Informational	info	Normal operational messages that require no action.	An application has started, paused or ended successfully.
Ski Haus Delta reports temperature 60
7	Debug	debug	Information useful to developers for debugging the application.
