```sh
rm -r ~/.local/lib/python3*/site-packages/youtube_dl* &&  pip install --user git+https://github.com/ytdl-org/youtube-dl.git@master
mv ~/.local/lib/python3*/site-packages/youtube_dl* ~/.local/lib/python3*/site-packages/ydl-backup/;   pip install --user git+https://github.com/ytdl-org/youtube-dl.git@master
pip install --user git+https://github.com/ytdl-org/youtube-dl.git@master
```
$ youtube-dl 'https://www.youtube.com/watch?v=wQP9XZc2Y_c' --recode-video mp4 --postprocessor-args '-strict -2'

youtube-dl --ignore-errors --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" playlisturl

https://www.youtube-nocookie.com # to better embed videos


OSBLC https://www.youtube.com/watch?v=XoDY9vFAaG8
OSBM  https://www.youtube.com/watch?v=I3sJaJMdoPs
vaina playlist https://www.youtube.com/playlist\?list\=PLx8R-ixn250vlO14TY1ILr0A5m_I6fnc2


https://www.youtube.com/watch?v=WjQhHvw1obU
https://www.youtube.com/watch?v=UhPxxeDTS1U soca bate vira
https://www.youtube.com/playlist?list=PLVMPUbJD7RMGviS5uYlWD-ghEVXX6uirf fifi brindassier

# joakim
https://www.youtube.com/results?search_query=708cn


# ublock origin youtube shorts block
https://letsblock.it/filters/youtube-shorts


[Et toi Pascal! Tu parles toujours pour rien?](https://www.youtube.com/watch?v=OQXbcf9dflw#t=2m02s)

Start playback at time position 1:20 (1 minute and 20 seconds into the video): http://www.youtube.com/watch?v=69hADT4pWWc#t=1m20s

Add #t=1m20s after the video’s URL
FORMAT: t=XhYmZs –> X hours, Y minutes, Z seconds
NOTE: If there’s already a “#” or “hash” or “pound sign” in the URL, you’ll need to change from #t=1m20s to &t=1m20s


# Keyboard shortcut	Function
Spacebar	Play/Pause when the seek bar is selected. Activate a button if a button has focus.
Play/Pause Media Key on keyboards	Play / Pause.
k	Pause/Play in player.
m	Mute/unmute the video.
Stop Media Key on keyboards	Stop.
Next Track Media Key on keyboards	Moves to the next track in a playlist.
Left/Right arrow on the seek bar	Seek backward/forward 5 seconds.
j	Seek backward 10 seconds in player.
l	Seek forward 10 seconds in player.
.	While the video is paused, skip to the next frame.
,	While the video is paused, go back to the previous frame.
>	Speed up the video playback rate.
<	Slow down the video playback rate.
Home/End on the seek bar	Seek to the beginning/last seconds of the video.
Up/Down arrow on the seek bar	Increase/Decrease volume 5%.
Numbers 1 to 9	Seek to the 10% to 90% of the video.
Number 0	Seek to the beginning of the video.
/	Go to search box.
f	Activate full screen. If full screen mode is enabled, activate F again or press escape to exit full screen mode.
c	Activate closed captions and subtitles if available. To hide captions and subtitles, activate C again.
Shift+N	Move to the next video (If you're using a playlist, will go to the next video of the playlist. If not using a playlist, it will move to the next YouTube suggested video).
Shift+P	Move to the previous video. Note that this shortcut only works when you're using a playlist.
i	Open the Miniplayer.
