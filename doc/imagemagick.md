pkill compton &&O gpick -p
pkill compton && gcolor2

mogrify: saves image in place
convert: creates a new image

mogrify -rotate 90 filename.jpg
convert in_filename.jpg  -colorspace Gray out_filename.jpg
convert -rotate 90
convert -page A4 plan.jpg plan.pdf
identify image
identify -verbose image
c="ess.png"; b="logo-elastic-1000x343.png"; convert $b -crop 343x343+100+0 $c && identify $c
d="ess.png"; b="logo-elastic-1000x343.png"; convert -verbose $b -crop 346x343+0+0 -bordercolor none -border 15 $c && identify $c && command feh $c


$ identify.exe *jpg
Schema_mydb.jpg JPEG 5000x3722 5000x3722+0+0 8-bit DirectClass 822KB 0.000u 0:00.003

mogrify -resize 1100 *jpg

identify.exe *jpg
Schema_mydb.jpg JPEG 1100x819 1100x819+0+0 8-bit DirectClass 109KB 0.015u 0:00.003



pngcheck


# geometry
```bash
% Interpret width and height as a percentage of the current size.
!  Resize to width and height exactly, loosing original aspect ratio.
< Resize only if the image is smaller than the geometry specification.
> Resize only if the image is greater than the geometry specification.


convert $i -fuzz 28% -fill black -opaque white -opaque "rgb(216,217,62)" $o && feh $o # convert colors white and rgb(216,217,62) to black
convert kim-kardashian-celebrity-mask.jpg -fuzz 2% -transparent white  -resize 128x128 bip.png
convert kim-kardashian-celebrity-mask.jpg -fuzz 2% -transparent white  -crop 500x500+130+50 -resize 128x128 bip.png && command feh bip.png
convert awesome.png -fuzz 10% -transparent white  -resize '264x264!' -resize 128x128 bip.png && command feh bip.png # rezize likely distorted the image, true solution may have thumbnail of https://stackoverflow.com/questions/2130288/imagemagick-resize-image-to-square
convert yoda-02.png -crop 170x170+50+0 -background transparent -vignette 20x65000 bip.png && command feh bip.png

convert -resize 640x480 -depth 8 -colors 14 -background black -extent 640x480 ks3840x2160black.png grub.xpm # enlarge resample canvas
convert -resize '!640x480' -colors 256 starry-cosmic-background-with-nebula_213524-326.jpg grub.png
convert -resize '!156x156' in.png moxtra-square-icon.png
convert -resize '!507x324' in.jpg moxtra-large-icon.jpg

#f00                      #rgb
#ff0000                   #rrggbb
#ff0000ff                 #rrggbbaa
#ffff00000000             #rrrrggggbbbb
#ffff00000000ffff         #rrrrggggbbbbaaaa
rgb(255, 0, 0)            an integer in the range 0—255 for each component
rgb(100.0%, 0.0%, 0.0%)   a float in the range 0—100% for each component
rgb(255, 0, 0)                 range 0 - 255
rgba(255, 0, 0, 1.0)           the same, with an explicit alpha value
rgb(100%, 0%, 0%)              range 0.0% - 100.0%
rgba(100%, 0%, 0%, 1.0)        the same, with an explicit alpha value
gray(50%)        mid gray
graya(50%, 0.5)  semi-transparent mid gray
convert -bordercolor lime -border 10 image.jpg image.png
convert -bordercolor '#0f0' -border 10 image.jpg image.png
convert -bordercolor '#00ff00' -border 10 image.jpg image.png
convert -bordercolor 'rgb(0,255,0)' -border 10 image.jpg image.png
convert -bordercolor 'rgb(0,100%,0)' -border 10 image.jpg image.png

# http://www.fmwconcepts.com/imagemagick/magicwand/


convert -coalesce brocoli.gif out%05d.gif # convert -coalesce brocoli.gif out%05d.pgm
magicwand 1,1 -t 10 -o 0 in.gif out.gif
magicwand 0,0 -r outside -c red extracted00000.gif /var/www/html/out.gif
convert -delay 0 -loop 0 -alpha set -dispose 2 extr*gif screencapture.gif

# font list
convert -list type       # for IM older than v6.3.5-7
convert -list font       # for newer versions

convert selenium.png -gravity NorthEast -font DejaVu-Sans -annotate 0 "bip %[EXIF:DateTimeOriginal]" selenium2.png # adds overlay text
convert -density 300 -define pdf:fit-page=A4 FREE-Girl-On-Horse.jpg girl-on-horse.pdf

# gradient swift
i=~/global/apache-tomcat/webapps/ROOT/WEB-INF/www/fwdata/images//mbordertitle/w8h8_c8fbfef_bf8f9fb.png; test -f $i || { echo $i | sed -r -e 's/.*w8h8_c(.*)_b(.*).png/\1 \2/' | while read a b; do convert -size 8x8 gradient:"#${a}-#${b}" PNG8:"$i"; done; }

convert -size 100x100 xc:white canvas.jpg # create dummy image of fxied resolution

convert -flatten in.png out.png # convert transparent to white background (whatsapp)


convert +append img1.png img2.png img3.png out.png # horizontal concatenation
convert -append img1.png img2.png img3.png out.png # vertical concatenation


https://github.com/Matthias-Wandel/jhead
jhead -ft * # set file system last modification time to value set in exif data
