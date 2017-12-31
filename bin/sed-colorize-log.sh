#!/usr/bin/env bash


# 16 colors
NONE="\033[0m"    # unsets color to term's fg color
BOLD="\033[1m"

BLACK="\033[0;30m"    # black
RED="\033[0;31m"    # red
GREEN="\033[0;32m"    # green
YELLOW="\033[0;33m"    # yellow
BLUE="\033[0;34m"    # blue
MAGENTA="\033[0;35m"    # magenta
CYAN="\033[0;36m"    # cyan
WHITE="\033[0;37m"    # white

# empahsized (bolded) colors
EMBLACK="\033[1;30m"
EMRED="\033[1;31m"
EMGREEN="\033[1;32m"
EMYELLOW="\033[1;33m"
EMBLUE="\033[1;34m"
EMMAGENTA="\033[1;35m"
EMCYAN="\033[1;36m"
EMWHITE="\033[1;37m"

# background colors
BGBLACK="\033[40m"
BGRED="\033[41m"
BGGREEN="\033[42m"
BGYELLOW="\033[43m"
BGBLUE="\033[44m"
BGMAGENTA="\033[45m"
BGCYAN="\033[46m"
BGWHITE="\033[47m"

OFF="\033[m"

# 256 http://web.archive.org/web/20131009193526/http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
#echo -e "testing \033[38;5;196;48;5;21mCOLOR1\033[38;5;208;48;5;159mCOLOR2\033[m"



cat "$@" | sed -r \
	-e "s/(ERROR|Exception|failure|fail\\>|failed|fatal)/$(echo -e ${BGRED}${EMWHITE})\1$(echo -e ${OFF})/ig" \
	-e "s/(warn(ing)?)/$(echo -e ${MAGENTA})\1$(echo -e ${OFF})/ig" \
	-e "s/(INFO\\>)/$(echo -e ${GREEN})\1$(echo -e ${OFF})/ig" \
	-e "s/(^20[12][0-9][ -:,0-9]+)/$(echo -e ${BLUE})\1$(echo -e ${OFF})/ig"
