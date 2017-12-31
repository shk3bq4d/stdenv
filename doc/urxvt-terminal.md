keyboard-select Alt-n
keyboard-search Alt-s
Use Meta-Escape to activate selection mode, then use the following keys:

h/j/k/l:    Move cursor left/down/up/right (also with arrow keys)
g/G/0/^/$/H/M/L/f/F/;/,/w/W/b/B/e/E: More vi-like cursor movement keys
'/'/?:      Start forward/backward search
n/N:        Repeat last search, N: in reverse direction
Ctrl-f/b:   Scroll down/up one screen
Ctrl-d/u:   Scroll down/up half a screen
v/V/Ctrl-v: Toggle normal/linewise/blockwise selection
y/Return:   Copy selection to primary buffer, Return: quit afterwards
Y:          Copy selected lines to primary buffer or cursor line and quit
q/Escape:   Quit keyboard selection mode

back search:
1) <A-s>
2) STRING_TO_SEARCH
3) <Up> or <Down> to cycle through matches
4) Enter twice to exit search


# Printing https://wiki.gentoo.org/wiki/Rxvt-unicode#Printing
By default, rxvt-unicode will print out a screen dump, via lpr, when PrntScrn is pressed. Using Ctrl+PrintScrn or Shift-PrintScrn will include the terminal's scroll back in the printout as well. This behavior can be changed, or disabled entirely, based on personal preference and need.
FILE ~/.Xresources
! The string will be interpreted as if typed into the shell as-is.
! In this example, printing will be disabled altogether.
URxvt.print-pipe: "cat > /dev/null"
