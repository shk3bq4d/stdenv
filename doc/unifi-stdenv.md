
* https://github.com/jacobalberty/unifi-docker/issues/536 # improve documentation for no proxy
https://community.ui.com/questions/Add-proxy-support-to-controller-for-firmware-downloads-etc-/b9d7bc5a-b60d-44da-ae74-09868161fdd9
https://community.ui.com/questions/UniFi-controller-use-web-proxy-for-firmware-download/ebf6fc50-50b6-4a30-8912-3653d6c91b7a
https://www.grufo.com/get_unifi_firmware.sh.txt

https://community.ui.com/questions/Monitoring-with-SNMP/1eabb0e5-793e-4891-9a45-2e7ade737ca1
https://community.ui.com/questions/SNMP-monitoring/e2d08888-c1be-43bf-a01c-10a2eab6b5c6
https://www.reddit.com/r/Ubiquiti/comments/f9u0f8/snmpv3_on_unifi_controller/
https://github.com/jacobalberty/unifi-docker/issues/472 # snmp

unifi@netwc400p90:/usr/lib/unifi/dl/firmware/bundles.json

jacobalberty/unifi:v7.0.25
jacobalberty/unifi:v7.0.26 # does not exist as of 2022.05.01
jacobalberty/unifi:v7.1.61
jacobalberty/unifi:v7.1.66
jacobalberty/unifi:v7.3.76
jacobalberty/unifi:v7.3.83
jacobalberty/unifi:v7.4.156
jacobalberty/unifi:v7.4.162

https://fw-update.ubnt.com/api/firmware
https://fw-update.ubnt.com/api/firmware-newest
https://community.ui.com/releases/UniFi-Access-Point-6-5-54/cf7e8c75-1737-4625-88fa-aca2ed0ece39
https://community.ui.com/releases/UniFi-Access-Point-6-5-54/cf7e8c75-1737-4625-88fa-aca2ed0ece39#comment/5cb0f2de-304a-4515-ac00-aabdd20a7d6d

https://community.ui.com/releases/r/network/7.4.162
https://community.ui.com/releases/r/network/7.4.156
https://community.ui.com/releases?q=unifi+network+application
https://community.ui.com/releases/UniFi-Network-Application-7-1-61/06f67c89-c798-423f-91a2-4cb2bca7694d
https://community.ui.com/releases/UniFi-Network-Application-7-1-65/6866da09-c506-42ec-abcf-1b7fcc0dddc7
https://community.ui.com/releases/UniFi-Network-Application-7-1-66/cf1208d2-3898-418c-b841-699e7b773fd4
https://community.ui.com/releases/UniFi-Network-Application-7-1-68/30df65ee-9adf-44da-ba0c-f30766c2d874
https://community.ui.com/releases/UniFi-Network-Application-7-2-92/f1903cbc-4daa-4695-ac8c-7324bcff529a
https://community.ui.com/releases/UniFi-Network-Application-7-2-94/2ab774d1-0f24-422e-accc-53b8200c10a7
https://community.ui.com/releases/UniFi-Network-Application-7-2-95/7adebab5-8c41-4989-835d-ab60dba55255
https://community.ui.com/releases/UniFi-Network-Application-7-3-76/85c75fc7-3e0f-4e99-aa90-7068af4f1141
https://community.ui.com/releases/UniFi-Network-Application-7-3-83/88f5ff3f-4c13-45e2-b57e-ad04b4140528
https://community.ui.com/releases/UniFi-Network-Application-7-4-156/15ac6260-9cd1-4ac3-a91c-4880c1c87882

```sh
#!/bin/bash

# versio 0.1

export https_proxy="http://proxy.server:8080/"

# unifi firmware download folder
P=/usr/lib/unifi/dl/firmware
# download folder from local webserver to serve it to the unifi controller
P2=/var/www/html/firmware
# local webserver url
DLSERVER="192.168.99.100"
cd $P

IFS="
"

CPB=$(grep 'dl.ubnt.com' bundles.json)

if [ "$CPB" ]; then
 # new bundles.json
 cp bundles.json bundles.json.orig
fi

if [ -f "bundles.json.new" ]; then
 # check bundles.json with our bundles.json.new file
 # remove if new bundles.json
    BN=$(md5sum bundles.json.new)
 BO=$(md5sum bundles.json)
    if [ "$BN" != "$BO" ]; then
    rm bundles.json.new
    NEWDL=1
 fi
fi

if [ ! -f "bundles.json.new" ]; then
 # create new bundles.json file with our server for firmwar downloads...
    cp bundles.json bundles.json.new
    sed -i -e "s/https:\/\/dl.ubnt.com\/unifi\//http:\/\/$DLSERVER\//g" bundles.json.new
    cp bundles.json.new bundles.json
fi

for U in $(awk -F '}' 'BEGIN{RS=",";}{print $1}' bundles.json.orig |grep url); do

 # extract download url from original json file
    URL=$(echo $U|awk '{print $2}'|sed -e "s/\"//g")

    if [ "$URL" ]; then

     CHECK=${URL: -11}
     OUTFILE=$(echo $URL|awk -F'/firmware/' '{print $2}')
     if [ "$CHECK" == "upgrade.tar" ]; then
      OUTDIR=$(echo $OUTFILE|awk -F'upgrade.tar' '{print $1}')
     else
      OUTDIR=$(echo $OUTFILE|awk -F'firmware.bin' '{print $1}')
     fi
  #echo "$P2/$OUTFILE"

  # create directory for downloads if not exists
     if [ ! -d "$P2/$OUTDIR" ]; then
    mkdir -p "$P2/$OUTDIR"
     fi

  # download firmware file to local webserver
    if [ ! -f "$P2/$OUTFILE" ]; then
      wget -q -O "$P2/$OUTFILE" $URL
    fi

    fi

done

if [ "X$NEWDL" == "X1" ]; then
 # in case of new downloaded files restart unifi controller
    systemctl restart unifi
fi
```
