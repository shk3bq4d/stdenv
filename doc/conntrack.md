
port=35355; sudo conntrack -E |grep -m 1 dport=$port | head -n 1; sudo netstat -putn | grep $port
dst=105.201.143.7; sudo conntrack -E |grep -Fm 1 dst=$dst | head -n 1; sudo netstat -putn | grep -F $dst
