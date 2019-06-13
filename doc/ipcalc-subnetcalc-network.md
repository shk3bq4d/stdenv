# https://pypi.org/project/netcalc/
```sh
~/.local/bin/netcalc add 198.18.0.0/24 198.18.1.0/24 10.1/16 10/16  # Add networks, aggregating as much as possible.
~/.local/bin/netcalc sub 192.0.2.0/24 192.0.2.0/28                  # Subtract a network from another, splitting as necessary.
~/.local/bin/netcalc split 198.18.64.0/18 20                        # Split a network into subnets of a certain length.
```


# ubuntu
ipcalc 79.7.228.30/29                                                  9:55:35  13ms
Address:   79.7.228.30          01001111.00000111.11100100.00011 110
Netmask:   255.255.255.248 = 29 11111111.11111111.11111111.11111 000
Wildcard:  0.0.0.7              00000000.00000000.00000000.00000 111
=>
Network:   79.7.228.24/29       01001111.00000111.11100100.00011 000
HostMin:   79.7.228.25          01001111.00000111.11100100.00011 001
HostMax:   79.7.228.30          01001111.00000111.11100100.00011 110
Broadcast: 79.7.228.31          01001111.00000111.11100100.00011 111
Hosts/Net: 6                     Class A

ipcalc 79.7.228.30/29                                                  9:55:35  13ms
ipcalc 175.49.117.116/27 | awk '{ if (/^Network/ ) { print $2 } }'
ipcalc 175.49.117.116/27 | ipcalc-ubuntu-network.sh
