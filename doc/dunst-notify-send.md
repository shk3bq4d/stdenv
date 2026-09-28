notify-send coucou

dunstctl reload
systemctl restart --user dunst
journalctl -f --user -u dunst

dunst --version | head -n 1                                                        14:12:00  14ms
Dunst - A customizable and lightweight notification-daemon 1.12.2 (2025-03-05)

# problem with notification over i3lock
https://github.com/dunst-project/dunst/issues/697
```sh
restore_dunst() {
	pkill -u "$USER" -USR2 dunst
}

pause_dunst() {
	pkill -u "$USER" -USR1 dunst || true;
	trap restore_dunst SIGHUP SIGINT SIGQUIT SIGTERM EXIT
	sleep 0.1
}
```
