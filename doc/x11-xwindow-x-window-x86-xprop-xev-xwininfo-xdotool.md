xprop # print windows properties
xev # print mouse + keyboard events
xwininfo
xdotool # automate x actions
xdotool selectwindow # find window pid
xdotool type --clearmodifiers --window $(xdotool selectwindow) "send keys to arbitrary windows without knowing wid"
~/py/mr_sendkeys.py my text to send
~/py/mr_sendkeys.py --id 15616 my text send

focused_window_id=$(xdotool getwindowfocus)
active_window_id=$(xdotool getactivewindow)
active_window_pid=$(xdotool getwindowpid "$active_window_id")

xprop -id $(xdotool getwindowfocus) WM_CLASS
xprop -id $(xdotool getwindowfocus) WM_CLASS | grep Chromium-browser;
