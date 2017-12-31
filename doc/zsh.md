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


dolphin &!  # The &! (or equivalently, &|) is a zsh-specific shortcut to both background and disown the process, such that exiting the shell will leave it running.

