sudo -u mongod whomai
sudo -u mongod bash
sudo -u mongod sh -c 'echo $HOME'
ssh $h "sudo sed -r -i -e '/backup_mongo/ d' /etc/fstab"

%wheel  ALL=(ALL)             ALL
%wheel  ALL=(ALL)   NOPASSWD: ALL

# ubuntu
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL


# sudo visudo -f /etc/sudoers.d/myuser
myuser  ALL = (root) NOPASSWD: /bin/umount bip,/usr/sbin/pm-suspend

sudo visudo -f /etc/sudoers.d/sshuttle
myuser  ALL = (root) NOPASSWD:SETENV: /usr/bin/python3 /usr/bin/sshuttle -v --method auto --firewall
myuser  ALL = (root) NOPASSWD:SETENV: /usr/bin/python3 /home/myuser/bin/sshuttle -v --method auto --firewall
myuser  ALL = (root) NOPASSWD:SETENV: /usr/bin/env PYTHONPATH=/home/myuser/.local/lib/python3.6/site-packages /usr/bin/python3 /home/myuser/bin/sshuttle -v --method auto --firewall


