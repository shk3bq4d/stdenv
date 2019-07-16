# /* ex: set filetype=markdown: */


:echo g:pathogen_disabled
:echo hostname
:echo s:sys

:Helptags " rebuild doc tags on pathogen
:helptags ~/.vim/doc " rebuild doc tags for specified folder


# the following three modelines are for examples. modeline word is only here for grep purpose and not a valid vim config key
# /* ex: set nofoldenable modeline=: */
# /* ex: set filetype=vim modeline=: */
# ex: set filetype=vim modeline=:
[modeline]: # ( vim: set fenc=utf-8 markdownmodeline spell spl=en: )
replace motion with content of named buffer: "_cw^R"<Esc>

split
:sp
C-W C-j go below
C-W C-k go up

# delete lines containing regexp
:g/regexp/d

:{range}sort u

automatic syntax highlighting to a new file extension:
syntax on
filetype on
au BufNewFile,BufRead *.lmx set filetype=xml


# header modeline magic
/* ex: set tabstop=8 expandtab: */
// vim: noai:ts=4:sw=4
  -or-
/* vim: noai:ts=4:sw=4
*/
 -or-
/* vim: set noai ts=4 sw=4: */
  -or-
/* vim: set fdm=expr fde=getline(v\:lnum)=~'{'?'>1'\:'1': */
# vim: set expandtab:


# vertical insert multi-line https://stackoverflow.com/questions/9549729/in-vim-how-do-i-effectively-insert-the-same-characters-across-multiple-lines
Move the cursor to the first character where to insert on firs line
Enter visual block mode (CTRL-V-alternative CTRL-Q).
Press j three times.
Press I (capital i).
Type in vendor_.
Press esc.

blockwise visual mode
usually it's <C-v> (which doesn't work since y used it for system paste)
        or   <C-q> (which doesn't work for me in cygwin for reasons I can't understand)
set virtualedit=all
so in .vimrc i used :map <C-i> <C-q> # vertical blockwise visual mod


filter external command on every lines
:%!grep "pattern"
:.!grep "pattern"


# display hidden chars
:set list # cancel with :set nolist


# replace spaces on line
:s/\s\+/


#install a vba
#https://stackoverflow.com/questions/2033078/how-to-install-a-vimball-plugin-with-vba-extension
:source %
:so %


#current to hex
:%!xxd

# load file converted to hex
:r !xxd FILENAME
xxd FILENAME | vi -

# count occurences of pattern
:%s/pattern//n

#The following performs a search and replace in all buffers (all those listed with the :ls command):
:bufdo %s/pattern/replace/ge | update
#bufdo    Apply the following commands to all buffers.
#%s    Search and replace all lines in the buffer.
#pattern    Search pattern.
#replace    Replacement text.
#g    Change all occurrences in each line (global).
#e    No error if the pattern is not found.
#|    Separator between commands.
#update    Save (write file only if changes were made).
#The command above uses :update

#To replace "blue" with "green" in lines that contain "red":
:g/red/s/blue/green
#To do the replacement in lines that do not contain "red":
:g!/red/s/blue/green

# delete lines like bip
:g/bip/ d
:%g/todo/ s/o/a/g # applies replacement only on those lines

# replaces spaces with tabs
:set tabstop=2      " To match the sample file
:set noexpandtab    " Use tabs, not spaces
:%retab!            " Retabulate the whole file

# replaces tabs with spaces
:set tabstop=2      " To match the sample file
:set expandtab      " Use spaces, not tabs
:%retab!            " Retabulate the whole file

# search whole word i
\<i\>
# The pattern \<i finds all words that start with "i", while i\> finds all words that end with "i".

#Finding duplicate words
\(\<\w\+\>\)\_s*\1

# Finding two words in either order
.*red\&.*blue


red\|green\|blue
:%s/red\|green\|blue/purple/g
:%s/\<\(red\|green\|blue\)\>/"&"/g
:%s/color \<\(red\|green\|blue\)\>/colored \1/g

:%Align =

#default AlignCtrl =Clrc-+:pPIWw
set AlignCtrl  =Clrc-+:pPIWw
set AlignCtrl  =Clrc-+:pPIWw
set AlignCtrl  =lrc-+:pPIWw
# nospace between and after token
:AlignCtrl lp0P0



:set cursorcolumn # barre verticale d'alignement

gi # insert from last edit position


# go to percentage
20%
83%
...etc

# swap parameters swap_parameters.vim http://www.vim.org/scripts/script.php?script_id=2032
key bindings (normal mode):
[count]gb -- where count defaults to 1 -- swap the argument under
             the cursor with the [count] matenext one
[count]gB -- swap with the previous one


