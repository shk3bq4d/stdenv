import sys
if sys.stdout.isatty():
	none="\033[0m"    # unsets color to term's fg color
	bold="\033[1m"
	off="\033[m"
	black="\033[0;30m"    # black (or more likely white if terminal in day mode)
	red="\033[0;31m"    # red
	green="\033[0;32m"    # green
	yellow="\033[0;33m"    # yellow
	blue="\033[0;34m"    # blue
	magenta="\033[0;35m"    # magenta
	cyan="\033[0;36m"    # cyan
	white="\033[0;37m"    # white (or more likely black if terminal in day mode)
	emblack="\033[1;30m"
	emred="\033[1;31m"
	emgreen="\033[1;32m"
	emyellow="\033[1;33m"
	emblue="\033[1;34m"
	emmagenta="\033[1;35m"
	emcyan="\033[1;36m"
	emwhite="\033[1;37m"
	bgblack="\033[40m"
	bgred="\033[41m"
	bggreen="\033[42m"
	bgyellow="\033[43m"
	bgblue="\033[44m"
	bgmagenta="\033[45m"
	bgcyan="\033[46m"
	bgwhite="\033[47m"
else:
	none=""    # unsets color to term's fg color
	bold=""
	off=""
	black=""    # black
	red=""    # red
	green=""    # green
	yellow=""    # yellow
	blue=""    # blue
	magenta=""    # magenta
	cyan=""    # cyan
	white=""    # white
	emblack=""
	emred=""
	emgreen=""
	emyellow=""
	emblue=""
	emmagenta=""
	emcyan=""
	emwhite=""
	bgblack=""
	bgred=""
	bggreen=""
	bgyellow=""
	bgblue=""
	bgmagenta=""
	bgcyan=""
	bgwhite=""
