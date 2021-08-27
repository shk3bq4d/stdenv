# packaging
http://vertis.io/2012/11/02/creating-a-vagrant-base-box-from-an-existing-vmdk.html

     autocomplete    manages autocomplete installation on host
     box             manages boxes: installation, removal, etc.
     cloud           manages everything related to Vagrant Cloud
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     port            displays information about guest port mappings
     powershell      connects to machine via powershell remoting
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration
     resume          resume a suspended vagrant machine
     snapshot        manages snapshots: saving, restoring, etc.
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     upload          upload to machine via communicator
     validate        validates the Vagrantfile
     version         prints current and latest Vagrant version
     winrm           executes commands on a machine via WinRM
     winrm-config    outputs WinRM configuration to connect to the machine



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
