
touch -d "2 days ago"
touch -d "+17hour"
date -d "2 days ago"
date -d "+17hour"
date -d "+1min"
date -d "1min"
date -d "+1sec"
date -d "1sec"
date -d "+1second"
date -d "+1seconds"
date -d "june 18 16" # june 18 of current year at 16
date -d "aug 27" # august 27 of this year
date -d "sat 5" # next saturday at 5 o'clock
date -d "next saturday 8:00"
date -d "2004-02-29 16:21:42"
touch -d "1970-01-01 00:00:00"
touch -d "2038-01-10 00:00:00"
date -d "1970-01-01 00:00:00"
date -d "2038-01-10 00:00:00"
One second after 03:14:07 UTC 2038-01-19 this representation will overflow in what is known as the year 2038 problem.

date -d "2006-01-02 15:04:05" +"%A" # filebeat timestamp reference day of week is Monday

Sun, 23 Jan 2000 01:23:45 JST # RFC 2822
select str_to_date('Sat, 01 Dec 2012 05:49:45 +0000','%a, %d %b %Y %T') -- RFC 2822 mysql
