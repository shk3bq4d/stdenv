```bash

tar -ztvf bip.tar.gz # ls list file in .tar.gz

tar cvJf myarchive.tar.xz files-or-folder-to-compress # create xz archive, tar (child): compress: Cannot exec: No such file or directory tar (child): Error is not recoverable: exiting now


 # disk usage through ncdu or ducks alias
sudo apt-get install archivemount
mkdir bash-4.3-mount
archivemount bash-4.3.tar.gz bash-4.3-mount
cd bash-4.3-mount
ncdu

zip file.zip filetocompress.txt

7za x deskpro-backup.2021-10-18_07-29-34.zip database.sql # extract single file from archive


docker cp $(which zip) my_container:/bin/
docker cp $(which unzip) my_container:/bin/
zip -vT myzip.jar # kind list files ls (instead it test integrity in verbose mode)
unzip -l myzip.jar #     list files ls
rpm2cpio moxapi-7.10.5-1.x86_64.rpm|cpio -idmv


unzip -j                       # junk part,     removes intermediate sub directory directories
unzip --transform 's/^.*\///'  # not on centos7 removes intermediate sub directory directories
--strip-components=1           #                removes intermediate sub directory directories


xz myfile # compresses myfile
kill -SIGUSR1 $(pgrep xz) # display progress
```

unxz is equivalent to xz --decompress.
xzcat is equivalent to xz --decompress --stdout.
lzma is equivalent to xz --format=lzma.
unlzma is equivalent to xz --format=lzma --decompress.
lzcat is equivalent to xz --format=lzma --decompress --stdout.
