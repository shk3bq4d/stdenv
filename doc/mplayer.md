v: toggle subtitle visibility

LEFT and RIGHT Seek backward/forward 10 seconds.
              UP and DOWN Seek forward/backward 1 minute.
              PGUP and PGDWN Seek forward/backward 10 minutes.
              [ and ] Decrease/increase current  playback  speed by 10%.
              { and } Halve/double current playback speed.
              BACKSPACE Reset playback speed to normal.
              < and > Go backward/forward in the playlist. next
              ENTER Go  forward in the playlist, even over the end.
              HOME and END next/previous playtree entry in the parent list
              INS and DEL (ASX playlist only) next/previous alternative source.
              p / SPACE Pause (pressing again unpauses).
              .
                   Step  forward.   Pressing  once will pause
                   movie, every consecutive press  will  play
                   one  frame  and  then  go  into pause mode
                   again (any other key unpauses).
              q / ESC Stop playing and quit.
              U Stop playing (and quit  if  -idle  is  not used).
              + and - Adjust audio delay by +/- 0.1 seconds.
              / and * Decrease/increase volume.
              9 and 0 Decrease/increase volume.
              ( and ) Adjust  audio  balance  in  favor of left/ right channel.
              m Mute sound.


# subvideo cut extract https://askubuntu.com/questions/56022/what-to-use-to-quickly-cut-audio-video
ffmpeg -ss 00:00:00 -t 00:30:00 -i input.avi -vcodec copy -acodec copy output1.avi

ffmpeg -ss 0 -t 100 -i source.m4v -vcodec copy -acodec copy part1.m4v

avconv -i input.avi -vcodec copy -acodec copy -ss 00:00:00 -t 00:30:00 output1.avi

avconv -ss 0 -i source.m4v -t 100 -vcodec copy -acodec copy part1.m4v
