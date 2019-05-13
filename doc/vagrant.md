# packaging
http://vertis.io/2012/11/02/creating-a-vagrant-base-box-from-an-existing-vmdk.html


config.vm.box_download_insecure = true # certs https

/cygdrive/c/Users/$USER/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-xenial64/20170719.0.0/virtualbox/Vagrantfile
grep -i password /cygdrive/c/Users/$USER/.vagrant.d/boxes/ubuntu-VAGRANTSLASH-xenial64/20170719.0.0/virtualbox/Vagrantfile


# 5.1 support on ubuntu
2018.03.28
/usr/share/vagrant/plugins/providers/virtualbox/driver/meta.rb line 63
"5.0" => Version_5_0,
"5.1" => Version_5_0, mr
https://github.com/hashicorp/vagrant/issues/9090
linge

Vagrant.configure("2") do |config|
  config.vm.box = "mwrock/windows2016"
  config.vm.hostname = "host-win"
  winClientIP = "192.168.99.103"
  config.vm.network "private_network", ip: winClientIP
end
