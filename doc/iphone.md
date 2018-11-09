hotspot: md7dbva5czpea
https://www.dedoimedo.com/computers/linux-iphone-6s-ios-11.html
sudo apt-get install ideviceinstaller python-imobiledevice libimobiledevice-utils libimobiledevice6 libplist3 python-plist ifuse usbmuxd
idevicepair pair
sudo usbmuxd -f -v
ifuse /media/iphone/
sudo umount /media/iphone
rsync -vtr --progress --human-readable --stats /media/iphone/DCIM/. thinkpade:/pictures/iphone/DCIM/.
rsync -vtr --progress --human-readable --stats /media/iphone/DCIM/. thinkpadw:/pictures/iphone/DCIM/.
                                                                            |

