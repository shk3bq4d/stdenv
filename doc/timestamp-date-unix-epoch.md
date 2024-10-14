date -d @1465016400 # from unix epoch timestamp
date +%s            # to unix epoch timestamp
date +%s -d "2004-02-29 16:21:42" # to unix epoch timestamp => 1078068102
python3 -c "import datetime; print(datetime.datetime.fromtimestamp(1532532080))" # unix epoch timestamp
python3 -c "import datetime; print(datetime.datetime.now().strftime('%s'))" # unix epoch timestamp

select extract(epoch from now()); -- postgresql psql  to unixtime
select to_timestamp(mycolumn::bigint);    -- postgresq psql from unixtime

RFC3339: 2014-03-10T05:40:00+00:00

Sep 28 2021 01:33:21      date +'%b %d %Y %H:%M:%S'
Sep 28 2021 01:33:21      sed -r -e "s/^[A-Z][a-z]{2} [ 0-9]?[0-9].{14}/$(date +'%b %d %Y %H:%M:%S')/"

%m/%b/%y %I:%M %p    09/Sep/21 09:33 AM

Math.round(new Date().getTime() / 1000) # javascript get  timestamp
Math.round(Date.now() / 1000)           # javascript get  timestamp
new Date(1534191480)                    # javascript from timestamp

{{ '%Y-%m-%d %H:%M:%S' | strftime(ansible_date_time.epoch) }} # ansible format unix time
{{ '%Y-%m-%d' | strftime(0) }}          # ansible => 1970-01-01
{{ '%Y-%m-%d' | strftime(1441357287) }} # ansible => 2015-09-04

         0 => 1970-01-01 01:00:00
  50000000 => 1971-08-02 17:53:20
 100000000 => 1973-03-03 10:46:40
 150000000 => 1974-10-03 03:40:00
 200000000 => 1976-05-03 20:33:20
 250000000 => 1977-12-03 13:26:40
 300000000 => 1979-07-05 06:20:00
 350000000 => 1981-02-02 23:13:20
 400000000 => 1982-09-04 17:06:40
 450000000 => 1984-04-05 10:00:00
 500000000 => 1985-11-05 01:53:20
 550000000 => 1987-06-06 19:46:40
 600000000 => 1989-01-05 11:40:00
 650000000 => 1990-08-07 05:33:20
 700000000 => 1992-03-07 21:26:40
 750000000 => 1993-10-07 14:20:00
 800000000 => 1995-05-09 08:13:20
 850000000 => 1996-12-08 00:06:40
 900000000 => 1998-07-09 18:00:00
 950000000 => 2000-02-08 09:53:20
1000000000 => 2001-09-09 03:46:40
1050000000 => 2003-04-10 20:40:00
1100000000 => 2004-11-09 12:33:20
1150000000 => 2006-06-11 06:26:40
1200000000 => 2008-01-10 22:20:00
1250000000 => 2009-08-11 16:13:20
1300000000 => 2011-03-13 08:06:40
1350000000 => 2012-10-12 02:00:00
1400000000 => 2014-05-13 18:53:20
1450000000 => 2015-12-13 10:46:40
1500000000 => 2017-07-14 04:40:00
1550000000 => 2019-02-12 20:33:20
1600000000 => 2020-09-13 14:26:40
1650000000 => 2022-04-15 07:20:00
1700000000 => 2023-11-14 23:13:20
1750000000 => 2025-06-15 17:06:40
1800000000 => 2027-01-15 09:00:00
1850000000 => 2028-08-16 02:53:20
1900000000 => 2030-03-17 18:46:40
1950000000 => 2031-10-17 12:40:00
2000000000 => 2033-05-18 05:33:20
2050000000 => 2034-12-17 21:26:40
2100000000 => 2036-07-18 15:20:00
2150000000 => 2038-02-17 07:13:20
2200000000 => 2039-09-19 01:06:40
2250000000 => 2041-04-19 18:00:00
2300000000 => 2042-11-19 09:53:20
2350000000 => 2044-06-20 03:46:40
2400000000 => 2046-01-19 19:40:00
2450000000 => 2047-08-21 13:33:20
2500000000 => 2049-03-22 05:26:40
2550000000 => 2050-10-21 23:20:00
2600000000 => 2052-05-22 16:13:20
2650000000 => 2053-12-22 08:06:40
2700000000 => 2055-07-24 02:00:00
2750000000 => 2057-02-21 17:53:20
2800000000 => 2058-09-23 11:46:40
2850000000 => 2060-04-24 04:40:00
2900000000 => 2061-11-23 20:33:20
2950000000 => 2063-06-25 14:26:40
3000000000 => 2065-01-24 06:20:00



