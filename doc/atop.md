atop -r /var/log/atop/atop_20160128
t you can jump 10 minutes forward time
T 10 minutes back
b jump at a specific time via 'b'. 202209030845

I    Specify a list with one or more PIDs to be selected.


atop -r atop_20250522 -b 202505221411
atop -r atop_20250522 -b 202505221411 -v # -v adds parent id

atopsar -P ALL -r atop_20250522 | grep 1079319
atop -vr /var/log/atop/atop_20250522 -b 202505221425 -e 202505221405 | grep -E '^(1080261|1080260|1080257|1071049|640) '
