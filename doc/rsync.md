--modify-window=2
rsync -vnra --progress --stats --human-readable --modify-window=2 
--bwlimit=KBPS

-f '- incomplete/' exclude "incomplete" directory and sub-hierarchy located anywhere
-f '- *(?).mp3' # will match 'bip(5).mp3'

rsync -a --rsync-path="sudo rsync" from to # rsync (scp) as root
