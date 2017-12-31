sshfs login_user@host:remote_path local_path -o sftp_server="/usr/bin/sudo -u as_user /usr/lib/ssh/sftp-server"


fusermount -u LOCALPATH # unmount
