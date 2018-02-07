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

# ~/kanban/2017.05.12-fpeconsole/screens-documentation/start-urxvts.sh
urxvt \
		-xrm "URxvt.print-pipe: $PWD/print-pipe.sh" \
		-xrm "*background: #002b36" \
		-xrm "*foreground: #ffffff" \
        -xrm "*color0: rgb:0/0/0" \
        -xrm "*color1: rgb:cc/00/00" \
        -xrm "*color2: rgb:00/cc/00" \
        -xrm "*color3: yellow" \
        -xrm "*color4: rgb:00/00/cc" \
        -xrm "*color5: rgb:cc/00/cc" \
        -xrm "*color6: rgb:00/cc/cc" \
        -xrm "*color7: rgb:aa/aa/aa" \
        -xrm "*color8: rgb:33/33/33" \
        -xrm "*color9: rgb:ff/00/00" \
        -xrm "*color10: rgb:00/ff/00" \
        -xrm "*color11: rgb:ff/ff/00" \
        -xrm "*color12: rgb:00/00/ff" \
        -xrm "*color13: rgb:ff/00/ff" \
        -xrm "*color14: rgb:00/ff/ff" \
        -xrm "*color15: rgb:ff/ff/ff" \
		-xrm "URxvt.cursorBlink: false" \
		-xrm "URxvt.cursorUnderline: true" \
		-xrm "URxvt.cursorColor: white" \
		-xrm "URxvt.cursorColor2: white" \
		-tn "xterm" \
		-fade 0 \
		-geometry ${cols}x${lines} \
		-title "mrtitlefloating" \
		-e "$f" \
		;

https://wiki.archlinux.org/index.php/rxvt-unicode#Clickable_URLs
