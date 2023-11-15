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
