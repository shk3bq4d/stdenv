sudo virt-manager
virsh domiflist altlinux3.0
virsh dominfo
virsh list --all
sudo virsh dumpxml pfsense0
sudo virsh start pfsense0

virsh shutdown altlinux3.0
virsh destroy altlinux3.0

# Mount the CD-ROM iso: 
virsh attach-disk your_domain_name /path/to/your.iso hdc --type cdrom --mode readonly

# Change the CD-ROM: 
virsh attach-disk your_domain_name /path/to/your/new.iso hdc --type cdrom --mode readonly

# Remove the CD-ROM: 
virsh attach-disk your_domain_name " " hdc --type cdrom --mode readonly

# edit
virsh # edit altlinux3.0
<boot dev='cdrom'/> 
<disk type='file' device='cdrom'>
  <driver name='qemu' type='raw'/>
  <source file='/home/myuser/Downloads/alpine-3.2.3-x86_64.iso'/>
  <target dev='hdc' bus='ide'/>
  <readonly/>
  <address type='drive' controller='0' bus='1' unit='0'/>
</disk>

<interface type='direct'>
      <mac address='52:54:00:b6:58:85'/>
      <source dev='eno2' mode='passthrough'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>         
</interface>


http://serverfault.com/questions/579139/kvm-all-network-traffic-to-one-guest-firewall?rq=1
http://serverfault.com/questions/669421/using-a-pfsense-guest-to-firewall-route-traffic-for-other-guests
http://www.geekempire.com/2013/07/virtual-security-onion-via-ubuntu-kvm.html

<hostdev mode='subsystem' type='pci' managed='yes'>
	<source>
		<address domain='0x0000' bus='0x00' slot='0x1f' function='0x6'/>
	</source>
	<address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
</hostdev>

<hostdev mode='subsystem' type='pci' managed='yes'>
      <source>
        <address domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
      </source>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </hostdev>
    <hostdev mode='subsystem' type='pci' managed='yes'>
      <source>
        <address domain='0x0000' bus='0x00' slot='0x1f' function='0x6'/>
      </source>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x09' function='0x0'/>
    </hostdev>


<network>
		<name>passthrough</name>
		<forward mode='hostdev' managed='yes'>
			<pf dev='eno2'/>
		</forward>
	</network>


#edit qcow2 filesystem when VM is not running
guestfish -a rhel-7-server-guest-image.qcow2
><fs> run
><fs> list-filesystems
><fs> mount /dev/sda1 /
><fs> vi /etc/shadow
><fs> quit



@begin=xml@
<domain type='kvm'>
  <name>pfsense0</name>
  <uuid>74169bbc-ea44-4725-8fbd-34fb4b459433</uuid>
  <memory unit='KiB'>1048576</memory>
  <currentMemory unit='KiB'>1048576</currentMemory>
  <vcpu placement='static'>1</vcpu>
  <os>
    <type arch='x86_64' machine='pc-i440fx-rhel7.0.0'>hvm</type>
  </os>
  <features>
    <acpi/>
    <apic/>
  </features>
  <cpu mode='custom' match='exact'>
    <model fallback='allow'>Haswell-noTSX</model>
  </cpu>
  <clock offset='utc'>
    <timer name='rtc' tickpolicy='catchup'/>
    <timer name='pit' tickpolicy='delay'/>
    <timer name='hpet' present='no'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>restart</on_crash>
  <pm>
    <suspend-to-mem enabled='no'/>
    <suspend-to-disk enabled='no'/>
  </pm>
  <devices>
    <emulator>/usr/libexec/qemu-kvm</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/pfsense0.qcow2'/>
      <boot order='1'/>
      <target dev='hda' bus='ide'/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <target dev='hdb' bus='ide'/>
      <readonly/>
      <address type='drive' controller='0' bus='0' target='0' unit='1'/>
    </disk>
    <controller type='usb' index='0' model='ich9-ehci1'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x7'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci1'>
      <master startport='0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0' multifunction='on'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci2'>
      <master startport='2'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x1'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci3'>
      <master startport='4'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x2'/>
    </controller>
    <controller type='pci' index='0' model='pci-root'/>
    <controller type='ide' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x1'/>
    </controller>
    <controller type='virtio-serial' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </controller>
    <interface type='direct'>
      <mac address='52:54:00:c5:f6:8e'/>
      <source dev='eno1' mode='bridge'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </interface>
    <serial type='pty'>
      <target port='0'/>
    </serial>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
    <channel type='spicevmc'>
      <target type='virtio' name='com.redhat.spice.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
    </channel>
    <input type='mouse' bus='ps2'/>
    <input type='keyboard' bus='ps2'/>
    <graphics type='spice' autoport='yes'>
      <image compression='off'/>
    </graphics>
    <video>
      <model type='qxl' ram='65536' vram='65536' vgamem='16384' heads='1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
    </video>
    <hostdev mode='subsystem' type='pci' managed='yes'>
      <source>
        <address domain='0x0000' bus='0x08' slot='0x00' function='0x0'/>
      </source>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
    </hostdev>
    <redirdev bus='usb' type='spicevmc'>
    </redirdev>
    <redirdev bus='usb' type='spicevmc'>
    </redirdev>
    <memballoon model='virtio'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
    </memballoon>
  </devices>
</domain>
@end=xml@
