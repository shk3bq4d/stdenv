

find . -type f -printf '%T@ %p\n' | sort -k 1nr | sed 's/^[^ ]* //' # https://superuser.com/questions/294161/unix-linux-find-and-sort-by-date-modified
find /data/backups -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\0' | sort -zk 1nr | sed -z 's/^[^ ]* //'

#return code to error if no match: not possible, but use something like
if find /tmp -name something | egrep '.*'; then
# which gives the desired result and is more convenient than
if [[ $(find blabal | wc -l) -eq 0 ]]; then

# quit after first match
find blabal -print -quit #note that print is mandatory


# prune. Do not forget to have -print http://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh
find [path] [conditions to prune] -prune -o [your usual conditions] [actions to perform]

find ~/.tmp/vim/output -type f -name '*tmp' \( -mtime +25 -or \( -mtime +10 -and -size +100k \) -or \( -mtime +2 -and -size +10M \) \)

find . -depth -type d -empty -print # list empty directory
find . -depth -type d -empty -print -delete # delete empty directory
