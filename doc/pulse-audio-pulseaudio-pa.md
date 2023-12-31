https://wiki.archlinux.org/title/bluetooth_headset
```sh
paplay /usr/share/sounds/alsa/Noise.wav

amixer -q -D pulse sset Master toggle
amixer -q -D pulse sset Master off     # mute
amixer -q -D pulse sset Master on      # un-mute
pacmd list-sinks | awk '/muted/ { print $2 }' # returns no if mute or yes
pacmd list-sinks | grep -Eo 'bluez_card[^>]*'
pacmd ls # list-sinks
```
