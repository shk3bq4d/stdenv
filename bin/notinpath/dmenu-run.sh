#!/usr/bin/env bash
# ex: set filetype=sh :

exec > >(tee -a ~/.tmp/log/$(basename $0 .sh).log)
exec 2>&1

#dmenu_run -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#222222" -nf "#999999"
case $HOSTNAMEF in \
nov20.ly.lan)
	test $(cat ~/.tmp/compton-enabled) == true \
	&& dmenu_run --class mrdmenu -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#FFFFFF" -nf "#000000" \
	|| dmenu_run --class mrdmenu -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#FFFFFF" -nf "#000000"
	#&& dmenu_run --class mrdmenu -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#222222" -nf "#bbbbbb" \
	;;
dec17.ly.lan)
	test $(cat ~/.tmp/compton-enabled) == true \
	&& dmenu_run --class mrdmenu -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#FFFFFF" -nf "#000000" \
	|| dmenu_run --class mrdmenu -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#FFFFFF" -nf "#000000"
	#&& dmenu_run --class mrdmenu -i -b -l 20 -fn  "DejaVuSansMono-14" -nb "#222222" -nf "#bbbbbb" \
	;;
feb22.ly.lan)
	dmenu_run -l 30 $(~/bin/mri3_dmenu_params.py)
	;;
$WORK_PC1F)
	dmenu_run --class mrdmenu -i -b -l 40 -fn  "DejaVuSansMono-28" -nb "#FFFFFF" -nf "#000000" -m 1
	;;
*)
	dmenu_run -l 10 $(~/bin/mri3_dmenu_params.py)
	;;
esac
