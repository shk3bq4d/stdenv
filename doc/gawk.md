BEGIN { FS = "[^A-Za-z]+" }
{ for(i = 1 ; i <= NF ; i++)  word[$i] = "" }


ipcalc 195.49.117.116/27 | awk '/^Network/'
ipcalc 195.49.117.116/27 | awk '{ if (/^Network/ ) { print $2 } }'
