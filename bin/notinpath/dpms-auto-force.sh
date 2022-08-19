#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

export DISPLAY=$(source ~/bin/notinpath/dot.display)

idle_time() {
    xssstate -i
}

time_to_wait_before_screensaver() {
    xssstate -t
}

screen_saver_state() {
    # returns on, off or disabled
    xssstate -s
}

audio_is_playing() {
    # https://stackoverflow.com/questions/17404443/how-to-detect-that-the-sound-is-currently-playing-in-linux
    pacmd list-sink-inputs  | grep -w state | grep -q RUNNING
}

audio_is_not_playing() {
    ! audio_is_playing
}

audio_is_mute() {
    amixer -q -D pulse scontents Master,0 | grep -qw off
}

idle_time_greater_than_threshold() {
    IDLE_TIME_THRESHOLD=$(at-work.sh && echo 120 || echo 10 )
    IDLE_TIME_THRESHOLD=$(( 60 * 1000 * $IDLE_TIME_THRESHOLD ))
    test "$(idle_time)" -gt $IDLE_TIME_THRESHOLD
}

screen_saver_on() {
   test "$(screen_saver_state)" == "on"
}

start_screen_saver() {
    is_debug && echo "start_screen_saver" ||
    xset dpms force off
}

is_debug() {
   false
}

debug() {
    date
    echo -n "at-work.sh                       "; at-work.sh                       && echo yes || echo no
    echo -n "idle_time_greater_than_threshold "; idle_time_greater_than_threshold && echo yes || echo no
    echo -n "screen_saver_on                  "; screen_saver_on                  && echo yes || echo no
    echo -n "audio_is_not_playing             "; audio_is_not_playing             && echo yes || echo no
    echo -n "audio_is_mute                    "; audio_is_mute                    && echo yes || echo no
}


#is_debug && debug | tee ~/.tmp/dpms-auto-force.log
             debug | tee ~/.tmp/dpms-auto-force.log
if idle_time_greater_than_threshold; then
    if ! screen_saver_on; then
        if true; then
            start_screen_saver
        elif audio_is_not_playing || audio_is_mute; then
            start_screen_saver
        fi
    fi
fi

exit 0
