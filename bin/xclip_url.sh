#!/usr/bin/env bash

i=1
if [[ -n $1 ]]; then
	i=$1
fi

if [[ $i -gt 0 ]]; then

	URL=$(cat - | \
		grep -Po 'http\S+' | \
		sed -n -e "$i p"
		)
else
	i=$(( - $i ))
	URL=$(cat - | \
		grep -Po 'http\S+' | \
		tail -n $i | \
		head -n 1
		)
fi

echo $URL
echo -n $URL | xclip 

