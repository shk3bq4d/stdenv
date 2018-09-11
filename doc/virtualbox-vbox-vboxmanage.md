# /* ex: set filetype=sh: */
vboxmanage storageattach kubuntu1404base --storagectl IDE --port 0 --device 0 --medium none
vboxmanage closemedium disk df32fae5-4df3-46ab-9d4f-09ab51d50617 --delete
vboxmanage createhd --filename /lvmr0/vbox/vm/kubuntu1404base/kubuntu1404base.vdi --format VDI --size 204800
vboxmanage storageattach kubuntu1404base --storagectl IDE --port 0 --device 0 --type hdd --medium kubuntu1404base.vdi
vboxmanage storageattach kubuntu1404base --storagectl IDE --port 0 --device 1 --type dvddrive --medium /lvmr0/kubuntu-14.04.1-desktop-amd64.iso
vboxmanage controlvm kubuntu1404base poweroff
vboxmanage modifyvm kubuntu1404base --memory 1024
vboxmanage guestproperty get xpbase vrdeport
vboxmanage guestproperty set xptest vrdeport 6040
vboxmanage guestproperty set xptest vrdeport 6040
vboxmanage discardstate projectlibre
vboxmanage showvminfo
vboxmanage showvminfo minikube G ssh


# create a VM
# 1) determine type possible types are listed as
vboxmanage list ostypes

name=freebsd0
basedir=/lvmr0/vbox/vm/$name
ram=512
network=bridged
vrdeport=$(vm_next_vrde_port.sh)
hd_imaage=${basedir}/FreeBSD-10.1-RELEASE-amd64.vmdk
vboxmanage createvm --name $name --register --basedir $basedir
vboxmanage modifyvm --memory ${ram} --nic1 $network --audio none --vrde on --vrdeport $vrdeport
vboxmanage snapshot $name take "init_$(date +'%Y.%m.%d-%H.%M.%S')"
vboxmanage snapshot foreman-centos72 take "Before dsestero-sonarqube install" --live
vm_headless $name

ubuntu-xenial-16.04-cloudimg
user: ubuntu
pass: 74863c2706e9c62ab7b70bd6
default NAT port on host: 2222


# port forwarding
VM=foreman; IF=1; GUESTIP=10.0.2.15; GUESTPORT=443; HOSTIP=127.0.0.1; HOSTPORT=$(next_free_port.py); vboxmanage controlvm $VM savestate; vboxmanage modifyvm $VM --natpf$IF "host$HOSTPORT,tcp,$HOSTIP,$HOSTPORT,$GUESTIP,$GUESTPORT"; vboxmanage startvm $VM --type headless; vboxmanage showvminfo $VM | grep -E "^NIC...Rule"; echo $HOSTPORT

# minikube kafka
vboxmanage controlvm minikube savestate
vboxmanage modifyvm  minikube --natpf1 "kafka-minikube-0,tcp,127.0.0.1,31090,127.0.0.1,31090"
vboxmanage modifyvm  minikube --natpf1 "kafka-minikube-1,tcp,127.0.0.1,31091,127.0.0.1,31091"
vboxmanage modifyvm  minikube --natpf1 "kafka-minikube-2,tcp,127.0.0.1,31092,127.0.0.1,31092"
vboxmanage startvm minikube --type headless

# active host only dhcp client
dhclient enp0s8

# ping host in host only dhcp client
ping 196.168.33.1
ping 196.168.56.1

# ping host in nat
ping 10.0.2.2

# guest ip in NAT
10.0.2.15

VM=sonarqube5; SNAPUUID=9bc610ea-1306-43b1-a0c1-19dc282ebd63; vboxmanage controlvm $VM poweroff && vboxmanage snapshot $VM restore $SNAPUUID && vboxmanage startvm $VM --type headless;

NEWHOSTNAME=sonarqube3 && DOMAIN=me.local && sudo hostnamectl set-hostname $NEWHOSTNAME && sudo sed -i -r -e '/^127.0.1.1 / d' /etc/hosts && echo "127.0.1.1 ${NEWHOSTNAME}.${DOMAIN} ${NEWHOSTNAME}" | sudo tee -a /etc/hosts;
i=/etc/sysctl.d/disable_ipv6.conf; echo -e "net.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a $i && sudo sysctl -p $i;
sudo yum install -y rsync vim mlocate && sudo updatedb;
curl http://beyondgrep.com/ack-2.14-single-file | sudo tee /bin/ack && sudo chmod 0755 /bin/ack

service vboxadd-service        stop
service virtualbox-guest-utils stop


# vbox to vmware
- assign all disks to PIIX IDE controller
- export as .ova 
- 7za x -odir bip.ova
- open ovf 
replace
<vssd:VirtualSystemType>virtualbox-2.2</vssd:VirtualSystemType>
with
<vssd:VirtualSystemType>vmx-07</vssd:VirtualSystemType>
- open *mf and suppress the line regarding the checksum of *ovf that was just edited on previous step
- execute something similar
#!/usr/bin/env bash
set -e 
DIR=/mnt/local/00-1to/kanban/2016.09.26-zabbix-service-now-snow-servicenow/
OVA=$DIR/t-mon-zabbix-001.ova
SUBDIR=$DIR/t-mon-zabbix-001
REMOTEOVA=/mnt/remote/mymachune/c$/Users/myuser/t-mon-zabbix-001.ova
set -x
[[ -f $OVA ]] && rm -f $OVA
[[ -f $REMOTEOVA ]] && rm -f $REMOTEOVA
cd $SUBDIR
tar cf $OVA *{ovf,vmdk,mf}
cp -f $OVA $REMOTEOVA
exit 0
- in vSphere, File, Deploy OVF Template

vm="Windows XP"; for i in $(seq 1 4); do VBoxManage controlvm "$vm" setlinkstate$i off ; sleep 1; VBoxManage controlvm "$vm" setlinkstate$i on; done

sudo modprobe vboxdrv # reload kernel module on restart
