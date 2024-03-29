smbclient -L r001itmgt0011 -A ~/.smbclientenv1
smbclient \\\\r001itmgt0011\\C$ -A ~/.words/.smbclientenv1
smbclient '\\p-jnfra-jtm-001.kboum.net\C$' -A ~/.words/.smbclientenv2
smbclient '\\p-jnfra-jtm-001.kboum.net\C$' -A ~/.words/.smbclientenv2


cat ~/.words/.smbclientenv2
username=hehe
password=I.can.Has.K4t!
domain=kboum.net

```sh
smbclient -NL fw12 # list share with no password
smbclient -N \\\\jsmb4\\mrfirstshare -c "ls"
smbclient -N \\\\jsmb4\\mrfirstshare -c "mkdir tsys"
smbclient -N \\\\jsmb4\\mrfirstshare -c "cd tsys; ls"
smbclient -N \\\\fw12\\public -c "cd e/hehe/fw_fresh; ls"
smbclient -N \\\\fw12\\public -c "cd e/hehe/fw_fresh; mget *gz"
smbclient -N \\\\fw12\\public -c "cd e/hehe/certs; rename haha.jks haha.jks-until-2021"
smbclient -N \\\\fw12\\public -c "cd e/hehe/certs; put haha_keystore.jks haha.jks "
smbclient -N \\\\fw12\\public -c "cd e/hehe/certs; rm haha.jks "

sudo mount -t cifs //fw12/d$ ~/bip2 -o vers=3.0,username=hehe,password=$(gtk-decrypt ~/.mypassword),domain=mydomain
sudo mount -t cifs //$host/d$ ~/bip2 -o vers=3.0,username=hehe,password=$(gtk-decrypt ~/.mypassword),domain=mydomain
~/bin/notinpath/smb-samba-mount-cifs.sh
```

Usage: smbclient service <password>
  -R, --name-resolve=NAME-RESOLVE-ORDER     Use these name resolution services
                                            only
  -M, --message=HOST                        Send message
  -I, --ip-address=IP                       Use this IP to connect to
  -E, --stderr                              Write messages to stderr instead
                                            of stdout
  -L, --list=HOST                           Get a list of shares available on
                                            a host
  -m, --max-protocol=LEVEL                  Set the max protocol level
  -T, --tar=<c|x>IXFvgbNan                  Command line tar
  -D, --directory=DIR                       Start from directory
  -c, --command=STRING                      Execute semicolon separated
                                            commands
  -b, --send-buffer=BYTES                   Changes the transmit/send buffer
  -t, --timeout=SECONDS                     Changes the per-operation timeout
  -p, --port=PORT                           Port to connect to
  -g, --grepable                            Produce grepable output
  -q, --quiet                               Suppress help message
  -B, --browse                              Browse SMB servers using DNS

Help options:
  -?, --help                                Show this help message
      --usage                               Display brief usage message

Common samba options:
  -d, --debuglevel=DEBUGLEVEL               Set debug level
  -s, --configfile=CONFIGFILE               Use alternate configuration file
  -l, --log-basename=LOGFILEBASE            Base name for log files
  -V, --version                             Print version
      --option=name=value                   Set smb.conf option from command
                                            line

Connection options:
  -O, --socket-options=SOCKETOPTIONS        socket options to use
  -n, --netbiosname=NETBIOSNAME             Primary netbios name
  -W, --workgroup=WORKGROUP                 Set the workgroup name
  -i, --scope=SCOPE                         Use this Netbios scope

Authentication options:
  -U, --user=USERNAME                       Set the network username
  -N, --no-pass                             Don't ask for a password
  -k, --kerberos                            Use kerberos (active directory)
                                            authentication
  -A, --authentication-file=FILE            Get the credentials from a file
  -S, --signing=on|off|required             Set the client signing state
  -P, --machine-pass                        Use stored machine account password
  -e, --encrypt                             Encrypt SMB transport
  -C, --use-ccache                          Use the winbind ccache for
                                            authentication
      --pw-nt-hash                          The supplied password is the NT
                                            hash
