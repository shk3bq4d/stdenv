#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

mygawk() {
    gawk '{
        res = $0
        # this is a comment
        if (match(res, /(.*)(a)(.*)/, m)) {
          res = m[1] toupper(m[2]) m[3] # his is another comment
        }
        print res
    }'
}

cat <<EOF | mygawk
abracadabra
bbbbb
ccc
dd
EOF

exit 0
        match($0, /a/, a){print "_"}{print}
