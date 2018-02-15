#!/usr/bin/env bash                                            
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
##
## Author: Jeff Malone, 22 Dec 2017
##

set -exuo pipefail

need_powerlinefonts() {
	if find ~/.local/share/fonts -type f -iname '*powerline.ttf' -print -quit 2>/dev/null | grep -qE .; then
		return 1
	fi
	return 0
}

os=()

os+=('apt-transport-https') # docker ppa
os+=('ascii')
os+=('acpi')
os+=('build-essential') # youcompleteme vim plugin build depedencies
os+=('ca-certificates') # docker ppa
os+=('chromium-browser')
os+=('cmake') # youcompleteme vim plugin build depedencies
os+=('compton')
os+=('curl') # docker ppa
os+=('dos2unix')
os+=('fonts-font-awesome')
os+=('fonts-powerline')
os+=('mplayer')
os+=('feh')
os+=('gawk')
os+=('git')
os+=('gitk')
#os+=('i3') # replaced by i3-gaps
#os+=('i3status')
os+=('ipcalc')
os+=('lsyncd')
os+=('net-tools') # netstat
os+=('parcellite')
os+=('pavucontrol')
os+=('python-pip')
os+=('python3-pip')
os+=('python2.7')
os+=('rxvt-unicode-256color')
os+=('software-properties-common') #docker ppa
os+=('shutter')
os+=('sysstat')
os+=('util-linux') # tailf
os+=('vim-gtk')
os+=('xclip')
os+=('x11-utils') # xprop used in some i3.py mr scripts
os+=('zsh')
os+=('apt-transport-https') # docker-ce
os+=('ca-certificates') # docker-ce
os+=('software-properties-common') # docker-ce

SUDO=sudo
command -v sudo 2>/dev/null || SUDO=""

$SUDO apt update
$SUDO apt install -y ${os[@]}

# docker
if ! dpkg -s docker-ce 2>/dev/null; then
	$SUDO apt-key fingerprint 0EBFCD88 || curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $SUDO apt-key add -
	$SUDO apt-key fingerprint 0EBFCD88
	$SUDO apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8
	$SUDO add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	$SUDO apt update
	$SUDO apt install docker-ce
fi
$SUDO usermod -aG docker $(whoami)

unset PYTHONPATH

pip3=()
pip3+=('i3ipc')
pip3+=('requests')
#pip3+=('procinfo') # installation seem to fail when done at the same time as psutil....
pip3+=('psutil')
pip3+=('sh')
pip3+=('sshuttle')
pip3 install --user ${pip3[@]}

pip=()
pip+=('i3ipc')
pip+=('requests')
# pip+=('procinfo') # installation seem to fail when done at the same time as psutil....
pip+=('psutil')
pip+=('kazoo')
pip+=('websocket-client')
pip+=('sh')
pip install --user ${pip[@]}

touch ~/.z
cd $HOME
if [[ ! -d .oh-my-zsh ]]; then
	sh -c "$(curl -kfsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
if [[ ! -h ~/.zshrc ]]; then
	t="$(stdhome-dirname.sh 2>/dev/null)/.zshrc"
	if [[ -f $t ]]; then
		ln -sf $t ~/.zshrc
	fi
fi
z=$(which zsh)
if [[ $z != $(getent passwd $LOGNAME | cut -d: -f7) ]]; then
	chsh -s $(which zsh)
fi

git="""
.oh-my-zsh/custom/plugins/zsh-autosuggestions git://github.com/zsh-users/zsh-autosuggestions
"""
#need_powerlinefonts && git="$(echo -e "$git\ngit/powerline-fonts https://github.com/powerline/fonts.git\n")"
echo "$git" | while read d r; do
	[[ -z "$d" ]] && continue
	[[ -d $d ]] && continue
	p=$(dirname $d)
	[[ -d $p ]] || mkdir -p $p
	cd $HOME
	git clone $r $d
done
#need_powerlinefonts && ~/git/powerline-fonts/install.sh

exit 0

