
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
