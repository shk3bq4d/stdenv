---
network:
  version: 2
  renderer: networkd
  ethernets:
    eno6:
        addresses:
        - 10.3.77.41/24
        link-local: []
        match:
            macaddress: c4:34:6b:b0:51:34
        nameservers:
            addresses:
            - 10.3.4.1
            - 10.3.4.2
        routes:
        -   on-link: true
            to: 0.0.0.0/0
            via: 10.3.77.254

    eno5:
        addresses:
        - 10.3.77.46/24
        link-local: []
        match:
            macaddress: c4:34:6b:b0:51:30
