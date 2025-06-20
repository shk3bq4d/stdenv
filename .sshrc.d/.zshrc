# https://github.com/Powerlevel9k/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_USER_FOREGROUND='white'
POWERLEVEL9K_USER_BACKGROUND='blue'
POWERLEVEL9K_HOST_FOREGROUND='white'
POWERLEVEL9K_HOST_BACKGROUND='cyan'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='green'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='28'
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='250'
POWERLEVEL9K_USER_SUDO_FOREGROUND='28'
POWERLEVEL9K_USER_SUDO_BACKGROUND='250'
POWERLEVEL9K_USER_ROOT_FOREGROUND='28'
POWERLEVEL9K_USER_ROOT_BACKGROUND='250'
POWERLEVEL9K_HOST_REMOTE_FOREGROUND='white'
POWERLEVEL9K_HOST_REMOTE_BACKGROUND='cyan'
#POWERLEVEL9K_COLOR_SCHEME="dark"
POWERLEVEL9K_ALWAYS_SHOW_USER=false
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
cd # it's important to change directory before sourcing zsh-z.plugin.zsh otherwise an error pops up
for i in \
	/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
	/usr/share/zsh-z/zsh-z.plugin.zsh \
	/usr/share/powerlevel9k/powerlevel9k.zsh-theme \
	${RCD:-/nonexisting}/.bashrc
	; do
	test -r $i && source $i
done
#HIST_STAMPS="dd.mm.yyyy"
setopt no_share_history   # https://stackoverflow.com/questions/9502274/last-command-in-same-terminal
setopt inc_append_history # https://stackoverflow.com/questions/842338/how-do-i-tell-zsh-to-write-the-current-shells-history-to-my-history-file/842366
setopt extended_history
alias history='history -i'
HISTSIZE=40000
SAVEHIST=40000
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=11'
bindkey -v
#set -o vi
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^a' vi-forward-blank-word # zsh-autosuggestions
bindkey '^o' autosuggest-accept
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey '^r' history-incremental-search-backward

if [[ -z "${HISTFILE:-}" ]]; then
	if [[ -n ${SUDO_USER:-} ]]; then
		HISTFILE=~/.zsh_history.$SUDO_USER
	else
		HISTFILE=~/.zsh_history
	fi
else
	#echo ".sshrc.d/.zshrc not replacing HISTFILE $HISTFILE"
	true
fi

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
#export VISUAL=vim
#export EDITOR=vim
