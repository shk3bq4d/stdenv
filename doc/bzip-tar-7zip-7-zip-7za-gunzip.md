
tar -ztvf bip.tar.gz # list file in .tar.gz

tar cvJf myarchive.tar.xz files-or-folder-to-compress # create xz archive, tar (child): compress: Cannot exec: No such file or directory tar (child): Error is not recoverable: exiting now


```bash
 # disk usage through ncdu or ducks alias
sudo apt-get install archivemount
mkdir bash-4.3-mount
archivemount bash-4.3.tar.gz bash-4.3-mount
cd bash-4.3-mount
ncdu
```
zip file.zip filetocompress.txt

7za x deskpro-backup.2021-10-18_07-29-34.zip database.sql # extract single file from archive
