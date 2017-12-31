BEGIN { FS = "[^A-Za-z]+" }
{ for(i = 1 ; i <= NF ; i++)  word[$i] = "" }
