-0, --null
-rn 1
-rtn 1
-n max-args  --max-args=max-args
-t           --verbose            Print the command line on the standard error output before executing it. # debug log print output dump
-p           --interactive        Prompt  the  user  about whether to run each command line and read a line from the terminal.  Only run the command line if the response starts with `y' or `Y'.  Implies -t.
-r           --no-run-if-empty
-I@ -i@ --replace=@ : xargs -I@ cp security-groups.tf @.tf
-o, --open-tty

xargs -d '\n'             ## GNU line separator while read line
| tr '\n' '\0' | xargs -0 ##     line separator while read line

xargs $ARGS bash -c '</dev/tty vim $@' ignoreme # when -o is not available
