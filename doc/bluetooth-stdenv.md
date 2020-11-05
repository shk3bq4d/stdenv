
How to use:

    Step 1: charge the bluetooth headset full until the led from red to blue.
    Step 2: open your phone bluetooth function.
    Step 3: open the bluetooth headset.press the bluetooth headset power button about 7-10s until the led stay solid blue and red.when you press it,the led will shine between blue and red ,be out then stay solid blue and red .don't move your hand until you get solid blue and red led light.then use your phone bluetooth function to search .if you find BT300,Then pair it with password 0000.after pair it with your phone,you need to link the phone and the bluetooth headset together.
    Step 4: after you pair successfully,you can use the bluetooth headset to call or receive call.


sudo rfkill unblock bluetooth
# https://wiki.archlinux.org/index.php/bluetooth_headset
sudo systemctl start bluetooth
sudo bluetoothctl
[bluetooth]# power on
[bluetooth]# agent on
[bluetooth]# default-agent
[bluetooth]# scan on

