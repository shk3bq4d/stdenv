
file location: %HOMEDIR%/.vrapperrc
file location: ~/.vrapperrc
# attention pour les accents le charset du fichier doit être le même que celui
# d'éclipse, déterminable dans Help, About Eclipse, Installation details,
# Configuration, search for encoding.
# accessoirement Charset.defaultCharset() devrait donner la même valeur
iconv -f UTF-8 -t CP1252 .vrapperrc >out



set ignorecase
set smartcase
set regexsearch
set hlsearch
set incsearch
set sanecw
#set clipboard=unnamed

:nnoremap ö :
:nnoremap Z Y
:nnoremap zz yy
:nnoremap :q+ :q!
:nnoremap :wq+ :wq!
:nnoremap :w+ :w!
:noremap ° ~
:nnoremap ä "
:nnoremap à `
:noremap ç $
:noremap ' `
:noremap _ ?
:noremap - /

