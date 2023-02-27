btrfs-compsize # calculate compression ratio
btrfs-progs # mkfs.btrfs

sudo compsize ~/vagrant/boxes # calculate compression and deduplication ratio
btrfs fi df ~/vagrant/boxes # calculate compression and deduplication ratio
sudo duperemove -drA $HOME/vagrant/boxes --hashfile=$HOME/.btrfs-vagrant-boxes-hasfile
sudo btrfs filesystem resize max ~/vagrant/boxes
