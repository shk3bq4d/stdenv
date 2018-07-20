# https://github.com/Lokaltog/powerline-fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh

# omz oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
https://github.com/robbyrussell/oh-my-zsh
https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DejaVuSansMono/Regular/complete # font windows

unset HISTFILE

# https://stackoverflow.com/questions/17767208/writing-a-zsh-autocomplete-function


setopt null_glob # solves zsh: no matches found:

list_of_files=(*(N)) # solves zsh: no matches found: # Turn on the null_glob option for your pattern with the N glob qualifier.

dolphin &!  # The &! (or equivalently, &|) is a zsh-specific shortcut to both background and disown the process, such that exiting the shell will leave it running.

# explodes spaces in variable so as not to pass as quoted ones (un-quote unquote) to split variables as $IFS
either with ${=VARNAME} notation such as in:
./kafka-topics.sh ${=ZK} --list
or
set -o SH_WORD_SPLIT
exhibit:
ZK="bip hehe"
echo $ZK
bip hehe
set -x; echo $ZK; set +x
+zsh:8> echo bip hehe
bip hehe
+zsh:8> set +x
set +o SH_WORD_SPLIT
set -x; echo $ZK; set +x
+zsh:10> echo 'bip hehe'
bip hehe
+zsh:10> set +x

# z
https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/z
z -x # exclude current directory from index
