raspberry pi pir motion 1.08 $ buy it now cheapest on ebay JUL 2015
housing 7.10$ JUL 2015
http://www.ebay.com/itm/Outdoor-Indoor-Fake-Surveillance-Security-Dummy-Camera-Night-CAM-LED-Light-BEST-/181689507833?pt=LH_DefaultDomain_0&hash=item2a4d89dff9


2f to sd 1 $


Camera
https://www.amazon.com/Waveshare-Raspberry-Camera-Vision-Raspberry-pi/dp/B00N9YWLHE/ref=pd_sim_147_10?ie=UTF8&psc=1&refRID=JNTA3CJT43AB4TC4EJ6Q


https://wiki.debian.org/BridgeNetworkConnectionsProxyArp
https://wannabe-nerd.m.tweakblogs.net/blog/10870/wifi-access-point-using-a-realtek-8192cu-based-usb-wifi-dongle-with-a-raspberry-pi.html
https://i.chillrain.com/index.php/how-to-create-an-accesspoint-using-a-realtek-8192cu-usb-wifi-dongle-in-rpi1-b/
https://bogeskov.dk/UsbAccessPoint.html
http://www.glennklockwood.com/sysadmin-howtos/rpi-wifi-island.html
https://github.com/pritambaral/hostapd-rtl871xdrv



https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/temperature/ 
https://www.raspberrypi.org/forums/viewtopic.php?f=37&t=66946 # 433mhz

http://www.yoctopuce.com/EN/article/turn-your-raspberry-pi-into-a-network-multimeter
http://davidhoulding.blogspot.ch/2014/02/high-sensitivity-vibration-sensor-using.html
http://dietpi.com/

# http://www.ebay.com/itm/262636901441
# http://www.waveshare.com/wiki/4inch_HDMI_LCD
# append this to /DietPi/config.txt (and comment out duplicate statements)
hdmi_group=2
hdmi_mode=87
hdmi_cvt 480 800 60 6 0 0 0
dtoverlay=ads7846,cs=1,penirq=25,penirq_pull=2,speed=50000,keep_vref_on=0,swapxy=0,pmax=255,xohms=150,xmin=200,xmax=3900,ymin=200,ymax=3900
display_rotate=3

# temperature probe sonde https://www.ebay.com/itm/1M-1-2-5-10-DS18B20-Waterproof-Sensor-Digital-Probe-Thermometer-Thermal-Arduino-/283278069158
Probe's wire received is Red, Yellow and Black, conncet your probe as Output lead : Red (VCC), Yellow(DATA), Black(GND) : )



```sh
systemctl set-default graphical.target
ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
sed /etc/lightdm/lightdm.conf -i -e 's/^\(#\|\)autologin-user=.*/autologin-user=pi/'
# https://gist.github.com/petehamilton/5412334
sudo apt-get install unclutter # unclutter hides the mouse
```
