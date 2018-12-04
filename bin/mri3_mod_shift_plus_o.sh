#!/usr/bin/env bash


#exec > >(tee /tmp/i3mod-plus-o.txt)
#exec 2>&1

case $HOSTNAME in \
	apr16)
		URL=http://jlighttpd.ly.lan
		;;
	*)
		URL=http://localhost
		;;
esac
CLIP="$(xclip -o -selection primary 2>/dev/null | ~/bin/sed_remove_colors.sh | tr -d '\n'| sed -r \
	-e 's/^#//' \
	-e 's/(^\s+|\s+$)//g' \
	-e 's/^.*(https?:[^ ]+).*$/\1/' 
	)"
URL="$CLIP"
set -x
$HOME/bin/chromium-browser --new-window "$URL"