```sql
select unix_timestamp(); -- mariadb mysql
select unix_timestamp("2021-04-15 00:00:00"); -- 1618444800 mariadb mysql
select unix_timestamp('2021-11-27 12:35:03.123456') as result; -- as a float mariadb mysql
select date_format(from_unixtime(clock), "%Y.%m.%d %H:%i:%s") from bip; -- mariadb mysql timestamp https://www.w3schools.com/sql/func_mysql_date_format.asp
select itemid, date_format(from_unixtime(clock), "%Y.%m.%d %H:%i:%s"), num, value_min, value_avg, value_max from trends_uint where itemid = 29020; -- mariadb mysql
```
* date -d https://www.gnu.org/software/coreutils/manual/html_node/Date-input-formats.html
touch -d "2 days ago"
touch -d "+17hour"
date -d "2 days ago"
date -d "+17hour"
date +'%w' # dow day of week weekday
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
date -d "tue"   # today (if today is tue) or next tue
date -d "1 tue" # next tue (even if today is tue)
date -d "fortnight" # two weeks from now, same time
date -d "fortnight tue" # two weeks from now, tue, but at midnight
date -d "2 week" # two weeks from now
date -d "saturday 8:00 + 7 day"
date -d "2004-02-29 16:21:42"
touch -d "1970-01-01 00:00:00"
touch -d "2038-01-10 00:00:00"
date -d "1970-01-01 00:00:00"
date -d "2038-01-10 00:00:00"
One second after 03:14:07 UTC 2038-01-19 this representation will overflow in what is known as the year 2038 problem.

echo "20230320124450" | sed -E 's/(....)(..)(..)(..)(..)(..)/\1-\2-\3 \4:\5:\6/' # => 2023-03-20 12:44:50
date +'%Y-%m-%dT%H:%M:%S' #2023-11-28T14:12:13+01:00

date -d "2006-01-02 15:04:05" +"%A" # filebeat timestamp reference day of week is Monday

Sun, 23 Jan 2000 01:23:45 JST # RFC 2822
select str_to_date('Sat, 01 Dec 2012 05:49:45 +0000','%a, %d %b %Y %T') -- RFC 2822 mysql

dmesg -T
myvalue=600711.395348; date -u -d"1970-01-01 + $(date -u +%s) sec - $(cut -d' ' -f1 </proc/uptime) sec + $myvalue sec" +"%F %T.%N %Z" # dmesg


last sunday of october dernier dimanche octobre DST heure hiver été suisse switzerland, CEST, CET Central European Standard Time, Central European Summer Time
CEST CET Daylight Saving Time begins in Switzerland at 2am on the last Sunday in March, and is when people have to move their clocks forward an hour. This is also when Central European Summer Time begins.
Daylight Saving Time ends in Switzerland at 3am on the last Sunday in October, when the clocks move backwards an hour and the alpine nation resumes running on Central European Time.

TZ=Europe/Zurich date # timezone


date +'%Y-%m-%d %H:%M:%S,%N' | sed -r 's/(,...).*/\1/' # 2022-12-23 10:11:12,023 milliseconds (not nanoseconds)
date +'%Y-%m-%d %H:%M:%S,%N' # 2022-12-23 10:11:12,02345679 nanoseconds (not milliseconds)
date +'%Y-%m-%d:%H:%M:%S,%3N' # milliseconds


###sleep until, or script duration elapsed
current_epoch=$(date +%s) # duration elapsed
target_epoch=$(date -d '01/01/2010 12:00' +%s)
target_epoch=$(date -d 'tomorrow 12:00' +%s)
sleep_seconds=$(( $target_epoch - $current_epoch ))
sleep $sleep_seconds
duration=$(( $(date +%s) - $current_epoch )) # elapsed
echo "job took $duration seconds" # elapsed

tail -f /var/log/squid/access.log | perl -p -e 's/^([0-9]*)/"[".localtime($1)."]"/e'
