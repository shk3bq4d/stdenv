#!/usr/bin/env bash

#now  from  to     result 
spec="20:13 04:00 20:00  1
20:13 04:00 22:00  0
20:13 04:00 03:00  0
20:13 22:00 20:00  1
20:13 22:00 21:00  0
20:13 22:00 03:00  1"
echo "$spec" | while read now from to result; do
	is_between.sh $from $to $now &>/dev/null
	ret=$?
	if [[ $ret -eq $result ]]; then
		echo "OK"
	else
		echo "ko"
	fi
done
