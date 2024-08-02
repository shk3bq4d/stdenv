~/.vifm/vifmrc
only
set previewprg=/home/burp/tmp/a.sh
set quickview
":set runexec
:fileviewer * /home/burp/tmp/a.sh
:fileviewer *.sh /home/burp/tmp/a.sh
:filetype *.sh /home/burp/tmp/a.sh
