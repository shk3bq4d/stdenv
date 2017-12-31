
https://trac.ffmpeg.org/wiki/How%20to%20speed%20up%20/%20slow%20down%20a%20video # how to speed up a video
ffmpeg -i input.mkv -filter:v "setpts=0.5*PTS" output.mkv


ffmpeg -i example.mkv -c copy -an example-remove-no-sound.mkv # https://superuser.com/questions/268985/remove-audio-from-video-file-with-ffmpeg


ffmpeg -i 20170318_100335.mp4  -filter:v "setpts=0.2*PTS"  -an out.mp4


ffmpeg -i input.avi -vf scale=320:240 output.avi # resample scale image or video
