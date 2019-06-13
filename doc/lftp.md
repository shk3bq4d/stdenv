
```sh
cat << 'EOF' > /tmp/mylftpscript.x
open -u user,password -p [port][server]
mirror -c -e /remote_directory /local_directory
exit
EOF
lftp -f /tmp/mylftpscript.x
```

# mirror options
-R for upload
-e to delete files

# open options
--env-password read LFTP_PASSWORD environment variable

# globing https://stackoverflow.com/questions/11692928/command-to-delete-all-files-and-folders-in-a-folder-using-ncftp
glob [-d] [-a] [-f] command patterns

Glob given patterns containing metacharacters and pass result to given command. E.g.
glob echo *

-f plain files (default)
-d directories
-a all types

glob ls *
glob -a rm -r *
