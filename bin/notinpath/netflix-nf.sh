#!/usr/bin/env bash
# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */
~/bin/mute-off.sh
~/bin/volume-50.sh
#nohup /usr/bin/google-chrome https://www.netflix.com/browse &>/dev/null &
sites() {
    cat << EOF
netflix.com
EOF
}
for i in $(sites); do
    [[ -z "$i" ]] && continue
    #nohup $HOME/bin/default-browser --new-window https://$i </dev/null &>/dev/null &
    nohup $HOME/bin/chromium-browser --new-window https://$i </dev/null &>/dev/null &
done
for i in $(seq 1); do
    #/usr/bin/mplayer ~/Music/bip-stereo.mp3
    sleep 1
done
