# custom modE
cvt 5120 2160 30
xrandr --newmode "5120x2160_30.00"  452.75  5120 5448 5992 6864  2160 2163 2173 2200 -hsync +vsync
xrandr --newmode $(cvt 5120 2160 30 | sed -r -n -e 's/Modeline //p')
xrandr --addmode DP-1 5120x2160_30.00
xrandr --output DP-1 --mode 5120x2160_30.00
xrandr --output DP-1 --mode 5120x2160_30.00 --output eDP-1 --off --output DP-2 --off
