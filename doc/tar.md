tar czf /var/www/file.tar.gz file1 # create file in /var/www
tar -ztvf bip.tar.gz # ls list file in .tar.gz

# same owner
tar -czvpf --numeric-owner  bip.gz file1      # compress
tar --same-owner --numeric-owner -xvzf bip.gz # uncompress
