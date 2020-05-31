# custom modE
cvt 5120 2160 30
xrandr --newmode "5120x2160_30.00"  452.75  5120 5448 5992 6864  2160 2163 2173 2200 -hsync +vsync
xrandr --newmode $(cvt 5120 2160 30 | sed -r -n -e 's/Modeline //p' | xargs echo)
xrandr --addmode DP-1 5120x2160_30.00
xrandr --output DP-1 --mode 5120x2160_30.00
xrandr --output DP-1 --mode 5120x2160_30.00 --output eDP-1 --off --output DP-2 --off

#apr16 covid
xrandr --newmode $(cvt 1920 1200 30 | sed -r -n -e 's/Modeline //p' | xargs echo)
xrandr --addmode HDMI-2 1920x1200_30.00
xrandr --output DP-2 --auto --primary --output HDMI-2 --mode 1920x1200_30.00 --left-of DP-2
i3 restart
feh --bg-scale ~/Pictures/i3lock/boreal3.png
