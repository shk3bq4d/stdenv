nm-applet
sudo iwlist scan
sudo iwlist scan | grep -Ei 'address|channel|quality|essid|quality'

sudo wpa_cli scan
sudo wpa_cli scan_results
~/bin/wifi-networks.sh

https://askubuntu.com/questions/967355/wifi-unstable-after-17-10-update


sudo cat "/etc/NetworkManager/system-connections/*"
          Cell 01 - Address: F2:F2:6D:B6:B6:08
                    Channel:36
                    Frequency:5.18 GHz (Channel 36)
                    Quality=61/70  Signal level=-49 dBm  
                    ESSID:"Olivia151"
          Cell 02 - Address: F4:F2:6D:B6:B6:09
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=70/70  Signal level=-32 dBm  
                    ESSID:"njsfjlk FDS354"
          Cell 03 - Address: F6:F2:6D:B6:B6:09
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=70/70  Signal level=-33 dBm  
                    ESSID:"Olivia"
          Cell 04 - Address: F2:F2:6D:B6:B6:09
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=70/70  Signal level=-33 dBm  
                    ESSID:"Olivia-124"
          Cell 05 - Address: 00:0C:F6:AE:B4:94
                    Channel:6
                    Frequency:2.437 GHz (Channel 6)
                    Quality=58/70  Signal level=-52 dBm  
                    ESSID:"njsfjlk FDS354"
          Cell 06 - Address: 00:0C:F6:AE:B4:95
                    Channel:6
                    Frequency:2.437 GHz (Channel 6)
                    Quality=52/70  Signal level=-58 dBm  
                    ESSID:"Olivia"
          Cell 07 - Address: 00:0C:F6:AE:B4:96
                    Channel:6
                    Frequency:2.437 GHz (Channel 6)
                    Quality=57/70  Signal level=-53 dBm  
                    ESSID:"Olivia-224"
          Cell 08 - Address: F4:F2:6D:B6:B6:08
                    Channel:36
                    Frequency:5.18 GHz (Channel 36)
                    Quality=61/70  Signal level=-49 dBm  
                    ESSID:"njsfjlk FDS354"
          Cell 09 - Address: F6:F2:6D:B6:B6:08
                    Channel:36
                    Frequency:5.18 GHz (Channel 36)
                    Quality=61/70  Signal level=-49 dBm  
                    ESSID:"Olivia"
          Cell 10 - Address: 00:22:64:DD:21:73
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=21/70  Signal level=-89 dBm  
                    ESSID:"HP-Print-73-Officejet Pro 8610"
