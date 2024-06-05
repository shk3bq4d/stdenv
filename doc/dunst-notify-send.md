notify-send coucou

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
