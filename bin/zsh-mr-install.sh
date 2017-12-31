#!/usr/bin/env bash
 
set -eux
if ! command -v zsh &>/dev/null; then
	case "$UNAME" in \
	cygw*)
		apt-cyg install zsh
		;;
	freebsd)
		sudo pkg install zsh
		;;
	*)
		echo "FATAL: unimplemented ZSH install"
		exit 1
		;;
	esac
fi
function apply_zshrc() {
	f=~/.zshrc
	if [[ ! -h "$f" ]]; then
		if [[ -f "$f" ]]; then
			mv -f "$f" ${f}-zsh-mr-install.bkup
		else
			if [[ -z "${STDHOME_DIRNAME}" ]]; then
				echo "FATAL: \$STDHOME_DIRNAME not set"
				exit 1
			fi
			ln -is "$STDHOME_DIRNAME/.zshrc" "$f"
		fi
	fi
}


apply_zshrc
export GIT_SSL_NO_VERIFY=true
if [[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
	echo "not a file oh-my-zsh.sh"
	[[ -d ~/.oh-my-zsh ]] && rm -rf ~/.oh-my-zsh # partial install 
	sh -c "$(curl -kfsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
apply_zshrc
