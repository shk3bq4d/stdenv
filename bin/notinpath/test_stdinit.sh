#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 29 Dec 2017
##

set -euo pipefail
set -x
_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" && -f "$_tempfile" ]] && rm -f $_tempfile; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
echo "#!/usr/bin/env bash

echo '10.1.1.42 jexternalssh.ly.lan' >> /etc/hosts
echo '10.1.1.221 charlotte.ly.lan charlotte' >> /etc/hosts
cp -r ~/.ssh2 ~/.ssh
apt update && apt install -y git ssh
~/bin/stdinit.sh
#echo 'ssh jexternalssh.ly.lan' 
" > $_tempfile
chmod a+x $_tempfile

[[ -z ${SSH_ENV:-} ]] && SSH_ENV=~/.ssh/environment
source $SSH_ENV 
bash -x docker-ubuntu.sh \
	-v ~/.ssh:/root/.ssh2:ro \
	-v ~/bin/stdinit.sh:/root/bin/stdinit.sh:ro \
	-v $_tempfile:/root/bin/go:ro \
	-v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK:ro \
	-e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
	-e SSH_AGENT_PID=$SSH_AGENT_PID \
	-e SSH_ENV=$SSH_ENV \
	-e PATH=/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin \
	-w /root/bin \

exit 0