# diff
:set diff # If you loose the diff for whatever reason (e.g. I lost the diff when opening a new tab with :tabnew), turn the diff option on again.
:vert diffsplit [file2] # diff in existing window
]c # jump to next diff
[c # jump to previous diff
# merge
do # or :diffget gets diff from other viewport
dp # or :diffput push diff to the other viewpor
:63diffget gets line 63
zX restore original folds (do it on both buffers)
vimdiff -c 'set diffopt+=iwhite' # ignores whitespace


# fold
:{range}fo[ld] creat a fold for the lines in range
zA # expands folds recursively
za # expands fold
zC # closes  fold recusriveley
zX # undo manual folds

BASEDIR=~/.vim && mkdir -p $BASEDIR/autoload $BASEDIR/bundle && \
    curl -LSso $BASEDIR/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "execute pathogen#infect()" >>.vimrc

rsync -avr ~/.vim ~/.vimrc root@192.168.56.106:.


#regexp replace with capturing groups
:%s/bind\(sym\|code\)/bind\1 --release/



int i = 42;
for (int k = 17; k < 28; ++k)
{    sprintf(\03423, "%s");
}

:call SyntaxRange#Include('@begin=json@', '@end=json@', 'json', 'NonText')
@begin=c@
    int i = 42;
    for (int k = 17; k < 28; ++k)
    {    sprintf(\03423, "%s");
    }
@end=c@

vi -R #readonly

ipaddress \(\d\+\.\)\{3\}\d\{1,3\}

git mergetool
:diffg RE  " get from REMOTE
:diffg BA  " get from BASE
:diffg LO  " get from LOCAL

:echo expand("%:t")    " basename
:echo expand("%:p:h")  " absolute path
:echo expand("%:p:h")  " absolute path dirname
:echo expand("%:p:h:h")" absolute path dirname dirname
:echo expand("%.")     " relative path
:echo expand("%.:h")   " relative path dirname
:echo expand("%.:h:h") " relative path dirname dirname
:echo expand("<sfile>:p")  " absolute path to [this] vimscript
:help filename-modifiers



:AnsiEsc # https://vi.stackexchange.com/questions/485/can-vim-interpret-terminal-color-escape-codes



https://github.com/rodjek/vim-puppet.git

https://github.com/Valloric/YouCompleteMe#options

# list filetype ft # https://codeyarns.com/2015/03/19/how-to-list-filetypes-in-vim/
:echo glob($VIMRUNTIME . '/ftplugin/*.vim')
:echo glob($VIMRUNTIME . '/syntax/*.vim')


:GitGutterToggle # Explicitly turn Git Gutter on if it was off and vice versa.
:bufdo execute "GitGutterDisable"
:bufdo execute "GitGutterEnable"

# http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers

# https://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
:set textwidth=80
(optional in vimrc: ) au BufRead,BufNewFile *.md setlocal textwidth=80
v # select lines on which to apply
gq # apply
(optional :help gq)
# or more symply using the C-j alias configured in .vimrc map <C-j> gq} '.


set textwidth=120 # reformat/reflow paragraph according to textwidth. Support > for quotation
gqip # reformat/reflow paragraph according to textwidth. Support > for quotation
gql # reformat/reflow line      according to textwidth. Support > for quotation

# generator iterator
:put =map(range(1,150), 'printf(''%04d'', v:val)')
:for i in range(1,10) | put ='192.168.0.'.i | endfor

d]) # delete until next unmatched parenthesis, useful for nested function calls

https://stackoverflow.com/questions/1764263/what-is-the-leader-in-a-vimrc-file

# spell check english orthograph language french francais fautes
:set spell spl=en
:set spell
:set spl=en
:set spl=fr
z= suggestion # spell
]s move to next word # spell
[s mone te previous word # spell

# autosave https://vi.stackexchange.com/questions/74/is-it-possible-to-make-vim-auto-save-files
autocmd CursorHold,CursorHoldI * update

%:p # current filepath
:!ls -al %:p # current filepath
:!chmod u+w %:p # current filepath
:!chmod u+x %:p # current filepath

:set buftype=nofile # scratchpad no-save read-only-equivalent

```sh
:sav # https://stackoverflow.com/questions/31092505/how-to-save-a-file-with-a-new-name-in-vim-while-switching-to-that-new-buffer-an
```

set ft=messages " syslog

# browse VIM help
http://vim.wikia.com/wiki/Learn_to_use_help
:help :help
:help quickref.txt
* Press Ctrl-] to follow the link (jump to the quickref topic).
* After browsing the quickref topic, press Ctrl-T to go back to the previous topic.
* You can also press Ctrl-O to jump to older locations, or Ctrl-I to jump to newer locations.


# map
     COMMANDS                    MODES
:map   :noremap  :unmap     Normal, Visual, Select, Operator-pending
:nmap  :nnoremap :nunmap    Normal
:vmap  :vnoremap :vunmap    Visual and Select
:smap  :snoremap :sunmap    Select
:xmap  :xnoremap :xunmap    Visual
:omap  :onoremap :ounmap    Operator-pending
:map!  :noremap! :unmap!    Insert and Command-line
:imap  :inoremap :iunmap    Insert
:lmap  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
:cmap  :cnoremap :cunmap    Command-line
:tmap  :tnoremap :tunmap    Terminal-Job


    COMMANDS                                  MODES
                                       Normal  Visual+Select  Operator-pending
:map   :noremap   :unmap   :mapclear     yes        yes            yes
:nmap  :nnoremap  :nunmap  :nmapclear    yes         -              -
:vmap  :vnoremap  :vunmap  :vmapclear     -         yes             -
:omap  :onoremap  :ounmap  :omapclear     -          -             yes

# add-hoc reformat
:'<,'>!bash -c 'cat - | while read i b; do printf "\%-30s \%s\n" $i "$b"; done'
