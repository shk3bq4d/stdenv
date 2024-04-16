#!/usr/bin/env bash

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_sed() {
# stdrumo
    cat << 'EOF'
# removing
# Skipping empty key (hosts) in group (bip)
# Skipping empty key (children) in group (bup)
/^Skipping empty key .(hosts|children). in group/ d

#<10.103.24.1> SSH: EXEC ssh -C -o ControlMa
#<10.103.24.1> (0, b'/home/bup\n', b'')
#<10.103.24.1> ESTABLISH SSH CONNECTION FOR USER: bup
/^</ d

EOF
}

sed -u -r -e "$(_sed)" "$@"


exit $?
