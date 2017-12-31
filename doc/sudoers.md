%wheel  ALL=(ALL)             ALL
%wheel  ALL=(ALL)   NOPASSWD: ALL

# ubuntu
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL


myuser  ALL = (root) NOPASSWD: /bin/umount bip,/usr/sbin/pm-suspend
myuser  ALL = (root) NOPASSWD:SETENV: /usr/bin/python3 /usr/bin/sshuttle -v --method auto --firewall
