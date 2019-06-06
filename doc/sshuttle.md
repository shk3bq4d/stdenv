# sshuttle add port rule
1) find out your sshuttle listening port
2) insert your sneaky rule
sudo iptables -t nat -A sshuttle-12299 -p tcp --dport 25 -m ttl ! --ttl-eq 42 -j REDIRECT --to-ports 12299


# quick exec
sshuttle -r myjump 195.79.13.12/32
