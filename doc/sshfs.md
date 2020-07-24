sshfs login_user@host:remote_path local_path -o sftp_server="/usr/bin/sudo -u as_user /usr/lib/ssh/sftp-server"

sshfs -o uid=$(id -u) -o gid=$(id -g) nextcloudbase:/data bip


fusermount -u LOCALPATH # unmount
