~/bin/startup/mrredshift.sh
redshift -l 46.57:7.27  -v  | while read line; do echo "$(date) $line"; done

~/.local/bin/xflux -l 46.57  -g 7.27 -k 2000 -r 1 -nofork

https://justgetflux.com/linux.html

https://wiki.archlinux.org/index.php/Redshift

https://wiki.archlinux.org/index.php?title=Backlight&redirect=no#Xflux
