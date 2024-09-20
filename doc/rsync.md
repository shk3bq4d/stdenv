```sh
--modify-window=2
rsync -vnra --progress --stats --human-readable --modify-window=2
--bwlimit=KBPS

-f '- incomplete/' exclude "incomplete" directory and sub-hierarchy located anywhere
-f '- *(?).mp3' # will match 'bip(5).mp3'

rsync -a --rsync-path="sudo rsync" from to # rsync (scp) as root

cp -R --attributes-only /data/ data # 0-size structure zero don't use rsync

rsync -avrnR --prune-empty-dirs --exclude=".*" --include="*/" --include="*.sh" --include="*.py" --include="mr.key" --include="mr.kdbix" --exclude="*" --stats --progress --human-readable /home/user/. remote:hehe/

rsync -avr --link-dest $SRC_DIR $SRC_DIR/. $DEST_DIR/. # create hardlinks, but won't work if you use --chown and that --chown lead to any action

rsync --chown $USER:$GROUP # won't work with --link-dest creating hardlinks if --chown leads to any action


-a = --recursive --links --perms --times --group --owner --devices --specials # archive


rsync -nvr --stats --delete --include="MYFILENAME" --exclude='*' $(mktemp -d)/ myuser@myhost:MY/REMOTE/PATH # delete unique remote file or empty directory
rsync -av  --stats --delete                                      $(mktemp -d)/ myuser@myhost:MY/REMOTE/PATH # delete content of remote directory, if you need to delete the directory itself, apply the command for the empty directory
```
