BEGIN { FS = "[^A-Za-z]+" }
{ for(i = 1 ; i <= NF ; i++)  word[$i] = "" }


ipcalc 195.49.117.116/27 | awk '/^Network/'
ipcalc 195.49.117.116/27 | awk '{ if (/^Network/ ) { print $2 } }'

| awk '{ printf "%.2f GB\t%s\t%s\n", $1/1024/1024/1024, $2, $3 } # bytes to gigabytes

| awk -F: '{print $NF}' # IFS, colon separated, last field
