#!/usr/bin/env bash


SCRIPT="$1"
LOG="$2"
exec > >(tee "$LOG")
exec 2>&1

# puppet module to capsule
if [[ "$SCRIPT" = */puppet-envs/modules/* ]]; then
	last_capsule_fp=~/.tmp/vimf6-last_capsule
	all_capsule_fp=~/.tmp/vimf6-all_capsule

	k=0
	if [[ -f $last_capsule_fp ]]; then
		last_capsule=$(<$last_capsule_fp)
		# all_proposals="$(grep -vw $last_capsule $all_capsule_fp)"
	else
		last_capsule=""
	fi
	# all_proposals="$(<$all_capsule_fp)"

	readarray pA < $all_capsule_fp

	# echo "$all_proposals"
	# exit 0
	choice=-1
	#echo "$all_proposals" |
	#while read line; do
	for k in "${!pA[@]}" # iterate over an array
	do
		printf "%2i %s\n" $k ${pA[$k]}
	done 
	while :; do
		echo -en "\nChoose your capsule [$last_capsule]: "
		read response
		echo "r:$response c:$choice"
		if [[ -z $response ]]; then
			if [[ -n $last_capsule ]]; then
				capsule=$last_capsule
				break
			fi
			continue
		fi
		capsule=${pA[$response]}
		[[ -n "$capsule" ]] && break
	done

	echo -e "\ncapsule is $capsule\n"
	puppet-file-to-capsule.sh $capsule $SCRIPT
	echo -n $capsule > $last_capsule_fp
	
	exit 0
fi


# executables
if [[ -x "$SCRIPT" ]]; then
	$SCRIPT
	echo "vimf6.sh -x exit code is $?"
	exit 0
fi

# shebang
FIRSTLINE=$(head -n 1 $SCRIPT)
if [[ $FIRSTLINE =~ ^#!.* ]]; then
	CMD=$(echo "$FIRSTLINE" | sed -r -e 's/^..//')
	$CMD $SCRIPT
	echo "vimf6.sh shebang exit code is $?"
	exit 0
fi

# by extension
case "$SCRIPT" in \
*sh)  bash $SCRIPT;;
*py)  python2 $SCRIPT;;
*pl)  perl $SCRIPT;;
*php) php $SCRIPT;;
*md)  
	f=~/.local/bin/grip
	if [[ ! -x "$f" ]]; then
		echo "$0 FATAL $f, run pip install --user grip"
		exit 1
	fi
	if pgrep grip &>/dev/null; then
		echo "$0 INFO killing current existing grip session with PID $(pgrep grip)"
		pkill -9 grip
	fi
	echo "$0 starting background grip preview should starting in new browser tab"
	nohup ~/.local/bin/grip --quiet --title "$SCRIPT" -b $SCRIPT &>/dev/null &
	exit 0
	;;
*txt)
	echo "($(basename $0)): ignored for filetype $SCRIPT"
	exit 0
	;;
*)
	echo "($(basename $0)): unimplemented case for script $SCRIPT"
	exit 1
	;;
esac
echo "vimf6.sh by extension exit code is $?" # to review if we have case exit corde or real interpreter
