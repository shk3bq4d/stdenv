#!/usr/bin/env bash
export COLUMNS=9000
unset MR_COLUMNS
PIPE="cat -"
PIPE3="cat -"
pipe2() {
	local c defaultns
	c=""
	defaultns="$(readlink /proc/1/ns/mnt | tr -d -c [:digit:])"
	while read a b; do
		if [[ -n "$c" ]] && [[ "$c" != "$a" ]]; then
			echo "----------------"
		fi
		c="$a"
		if [[ "$a" = "$defaultns" ]]; then
			a="           "
		fi
		echo "$a $b"
	done
}
_tempfile=
function cleanup() { [[ -f "$_tempfile" ]] && rm -f $_tempfile; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
ONLYPID=0
if [[ $# -gt 0 ]]; then
	_tempfile=$(mktemp);
	for var in "$@"; do
		if [[ "$var" == "-p" ]]; then
			ONLYPID=1
		else
			echo "$var" >> $_tempfile
			PIPE="grep -i --color=always -F -f $_tempfile"
		fi
	done
fi
if [[ -n "${MR_COLUMNS+1}" ]] && command -v fmt >/dev/null; then
	#echo "MR_COLUMNS is $MR_COLUMNS"
	case "$(uname)" in  \
	FreeBSD)
		PIPE3="fmt -w ${MR_COLUMNS-3}"
		;;
	*)
		PIPE3="fmt -t -w ${MR_COLUMNS-3}"
		;;
	esac
	if false && command -v tput >/dev/null; then
		tput reset
		tput init
		tput cols
		echo $COLUMNS
		#PIPE3="$PIPE3 -w $(tput cols)"
		true
	fi
fi
if [[ "$ONLYPID" -eq 1 ]]; then
	PIPE3="sed -r -e s/^(\\w+\\s+)(\\w+)\\s.*/\2/"
fi
#echo "onlypid is $ONLYPID"

if [[ -t 1 && "$ONLYPID" -eq 0 ]]; then
	NONE="\033[0m"    # unsets color to term's fg color
	BOLD="\033[1m"
	OFF="\033[m"
	BLACK="\033[0;30m"    # black
	RED="\033[0;31m"    # red
	GREEN="\033[0;32m"    # green
	YELLOW="\033[0;33m"    # yellow
	BLUE="\033[0;34m"    # blue
	MAGENTA="\033[0;35m"    # magenta
	CYAN="\033[0;36m"    # cyan
	WHITE="\033[0;37m"    # white
	EMBLACK="\033[1;30m"
	EMRED="\033[1;31m"
	EMGREEN="\033[1;32m"
	EMYELLOW="\033[1;33m"
else
	NONE=""    # unsets color to term's fg color
	BOLD=""
	OFF=""
	BLACK=""    # black
	RED=""    # red
	GREEN=""    # green
	YELLOW=""    # yellow
	BLUE=""    # blue
	MAGENTA=""    # magenta
	CYAN=""    # cyan
	WHITE=""    # white
	EMBLACK=""
	EMRED=""
	EMGREEN=""
	EMYELLOW=""
fi
#echo "MR_COLUMNS is $MR_COLUMNS"
#echo "PIPE is $PIPE"
#echo "PIPE3 is $PIPE3"
export COLUMNS=2000
function red() { echo -ne "$RED"; }
function off() { echo -ne "$OFF"; }
ps wwxao mntns,user,pid,ppid,start,args k mntns,pgid,ppid,pid --cols=$COLUMNS </dev/null | \
	grep -vF "sshrc requires openssl to be installed on the server" | \
	sed -r \
		-e "/^(\\w+\\s+){1,2}($$\\s+)/ d" \
		-e "s/^(\\w+\\s+)(\\w+\\s+)(\\w+\\s+)(\\w+\\s+)(.*)/\\1$(echo -ne "$RED")\\2$(echo -ne "$BLUE")\\3$(echo -ne "$GREEN")\\4$(echo -ne "$OFF")\\5/" \
		| \
	$PIPE | \
	pipe2 | \
	$PIPE3

cleanup
exit 0
