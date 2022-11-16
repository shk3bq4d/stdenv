#!/usr/bin/env bash
# ex: set filetype=sh :

touch ~/.tmp/mri3server-receiver.touch
cat ~/.tmp/mri3server-block.msg
echo "" # apparently a new line ending the message is important
exit 0

cat << 'EOF'
{"full_text":"youpi"}
EOF
