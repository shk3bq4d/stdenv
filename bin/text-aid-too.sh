#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 26 Feb 2018
##

set -euo pipefail

# function usage() { sed -r -n -e s/__SCRIPT__/$(basename $0)/ -e '/^##/s/^..// p'   $0 ; }

# [[ $# -eq 1 && ( $1 == -h || $1 == --help ) ]] && usage && exit 0

# [[ $# -lt 1 || $# -gt 2 ]] && echo FATAL: incorrect number of args && usage && exit 1

# for i in sed which grep; do ! command -v $i &>/dev/null && echo FATAL: unexisting dependency $i && exit 1; done

# DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

# exec > >(tee -a ~/log/$(basename $0 .sh).log)
# exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info ))
# exec 2>&1

# test -z "${HOSTNAMEF:-}" && HOSTNAMEF=$(hostname -f)
# sudo npm install -g coffee-script
# sudo npm install -g text-aid-too
#
export PATH=~/.npm-packages/bin/:$PATH
export TEXT_AID_TOO_EDITOR="mrurxvt-vim.sh"
export TEXT_AID_TOO_SECRET="my-secret-is-better-than-yours"
if ! which text-aid-too &>/dev/null; then 
	if ! which npm &>/dev/null; then 
		echo "need to install npm binary"
		sudo apt install npm
	fi
	echo "need to install npm packages"
	sudo npm install -g coffee-script  text-aid-too
fi
echo "https://chrome.google.com/webstore/detail/text-aid-too/klbcooigafjpbiahdjccmajnaehomajc?hl=en-US"
echo "shortcut is The default is Ctrl-; ]"
text-aid-too --port 9299
echo EOF
exit 0

