xprop # print windows properties
xev # print mouse + keyboard events
xwininfo
xdotool # automate x actions
xdotool selectwindow

focused_window_id=$(xdotool getwindowfocus)
active_window_id=$(xdotool getactivewindow)
active_window_pid=$(xdotool getwindowpid "$active_window_id")

xprop -id $(xdotool getwindowfocus) WM_CLASS
xprop -id $(xdotool getwindowfocus) WM_CLASS | grep Chromium-browser;
