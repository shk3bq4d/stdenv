Set DNS servers
cat /etc/network/interfaces
# It should look something like this:
# The loopback network interface  
auto lo  
iface lo inet loopback  
# The primary network interface  
auto eth0 
iface eth0 inet static  
address 192.168.X.X
netmask 255.255.255.0
gateway 192.168.X.X
dns-nameservers X.X.X.X Y.Y.Y.Y Z.Z.Z.Z
# then execute
sudo ifdown eth0 && sudo ifup eth0

# change hostname
OLD: edit /etc/hostname and /etc/hosts then execute service hostname restart
NEW: sudo hostnamectl MYHOSTNAME

# add new root certificate, (cert file MUST end with .crt)
sudo cp foo.crt /usr/local/share/ca-certificates/foo.crt
sudo update-ca-certificates

# identify-package-origin-of-binary-on-apt-systems/
apt-file search kvm-img

echo "Acquire::http::Proxy \"http://6.1.0.159:3142\";" | sudo tee -a /etc/apt/apt.conf


# desktop notification receiving
dbus-monitor "interface='org.freedesktop.Notifications'"    
dbus-monitor "interface='org.freedesktop.Notifications'"    | grep --line-buffered  "member=Notify\|string"
# desktop notification send
notify-send message
