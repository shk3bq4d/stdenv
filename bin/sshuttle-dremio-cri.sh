#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail

HOST=may19
case $(hostname -f) in \
apr16.ly.lan|may19.sfcri.lan|nov20.ly.lan|feb22.ly.lan|shaz*)
    #! at-work.sh && echo "FATAL: dec17 not at work" && sleep 5 && exit 1
    NETS="
10.102.24.101/32
10.102.24.241/32
10.102.24.242/32
    "
    EXCEPTIONS="
"
    HOST=apdco102p11.mfogroup.co
    ;;
*)
    echo "FATAL: unknown source $(hostname -f)"
    exit 1
    ;;
esac
NETS=$(sed -n -r -e '/^\s*[^# ]+/s/\s*([^#]+)#?.*/\1/ p' <<< "$NETS")

EXCEPTIONS=$(sed -n -r -e '/^\s*[^# ]+/s/\s*([^#]+)#?.*/-x \1/ p' <<< "$EXCEPTIONS")

set +e
while :; do
    echo starting
    set -x
    #sshuttle -v --dns -r charlotte $EXCEPTIONS $NETS
    sshuttle -v -r $HOST $EXCEPTIONS $NETS
    set +x
    echo sleeping
    sleep 1m
done 2>&1 | sed -u -r -e "s/^/$(basename $0): /" | ts

echo EOF
exit 0

