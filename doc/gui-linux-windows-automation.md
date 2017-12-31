$ xdotool search --class xfreerdp 
69206017

xdotool search --name "RDP Localhost"

$ xdotool type --window 69206017 abc

$ xdotool windowactivate 69206017

xdotool mousemove --window 81788937 -- 2 0

while :; do date; xdotool key --window 69206017 Control; sleep 300; done

xprop
