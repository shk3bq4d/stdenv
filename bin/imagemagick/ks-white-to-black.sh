#!/usr/bin/env bash

set -x
set -e
set -u

i=~/Pictures//i3lock/ks3840x2160white.png
o=~/Pictures//i3lock/ks3840x2160black.png
#o=~/tmp/out.png
cp -f $i $o
# convert $i -fuzz 15% -fill black -opaque white -opaque "rgb(216,217,62)"

COL4="#0E3A61"
#COL1="#000000"
COL4B='#0000FF'
REGION4=1200x2000+2700x0
mogrify -region $REGION4 -fuzz 35% -fill "$COL4B" -opaque "$COL4" $o 

COL1="#737476"
#COL1="#000000"
COL1B='#FF0000'
REGION1=2700x2000
mogrify -region $REGION1 -fuzz 25% -fill "$COL1B" -opaque "$COL1" $o 

COL2="#999A9C"
#COL1="#000000"
COL2B='#00FF00'
REGION2=1200x2000+2700x0
mogrify -region $REGION2 -fuzz 5% -fill "$COL2B" -opaque "$COL2" $o 


COL3=white
#COL1="#000000"
COL3B=black


mogrify -fuzz 76% -fill "$COL3B" -opaque "$COL3" $o 

mogrify -region $REGION4 -fuzz 25% -fill "$COL4" -opaque "$COL4B" $o 
mogrify -region $REGION2 -fuzz 25% -fill "$COL2" -opaque "$COL2B" $o 

mogrify -region $REGION1 -fuzz 25% -fill "$COL1" -opaque "$COL1B" $o 

#convert $i -fuzz 15% -fill "$COL1B" -opaque "$COL1" $o
mogrify -blur 1x1 $o
feh -p --auto-zoom -. -B black $o
