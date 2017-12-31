screen -S MrApsysSide
screen -RS MrApsysSide
screen -ls

detach <C-a> <C-d> 
kill <C-a> <C-k> 


only window: <C-a> Q


#shared session
screen -x -R gm -h 9999

#scroll back
  C-A [
  # vi keybinding
  <ESC>
  # scroll back mode exited


# send remote command
# -S deployment is creen name
# -p0 preselect window 0
# -X stuff "pwd   # executes pwd, the `echo...` part is for the newline caracter
screen -S deployment -p0 -X stuff "pwd`echo -ne '\015'`"

# capture remote buffer
screen -S deployment -p0 -X hardcopy /tmp/hehe


https://unix.stackexchange.com/questions/29140/how-do-you-detach-the-2nd-screen-from-within-another-screen?rq=1
# How do you detach the 2nd screen from within another screen?
ctrl-a a d


# password from already attached session:
ctrl-a :password
<type password twice>

screen -X stuff "\003" # Control-C <C-C>
screen -X stuff "\015" # Control-C <C-a>

vsplit <C-a> |
merge (remove) <C-a> X
list buffer: <C-a> "
change window C-a <number> (only for windows 0



shared
screen -x


start a new screen session with session name 	screen -S <name>
list running sessions/screens 	screen -ls
attach to a running session 	screen -x
… to session with name 	screen -r <name>
the “ultimate attach” 	screen -dRR (Attaches to a screen session. If the session is attached elsewhere, detaches that other display. If no session exists, creates one. If multiple sessions exist, uses the first one.)
detach a running session 	screen -d <name>
Escape key

All screen commands are prefixed by an escape key, by default C-a (that's Control-a, sometimes written ^a). To send a literal C-a to the programs in screen, use C-a a. This is useful when when working with screen within screen. For example C-a a n will move screen to a new window on the screen within screen.
Getting out
detach 	C-a d
detach and logout (quick exit) 	C-a D D
exit screen 	“C-a : quit” or exit all of the programs in screen.
force-exit screen 	C-a C-\ (not recommended)
Help
See help 	C-a ? (lists keybindings)

The man page is the complete reference, but it's very long.
Window Management
create new window 	C-a c
change to last-visited active window 	C-a C-a (commonly used to flip-flop between two windows)
change to window by number 	C-a <number> (only for windows 0 to 9)
change to window by number or name 	C-a ' <number or title>
change to next window in list 	C-a n or C-a <space>
change to previous window in list 	C-a p or C-a <backspace>
see window list 	C-a " (allows you to select a window to change to)
show window bar 	C-a w (if you don't have window bar)
close current window 	Close all applications in the current window (including shell)
kill current window 	C-a k (not recommended)
kill all windows 	C-a \ (not recommended)
rename current window 	C-a A
Split screen
split display horizontally 	C-a S
split display vertically 	C-a | or C-a V (for the vanilla vertical screen patch)
jump to next display region 	C-a tab
remove current region 	C-a X
remove all regions but the current one 	C-a Q
Scripting
send a command to a named session 	screen -S <name> -X <command>
create a new window and run ping example.com 	screen -S <name> -X screen ping example.com
stuff characters into the input buffer
using bash to expand a newline character
(from here) 	

screen -S <name> [-p <page>] -X stuff $'quit\r'

a full example 	

# run bash within screen
screen -AmdS bash_shell bash
# run top within that bash session
screen -S bash_shell -p 0 -X stuff $'top\r'
 
# ... some time later
 
# stuff 'q' to tell top to quit
screen -S bash_shell -X stuff 'q'
# stuff 'exit\n' to exit bash session
screen -S bash_shell -X stuff $'exit\r'

Misc
redraw window 	C-a C-l
enter copy mode 	C-a [ or C-a <esc> (also used for viewing scrollback buffer)
yank    space
paste 	C-a ]
monitor window for activity 	C-a M
monitor window for silence 	C-a _
enter digraph (for producing non-ASCII characters) 	C-a C-v
lock (password protect) display 	C-a x
enter screen command 	C-a :
enable logging in the screen session 	C-a H 
