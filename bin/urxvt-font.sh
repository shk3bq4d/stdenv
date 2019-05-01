#!/usr/bin/env bash

fontlist() {
	fc-list  | cut -d : -f 1 | while read line; do
		name=$(basename "$(basename "$line" .ttf )" .ttc)
		[[ $name == *.pfb ]] && continue
		echo $name;
	done | sort -u
}
getfont() {
	arg=$1
	name=$(fontlist | grep -iE "^${arg}$" | head -n 1)
	if [[ -z $name ]]; then
		name=$(fontlist | grep -i "${arg}" | head -n 1)
	fi
	if [[ -z $name ]]; then
		echo "not found $arg"
		exit 1
	fi
	echo $name

}

changefont() {
	name=$(getfont "$1")
	printf '\e]710;%s\007' "xft:$name:pixelsize=20";
}

if [[ $# -eq 0 ]]; then 
	fontlist
elif [[ $1 == "loop" ]]; then
	fontlist | while read line; do 
		echo $line
		changefont "$line"
		sleep 1
	done
else
	name=$(getfont $1)
	if [[ -n $name ]]; then
		echo "changing raw to $1"
		printf '\e]710;%s\007' "xft:$1";
	else
		echo "changing to $name"
		changefont $name
	fi
	
fi
