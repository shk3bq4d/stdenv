awk '{ sum += $1 } END { print sum }' # sum stdin
paste -s -d+ - | bc # sums stdin
