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

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "mwrock/Windows2016"
  config.vm.hostname = "host-win"
  winClientIP = "192.168.99.103"
  config.vm.network "private_network", ip: winClientIP
  v.linked_clone = true
  # config.disksize.size = "20GB"
  vagrant_root = File.dirname(__FILE__)
  ENV['ANSIBLE_ROLES_PATH'] = "#{vagrant_root}/ansible/roles"
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbooks/default.yml"
    ansible.verbose = "vv"
    ansible.raw_arguments = ["-i", "ansible/hostsfile"]
  end
end
```
config.vm.provision "shell", run: "always", inline: <<-SHELL
        mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` vagrant /vagrant
SHELL
