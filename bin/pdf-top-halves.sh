#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :
#
# https://unix.stackexchange.com/questions/182485/combine-parts-of-pages-of-a-pdf-document

set -euo pipefail
umask 027
set -x

if ! [ -r "$1" ]; then
    printf "Unable to read file \`%s'\n" "$1" >&2
    exit 1
fi
fn_in="$1"
nr=$(basename "$fn_in" .pdf)


# File names.
fn_top=$(printf "%s-top.pdf" $nr)
fn_bottom=$(printf "%s-bottom.pdf" $nr)
fn_combi=$(printf "%s-combi.pdf" $nr)
fn_fine=$(printf "%s-fine.pdf" $nr)

# Get dimensions
read -r p w h <<<$(pdfinfo $fn_in | awk '/^Pages:/{print $2}/^Page size/{print $3, $5}' | tr '\n' ' ')
echo "p:$p w:$w h:$h"
# Calculate pixel dimensions (might fail.)
((pix_w = w * 10))
((pix_h = h * 10))
echo "pix_w:$pix_w pix_h:$pix_h"

printf "Size %dx%d pts of %d pages\n" $w $h $p

# Percent
offs=50

((offs = h * offs / 100))
((pix_crop_h = pix_h - offs * 10 ))

echo $pix_crop_h $offs

# Extract top box to own pdf.
gs \
    -o $fn_top \
    -sDEVICE=pdfwrite \
    -g${pix_w}x$pix_crop_h \
    -c "<</PageOffset [0 -$offs]>> setpagedevice" \
    -f $fn_in

# Combine top and bottom files to one file.
if false; then

# Extract bottom box to own pdf.
gs \
    -o $fn_bottom \
    -sDEVICE=pdfwrite \
    -g${pix_w}x$pix_crop_h \
    -c "<</PageOffset [0 0]>> setpagedevice" \
    -f $fn_in

    pdftk \
      A=$fn_top \
      B=$fn_bottom \
      cat A1 B2 \
      output $fn_combi \
      verbose

    # Combine 2 pages to one.
    pdfjam $fn_combi --nup 1x2 --outfile $fn_fine
fi
pdfjam $fn_top --nup 1x2 --outfile $fn_fine
rm $fn_top
