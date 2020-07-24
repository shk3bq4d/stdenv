https://www.dedoimedo.com/computers/linux-iphone-6s-ios-11.html
sudo apt-get install ideviceinstaller python-imobiledevice libimobiledevice-utils libimobiledevice6 libplist3 python-plist ifuse usbmuxd
idevicepair pair
sudo usbmuxd -f -v
ifuse /media/iphone/
sudo umount /media/iphone
rsync -vtr --progress --human-readable --stats /media/iphone/DCIM/. thinkpade:/pictures/iphone/DCIM/.
rsync -vtr --progress --human-readable --stats /media/iphone/DCIM/. thinkpadw:/pictures/iphone/DCIM/.
rsync -avr -e "sshpass -f~/.words/motog /usr/bin/ssh" --copy-links --delete $DIR/$i/. motog:/sdcard/Music/$i/.
sshpass -f~/.words/motog /usr/bin/ssh motog mkdir /sdcard/Music/$i/
                                                                            |

