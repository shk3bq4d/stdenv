
https://trac.ffmpeg.org/wiki/How%20to%20speed%20up%20/%20slow%20down%20a%20video # how to speed up a video
ffmpeg -i input.mkv -filter:v "setpts=0.5*PTS" output.mkv


ffmpeg -i example.mkv -c copy -an example-remove-no-sound.mkv # https://superuser.com/questions/268985/remove-audio-from-video-file-with-ffmpeg


ffmpeg -i 20170318_100335.mp4  -filter:v "setpts=0.2*PTS"  -an out.mp4


ffmpeg -i input.avi -vf scale=320:240 output.avi # resample scale image or video


ffmpeg -i in.mp4 out.mp3 # extracts only sound

for i in $(seq 1 12); do
	echo $i
	if ls *ep\ $i\ *webm &>/dev/null; then
		#echo *ep\ $i\ *webm
		#echo *ep\ $i\ *mp4
		ffmpeg -i *ep\ $i\ *mp4 -i *ep\ $i\ *webm -c copy $(printf 'miraculous-ladybug-season02-episode%02i.mkv' $i)
	else
		#echo *ep\ $i\ *m4a
		#echo *ep\ $i\ *mp4
		ffmpeg -i *ep\ $i\ *mp4 -i *ep\ $i\ *m4a -c copy $(printf 'miraculous-ladybug-season02-episode%02i.mkv' $i)
	fi
done
