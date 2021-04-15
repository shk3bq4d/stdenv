# /* ex: set filetype=md: */
```sh
[ -a FILE ]    True if FILE exists.
[ -b FILE ]    True if FILE exists and is a block-special file.
[ -c FILE ]    True if FILE exists and is a character-special file.
[ -d FILE ]    True if FILE exists and is a directory.
[ -e FILE ]    True if FILE exists.
[ -f FILE ]    True if FILE exists and is a regular file.
[ -g FILE ]    True if FILE exists and its SGID bit is set.
[ -h FILE ]    True if FILE exists and is a symbolic link.
[ -k FILE ]    True if FILE exists and its sticky bit is set.
[ -p FILE ]    True if FILE exists and is a named pipe (FIFO).
[ -r FILE ]    True if FILE exists and is readable.
[ -s FILE ]    True if FILE exists and has a size greater than zero.
[ -t FD ]    True if file descriptor FD is open and refers to a terminal. tty
    [ -t 0 ] stdin
    [ -t 1 ] stdout
    [ -t 2 ] stderr
[ -u FILE ]    True if FILE exists and its SUID (set user ID) bit is set.
[ -w FILE ]    True if FILE exists and is writable.
[ -x FILE ]    True if FILE exists and is executable.
[ -O FILE ]    True if FILE exists and is owned by the effective user ID.
[ -G FILE ]    True if FILE exists and is owned by the effective group ID.
[ -L FILE ]    True if FILE exists and is a symbolic link.
[ -N FILE ]    True if FILE exists and has been modified since it was last read.
[ -S FILE ]    True if FILE exists and is a socket.
[ FILE1 -nt FILE2 ]    True if FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
[ FILE1 -ot FILE2 ]    True if FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
[ FILE1 -ef FILE2 ]    True if FILE1 and FILE2 refer to the same device and inode numbers.
[ -o OPTIONNAME ]    True if shell option "OPTIONNAME" is enabled.
[ -z STRING ]    True of the length if "STRING" is zero.
[ -n STRING ] or [ STRING ]    True if the length of "STRING" is non-zero.
echo "$( [[ "${ssh_public_key:-}" =~ '\S' ]] && echo "--ssh-public-key" "${ssh_public_key}" || true )" # test non-zero and not blank
[ STRING1 == STRING2 ]     True if the strings are equal. "=" may be used instead of "==" for strict POSIX compliance.
[ STRING1 != STRING2 ]     True if the strings are not equal.
[ STRING1 < STRING2 ]     True if "STRING1" sorts before "STRING2" lexicographically in the current locale.
[ STRING1 > STRING2 ]     True if "STRING1" sorts after "STRING2" lexicographically in the current locale.
[ ARG1 OP ARG2 ]    "OP" is one of -eq, -ne, -lt, -le, -gt or -ge. These arithmetic binary operators return true if "ARG1" is equal to, not equal to, less than, less than or equal to, greater than, or greater than or equal to "ARG2", respectively. "ARG1" and "ARG2" are integers.

nb nombre args argument count
$# # dollar hash, argument count

if [[ "$line" =~ [a-zA-Z]+.$ ]] ; then echo "hello"; fi # regexp. Do not surround with quotes!!

Expressions may be combined using the following operators, listed in decreasing order of precedence:

Table 7-2. Combining expressions
Operation    Effect
[ ! EXPR ]    True if EXPR is false.
[ ( EXPR ) ]    Returns the value of EXPR. This may be used to override the normal precedence of operators.
[ EXPR1 -a EXPR2 ]    True if both EXPR1 and EXPR2 are true.
[ EXPR1 -o EXPR2 ]    True if either EXPR1 or EXPR2 is true.



# relacher une execution
Ctrl-Z
disown

string substitution
foo="  "

# replace first blank only
bar=${foo/ /.} # pseudo-regexp pattern replacement

# replace all blanks
bar=${foo// /.} # pseudo-regexp pattern replacement

for i in a b c ; do echo "coucuo $i"; done # iterate
for i in $(echo "P1D
    PT10H5s
    P5Y11M
    P2M4DT10M5.23S
    "); do

    echo $i
done

#errorlevel return code returncode $?
#somecommand  argument1 argument2
RETVAL=$?
[ $RETVAL -eq 0 ] && echo Success
[ $RETVAL -ne 0 ] && echo Failure

# line number of last error ?
echo $LINENO

# number of args:
$#

see also ${BASH_LINENO[0]}

# shift
while (( "$#" )); do
    echo $1
    shift
done


realpath
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR="$( cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"


cd -P "$( dirname "${BASH_SOURCE[0]}" )"
cd -P "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )"

script name
echo $(basename ${BASH_SOURCE[0]})

if [[ "bip" == "bap" ]]
then
    echo ok
fi
if [[ "bip" == "bap" ]]; then
    echo ok
fi

while :
do
    echo coucou
    sleep 1
done

if find . -maxdepth 0 -name mrbip -mmin +1 >/dev/null 2>&1;
then
    echo found
fi

date +'%Y%m%d'            # 20170728
date +'%H%M%S'            # 104855
date +'%Y.%m.%d_%H.%M.%S' # 2017.07.28_10.49.16
date +'%Y.%m.%d-%H.%M.%S' # 2017.07.28-10.49.16
date -I                   # 2017-07-28
date -Iminutes            # 2017-07-28T10:47+02:00
date -Iseconds            # 2017-07-28T10:47:08+02:00
date -Ihours              # 2017-07-28T10+02:00
printf '%(%Y.%m.%d %H:%M:%S)T' # bash date built in, but not zsh
while :; do printf '%(%Y.%m.%d %H:%M:%S)T '; echo "" | nc -w 1 100.96.10.165 2181 &>/dev/null && echo ok || echo no; sleep 1; done

###sleep until, or script duration
current_epoch=$(date +%s) # duration
target_epoch=$(date -d '01/01/2010 12:00' +%s)
target_epoch=$(date -d 'tomorrow 12:00' +%s)
sleep_seconds=$(( $target_epoch - $current_epoch ))
sleep $sleep_seconds
duration=$(( $(date +%s) - $current_epoch ))
echo "job took $duration seconds"



vi mode cheatsheet
.---------------------------------------------------------------------------.
|                                                                           |
|                          Readline VI Editing Mode                         |
|                     Default Keyboard Shortcuts for Bash                   |
|                               Cheat Sheet                                 |
|                                                                           |
'---------------------------------------------------------------------------'
| Peteris Krumins (peter@catonmat.net), 2008.01.08                          |
| http://www.catonmat.net  -  good coders code, great reuse                 |
|                                                                           |
| Released under the GNU Free Document License                              |
'---------------------------------------------------------------------------'

 ======================== Keyboard Shortcut Summary ========================

.--------------.------------------------------------------------------------.
|              |                                                            |
| Shortcut     | Description                                                |
|              |                                                            |
'--------------'------------------------------------------------------------'
| Switching to COMMAND Mode:                                                |
'--------------.------------------------------------------------------------'
| ESC          | Switch to command mode.                                    |
'--------------'------------------------------------------------------------'
| Commands for Entering INPUT Mode:                                         |
'--------------.------------------------------------------------------------'
| i            | Insert before cursor.                                      |
'--------------+------------------------------------------------------------'
| a            | Insert after cursor.                                       |
'--------------+------------------------------------------------------------'
| I            | Insert at the beginning of line.                           |
'--------------+------------------------------------------------------------'
| A            | Insert at the end of line.                                 |
'--------------+------------------------------------------------------------'
| c<mov. comm> | Change text of a movement command <mov. comm> (see below). |
'--------------+------------------------------------------------------------'
| C            | Change text to the end of line (equivalent to c$).         |
'--------------+------------------------------------------------------------'
| cc or S      | Change current line (equivalent to 0c$).                   |
'--------------+------------------------------------------------------------'
| s            | Delete a single character under the cursor and enter input |
|              | mode (equivalent to c[SPACE]).                             |
'--------------+------------------------------------------------------------'
| r            | Replaces a single character under the cursor (without      |
|              | leaving command mode).                                     |
'--------------+------------------------------------------------------------'
| R            | Replaces characters under cursor.                          |
'--------------+------------------------------------------------------------'
| v            | Edit (and execute) the current command in the text editor. |
|              | (an editor defined in $VISUAL or $EDITOR variables, or vi  |
'--------------'------------------------------------------------------------'
| Basic Movement Commands (in command mode):                                |
'--------------.------------------------------------------------------------'
| h            | Move one character right.                                  |
'--------------+------------------------------------------------------------'
| l            | Move one character left.                                   |
'--------------+------------------------------------------------------------'
| w            | Move one word or token right.                              |
'--------------+------------------------------------------------------------'
| b            | Move one word or token left.                               |
'--------------+------------------------------------------------------------'
| W            | Move one non-blank word right.                             |
'--------------+------------------------------------------------------------'
| B            | Move one non-blank word left.                              |
'--------------+------------------------------------------------------------'
| e            | Move to the end of the current word.                       |
'--------------+------------------------------------------------------------'
| E            | Move to the end of the current non-blank word.             |
'--------------+------------------------------------------------------------'
| 0            | Move to the beginning of line                              |
'--------------+------------------------------------------------------------'
| ^            | Move to the first non-blank character of line.             |
'--------------+------------------------------------------------------------'
| $            | Move to the end of line.                                   |
'--------------+------------------------------------------------------------'
| %            | Move to the corresponding opening/closing bracket.         |
'--------------'------------------------------------------------------------'
| Character Finding Commands (these are also Movement Commands):            |
'--------------.------------------------------------------------------------'
| fc           | Move right to the next occurance of char c.                |
'--------------+------------------------------------------------------------'
| Fc           | Move left to the previous occurance of c.                  |
'--------------+------------------------------------------------------------'
| tc           | Move right to the next occurance of c, then one char       |
|              | backward.                                                  |
'--------------+------------------------------------------------------------'
| Tc           | Move left to the previous occurance of c, then one char    |
|              | forward.                                                   |
'--------------+------------------------------------------------------------'
| ;            | Redo the last character finding command.                   |
'--------------+------------------------------------------------------------'
| ,            | Redo the last character finding command in opposite        |
|              | direction.                                                 |
'--------------+------------------------------------------------------------'
| |            | Move to the n-th column (you may specify the argument n by |
|              | typing it on number keys, for example, 20|)                |
'--------------'------------------------------------------------------------'
| Deletion Commands:                                                        |
'--------------.------------------------------------------------------------'
| x            | Delete a single character under the cursor.                |
'--------------+------------------------------------------------------------'
| X            | Delete a character before the cursor.                      |
'--------------+------------------------------------------------------------'
| d<mov. comm> | Delete text of a movement command <mov. comm> (see above). |
'--------------+------------------------------------------------------------'
| D            | Delete to the end of the line (equivalent to d$).          |
'--------------+------------------------------------------------------------'
| dd           | Delete current line (equivalent to 0d$).                   |
'--------------+------------------------------------------------------------'
| CTRL-w       | Delete the previous word.                                  |
'--------------+------------------------------------------------------------'
| CTRL-u       | Delete from the cursor to the beginning of line.           |
'--------------'------------------------------------------------------------'
| Undo, Redo and Copy/Paste Commands:                                       |
'--------------.------------------------------------------------------------'
| u            | Undo previous text modification.                           |
'--------------+------------------------------------------------------------'
| U            | Undo all previous text modifications.                      |
'--------------+------------------------------------------------------------'
| .            | Redo the last text modification.                           |
'--------------+------------------------------------------------------------'
| y<mov. comm> | Yank a movement into buffer (copy).                        |
'--------------+------------------------------------------------------------'
| yy           | Yank the whole line.                                       |
'--------------+------------------------------------------------------------'
| p            | Insert the yanked text at the cursor.                      |
'--------------+------------------------------------------------------------'
| P            | Insert the yanked text before the cursor.                  |
'--------------'------------------------------------------------------------'
| Commands for Command History:                                             |
'--------------.------------------------------------------------------------'
| k            | Insert the yanked text before the cursor.                  |
'--------------+------------------------------------------------------------'
| j            | Insert the yanked text before the cursor.                  |
'--------------+------------------------------------------------------------'
| G            | Insert the yanked text before the cursor.                  |
'--------------+------------------------------------------------------------'
| /string or   | Search history backward for a command matching string.     |
| CTRL-r       |                                                            |
'--------------+------------------------------------------------------------'
| ?string or   | Search history forward for a command matching string.      |
| CTRL-s       | (Note that on most machines Ctrl-s STOPS the terminal      |
|              | output, change it with `stty' (Ctrl-q to resume)).         |
'--------------+------------------------------------------------------------'
| n            | Repeat search in the same direction as previous.           |
'--------------+------------------------------------------------------------'
| N            | Repeat search in the opposite direction as previous.       |
'--------------'------------------------------------------------------------'
| Completion commands:                                                      |
'--------------.------------------------------------------------------------'
| TAB or = or  | List all possible completions.                             |
| CTRL-i       |                                                            |
'--------------+------------------------------------------------------------'
| *            | Insert all possible completions.                           |
'--------------'------------------------------------------------------------'
| Miscellaneous commands:                                                   |
'--------------.------------------------------------------------------------'
| ~            | Invert case of the character under cursor and move a       |
|              | character right.                                           |
'--------------+------------------------------------------------------------'
| #            | Prepend '#' (comment character) to the line and send it to |
|              | the history.                                               |
'--------------+------------------------------------------------------------'
| _            | Inserts the n-th word of the previous command in the       |
|              | current line.                                              |
'--------------+------------------------------------------------------------'
| 0, 1, 2, ... | Sets the numeric argument.                                 |
'--------------+------------------------------------------------------------'
| CTRL-v       | Insert a character literally (quoted insert).              |
'--------------+------------------------------------------------------------'
| CTRL-r       | Transpose (exchange) two characters.                       |
'--------------'------------------------------------------------------------'


 ===========================================================================

.---------------------------------------------------------------------------.
| Peteris Krumins (peter@catonmat.net), 2008.01.08.                         |
| http://www.catonmat.net  -  good coders code, great reuse                 |
|                                                                           |
| Released under the GNU Free Document License                              |
'---------------------------------------------------------------------------'


flock inside script
#!/bin/bash
(    # Wait for lock on /var/lock/.myscript.exclusivelock (fd 200) for 10 seconds
    if ! flock -x -n 200; then exit
    # Do stuff

) 200>/var/lock/$(basename ${BASH_SOURCE[0]}).lock

flock in crontab
* * * * * root flock -x -n /var/lock/sync_ly200_extracted.sh.lock -c /home/pi/bin/sync_ly200_extracted.sh >/tmp/sync_ly200_extracted.sh.log

flock out of mkdir

flock with trap
#!/bin/bash
## Copyright (C) 2009  Przemyslaw Pawelczyk <przemoc@gmail.com>
## License: GNU General Public License v2, v3
#
# Lockable script boilerplate

### HEADER ###
LOCKFILE="/var/lock/`basename $0`"
LOCKFD=99

# PRIVATE
_lock()             { flock -$1 $LOCKFD; }
_no_more_locking()  { _lock u; _lock xn && rm -f $LOCKFILE; }
_prepare_locking()  { eval "exec $LOCKFD>\"$LOCKFILE\""; trap _no_more_locking EXIT; }

# ON START
_prepare_locking

# PUBLIC
exlock_now()        { _lock xn; }  # obtain an exclusive lock immediately or fail
exlock()            { _lock x; }   # obtain an exclusive lock
shlock()            { _lock s; }   # obtain a shared lock
unlock()            { _lock u; }   # drop a lock

### BEGIN OF SCRIPT ###

# Simplest example is avoiding running multiple instances of script.
! exlock_now && echo "FATAL: apparent concurrent run, please check $LOCKFILE" && exit 1
. ~/bin/dot.lockfunctions; exlock_now || exit 1

# Remember! Lock file is removed when one of the scripts exits and it is
#           the only script holding the lock or lock is not acquired at all.



mrecho() { echo "$(date +'%Y.%m.%d %H:%M:%S') $@"; }

printf "%s %4s %3d %3d\n" $dowh "${dom}${th}" $((-i+$a)) $((-i))


#substring
b=${variablename:startindex:length}#                    substring
v=abcdefghijk; echo ${v:-2}        # => abcdefghijk     substring
v=abcdefghijk; echo ${v:-1}        # => abcdefghijk     substring
v=abcdefghijk; echo ${v:0}         # => abcdefghijk     substring
v=abcdefghijk; echo ${v:1}         # =>  bcdefghijk     substring
v=abcdefghijk; echo ${v:2}         # =>   cdefghijk     substring
v=abcdefghijk; echo ${v:0:1}       # => a               substring
v=abcdefghijk; echo ${v:0:2}       # => ab              substring
v=abcdefghijk; echo ${v:1:0}       # =>                 substring
v=abcdefghijk; echo ${v:1:1}       # => b               substring
v=abcdefghijk; echo ${v:2:1}       # => c               substring
v=abcdefghijk; echo ${v:1:2}       # => bc              substring
v=abcdefghijk; echo ${v:0:${#v}-1} # => abcdefghij      substring
v=abcdefghijk; echo ${v:0:${#v}-2} # => abcdefghi       substring
v=abcdefghijk; echo ${v:${#v}-1:1} # => k               substring
v=abcdefghijk; echo ${v:${#v}-2:1} # => j               substring
v=abcdefghijk; echo ${v:${#v}-2:2} # => jk              substring

v=abracadabra; echo ${v#*_}
b=${tmp%_*}

Substring Removal

${string#substring}  #Deletes shortest match of $substring from front of $string.
${string##substring} #Deletes longest match of $substring from front of $string.

stringZ=abcABC123ABCabc
#       |----|          shortest
#       |----------|    longest

echo ${stringZ#a*C}      # 123ABCabc
# Strip out shortest match between 'a' and 'C'.

echo ${stringZ##a*C}     # abc
# Strip out longest match between 'a' and 'C'.

# You can parameterize the substrings.
X='a*C'
echo ${stringZ#$X}      # 123ABCabc
echo ${stringZ##$X}     # abc
                        # As above.

${string%substring} # Deletes shortest match of $substring from back of $string.
For example:
# Rename all filenames in $PWD with "TXT" suffix to a "txt" suffix.
# For example, "file1.TXT" becomes "file1.txt" . . .

SUFF=TXT
suff=txt

for i in $(ls *.$SUFF)
    do
      mv -f $i ${i%.$SUFF}.$suff
        #  Leave unchanged everything *except* the shortest pattern match
        #+ starting from the right-hand-side of the variable $i . . .
      done ### This could be condensed into a "one-liner" if desired.

${string%%substring} # Deletes longest match of $substring from back of $string.

      stringZ=abcABC123ABCabc
#                    ||     shortest
#        |------------|     longest

      echo ${stringZ%b*c}      # abcABC123ABCa
# Strip out shortest match between 'b' and 'c', from back of $stringZ.

      echo ${stringZ%%b*c}     # a
# Strip out longest match between 'b' and 'c', from back of $stringZ.



sprintf
var=$(printf 'FILE=_%s_%s.dat' hehe hoho)


# get file extension
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"

case $space in
[1-6]*)
  Message="All is quiet."
  ;;
[7-8]*)
  Message="Start thinking about cleaning out some stuff.  There's a partition that is $space % full."
  ;;
9[1-8])
  Message="Better hurry with that new disk...  One partition is $space % full."
  ;;
99)
  Message="I'm drowning here!  There's a partition at $space %!"
  ;;
*)
  Message="I seem to be running with an nonexistent amount of disk space..."
  ;;
esac

# convertir charset encoding UTF8 windows
iconv -f UTF-8 -t CP1252 .vrapperrc >out

# resursive file list sorted by date
find . -type f -printf '%TY-%Tm-%Td %TH:%TM:%TS %p\n'|sort

# path unix to windows
echo ${bip//\//\\}

# path windows to double back slash
echo ${haha//\\/\\\\}


${varname^^} # uppercase
${varname,,} # lowercase
echo $VAR_NAME | tr '[:upper:]' '[:lower:]'  # lowercase
echo $VAR_NAME | tr '[:lower:]' '[:upper:]'  # uppercase

grep -Po "(?<=syntaxHighlighterConfig\.)[a-zA-Z]+Color" file # look-beind zero width assertion regexp
(?=X)    X, via zero-width positive lookahead  regexp
(?!X)    X, via zero-width negative lookahead  regexp
(?<=X)    X, via zero-width positive lookbehind regexp
(?<!X)    X, via zero-width negative lookbehind regexp

^((?!my string).)*$ # regexp not containt substring 'my string'

suivi de job:
echo "$(date) Debut du job"
trap '[ -z $! ] || kill $!' SIGHUP SIGINT SIGQUIT SIGTERM
$MAIN &
while [ -e /proc/$! ]; do
    sleep 5  # Optional: slow the loop so we don't use up all the dots.
    echo "$(date) $(find $OUT -maxdepth 1 -type f | wc -l)"
done
echo "$(date) Fin du job. Il y a $(find $OUT -maxdepth 1 -type f | wc -l ) fichiers dans le repertoire"


# redirect whole script
exec > >(tee logfile.txt)
exec 2>&1

# redirect whole script to syslog
exec > >(tee >(logger  -i     -t "$(basename $0)" -p user.info )) # linux or freebsd, see next line
exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info )) # linux as it sends ppid which is more robust
exec > >(tee >(logger --id=$$ -t "$(basename $0)" -p user.info )) # linux as it sends ppid which is more robust
exec 2>&1
exec 1> >(logger -s -t "$(basename "$0")") 2>&1

# play with filedescriptor
exec 4>/tmp/out4 # redirect fd4 to file
exec 4>>/tmp/out4 # redirect fd4 to file in append
exec 4> >(tee -a /tmp/out4) # same as before but prevent truncating of file when, for example, used with curl -D /dev/fd/4, please note that the "exec 4> >(tee -a /tmp/out4)" statement needs to be reinitiated as the tee command completes and the FD gets closed
date >&4 # append to fd4
date >>&4 #illegal
date >/dev/fd/4 # append to FD4 (even though there is a single >)
date >>/dev/fd/4 # append to FD4


# hash key value hashtable hashmap
declare -A array
array[foo]=bar
array[bar]=foo
for i in "${!array[@]}" # iterate over an array
do
    echo "key  : $i"
    echo "value: ${array[$i]}"
done
${#array[@]} # array  length
${#var}      # string length

#iterage over args arguments parameters
for var in "$@" # iterate
do
    echo "$var"
done

# shift arguments parameters args
shift # push pop arguments

#autocomplete save the following script in /etc/bash_completion.d/
_script()
{
  _script_commands=$(ssh charlotte jail_list.sh) # name of command that returns the args

  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${_script_commands}" -- ${cur}) )

  return 0
}
complete -o nospace -F _script jail_console.sh # jail_console.sh is name of program targeted for auto-complete

# extract slice of arguments
# from what I can see
echo "${@:1:1}" extract the first args
echo "${@:1:2}" extract the first two args
echo "${@:2:1}" extract the second arg
echo "${@:2:2}" extract the args 2 and 3
echo "${@:3}"   extract all starting from 3



# if not running in terminal, strip ansi colors
if [[ ! -t 1 ]]; then exec > >(sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"); fi

#case insensitive string comparison
shopt -s nocaseglob


# How to detect if my shell script is running through a pipe?
if [ -t 1 ] ; then echo terminal; fi
# returns "terminal", because the output is going straight to you, while
(if [ -t 1 ] ; then echo terminal; fi) | cat
#returns nothing, because the output is going to cat.
#0:     stdin
#1:     stdout
#2:     stderr


BASHPID
  Expands to the process ID of the current bash process.
  This differs from $$ under certain circumstances, such
  as subshells that do not require bash to be re-
  initialized.
BASH_SUBSHELL
  Incremented by one each time a subshell or subshell
  environment is spawned.  The initial value is 0.

$$ # dollar PID of bash process (possibly grand parent if subshell)
$! # dollar exclamation mark PID of last started process example:
PID warning use cygwin_pid_to_win_pid.sh to resolve to windows pid or use with tail -f --pid= # ps -W | sed -n -r -e "s/^\\s*$1\\s+[0-9]+\\s+[0-9]+\\s+([0-9]+).*/\\1/ p"
some_program &
some_pid=$!
wait $some_pid

# last command
!!     # exclamation mark: last command
!$     # exclamation mark dollar: last word of last command
!#:3   # exclamation mark hash: third word of last command as in curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 !#:3

# deactivate history
 unset HISTFILE
alias exit='echo exit disabled, use 10 times ^D to exit'
export IGNOREEOF=10


set -e # stop after first errors
set -x # print command (useful in debugging scripts)
set -u # crash if unbound variables => use [[ -n ${VAR+1} ]] to check for existence
set -o pipefail # crash if programs in between pipes fail

set -o noclobber

echo $RANDOM
# random value between 1 and 10 inclusive
$(( ( RANDOM % 10 )  + 1 ))


cat << HERE_DOCUMENT
do not forget the space between the << and the HERE_DOCUMENT identifier
because HERE_DOCUMENT is unquoted $(echo this-will-be-evaluated)
HERE_DOCUMENT

cat << 'HERE_DOCUMENT'
because HERE_DOCUMENT is quoted $(echo this-will-not-be-evaluated)
HERE_DOCUMENT

cat << HERE_DOCUMENT >with_redirect
do not forget the space between the << and the HERE_DOCUMENT identifier
HERE_DOCUMENT


echo {A,B,C}
echo {A..Z}

Bang commands

Bash supports C-shell command and argument reuse capabilities ( bang commands). For example, if you know exact prefix for the command that you executed recently you can reuse it without manually browsing history by typing ! followed by the first few letters of the command. Among other possibilities of retrieving commands from history provided by bang commands:

$ !n --Will execute the line n of the history record.
$ !-n --Will execute the command n lines back.
$ !! --Will execute the last command. Same as !-1 or "up-arrow + return"
!gzip  -- will re-execute the most recent gzip command (history is searched  in reverse order). string specified is considered to be prefix of the necessary command.
!?etc.gz – same as above but the unique string doesn't have to be at the start of the command. That means that you can identify command by a unique string appearing anywhere in the command  (exactly like in Ctrl-R  mechanism)
What is more important and convenient is that you can extract arguments from previous commands  (see below). for example:
!!:1 designates the first argument of the last command.  This can be shortened to !1.
!!:$ designates the last argument of the preceding command. This may be shortened to !$.
 There are a couple of useful idioms:

sudo !! -- reexecute the last command withprefix sudo.
cd !$ -- cd to the directory which is the last argument of the previous command. This idiom is based on the ability to specify the last argument of the prev command. !!:$  designates the last word of the preceding command. This can be shortened to !$.  The addressing reminds vi and as in vi you can work with any command in history, not only the last. See below
Modification of the cd command when two long(deeply nested) directories differ in only one part, especially if this part is somewhere in the middle. You can modify the command on the fly using search-and-replace type modifier  s/old/new/ (or s^old^new^ -- the delimiter is actually arbitrary)
use :p suffix with the ! for repeating a command will cause the command to be displayed, but not run( See modifiers for more info)  Useful if you want to repeat a command, but want to double check the command you want to run. For example if it perform some action on system files or directories. In the example below !string  runs the most recent command beginning with the string you specify.  Using Ctrl-R might be a better deal
!tail:p
Bang arguments
Retrieving previous command arguments

You can also paste part of the previous commands arguments using so called word designators or bang arguments.  A colon (:) separates the event designator and the word designator. If the word designator begins with $, %, ^, *, or - the : is not needed. If you want the word to be selected from the previous command line, the second ! is not required. For example, !!:2 and !:2 both refer to the second word on the previous command.

You can address the necessary argument by using words, lines count from the last and search strings

Words. Words are zero relative, that is, word zero is the command itself. The first argument (arg1) on the command line is word 1.
!:0  is the previous command name
!^, !:2, !:3, …, !$  are the arguments of the previous command
!*  is all the arguments
!$ is the last argument. You can also use $_ to get the last argument of the previous command.
Lines in history:  Default is the last command. previous command can be addressed as !-1, command before it as !-2 and so on. For example:
!-2, !-3, … are earlier commands and arguments can be extracted from earlier commands too
!-2^, !-2:2, !-2$, !-2*
Search strings, that locate the line from which to extract arguments:
You can reference the last commands not only by absolute of relative positions in history but also by a search string. For example, !find:5  displays the fifth word from the last command beginning with !find, while !find:$  would display the last word from the same command. Please note that !find:*  is same as !find:1-$  - both resulting in the complete command except for the first word.  You type new command with the same arguments that way.  For example
!cd:2
ls -l !cd:2
You can also use !cd:$ as this is the last argument.

Here is more a compete reference:

The word designators are:
0 -- the zero’th word (command name)
n  -- word n
ˆ -- the first argument, i.e., word one (usually first argument of the command --NNB)
$ -- the last argument
% -- the word matched by the most recent
!? str ?  --search of str
x-y -- words x through y . −y is short for 0−y
* words 1 through the last (like 1−$ ) (all arguments -- NNB)
n* words n through the last (like n−$ )
The two important modifiers are:
h remove the part of a filename after last "/", leaving the path
t remove all but the part of the filename after the last slash. for example for "/etc/resolv.conf" it will be resolv.conf
Other modifies (just for reference) include:
r remove the last suffix of a filename (extension of the file). For example /etc/resolv
e remove all but the last suffix of a filename (extension)
g make changes globally, use with s modifier, below
p print the command but do not execute it
q quote the generated text
s/old/new/ substitute new for old in the text. Any delimiter may be used. An & in the argument means the value of old. With empty old , use last old , or the most recent !? str ? search if there was no previous old
x quote the generated text, but break into words at blanks and newline
& repeat the last substitution
Searching history

There are two ways to three ways of searching history of commands: linear, incremental and with grep.


# echo to stderr
>&2 echo "error"
echo This message goes to stderr >&2
{ echo "This message goes to stderr" >&2; echo "This one to stdout"; }

set -u # equivalent to "set -o nounset" will die if using unitiliazed variable

# which alternatives
command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; } # which
type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; } # which
hash foo 2>/dev/null || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; } # which
Where bash is your shell/hashbang, consistently use hash (for commands) or type (to consider built-ins & keywords).
When writing a POSIX script, use command -v.

# http://unix.stackexchange.com/questions/39291/run-a-command-that-is-shadowed-by-an-alias # execute
- You can also prefix a back slash to disable the alias: \ls
- Use "command": command ls
- Use the full path: /bin/ls
- Quote the command: "ls" or 'ls'
- remove the alias temporarily for that terminal session with unalias command_name.

https://github.com/nojhan/liquidprompt
http://www.tldp.org/LDP/abs/html/internalvariables.html


ssh user@machine-where-precious-data-is "tar czpf - /some/important/data" | pv |  tar xzpf - -C /new/root/directory # pv monitor speed in pipes

xxd # hex dump
od  # hex dump


cut -f2 -d$'\t' infile # inline tab character tabulation raw
cut -f2 -d$'\n' infile # inline character newline new line raw

ctrl+s # suspends terminal (not bash specific but not sure where to add)
ctrl+q # resumes terminal after suspension (not bash specific but not sure where to add)

if bip; then
elif hehe; then
fi


@begin=sh@
if [[ -t 1 ]]; then
    local NONE="\033[0m"    # unsets color to term's fg color
    local BOLD="\033[1m"
    local OFF="\033[m"
else
    local NONE=""    # unsets color to term's fg color
    local BOLD=""
    local OFF=""
fi
@end=sh@

# colors
@begin=sh@
if [[ -t 1 ]]; then
    local BLACK="\033[0;30m"    # black
    local RED="\033[0;31m"    # red
    local GREEN="\033[0;32m"    # green
    local YELLOW="\033[0;33m"    # yellow
    local BLUE="\033[0;34m"    # blue
    local MAGENTA="\033[0;35m"    # magenta
    local CYAN="\033[0;36m"    # cyan
    local WHITE="\033[0;37m"    # white
else
    local BLACK=""    # black
    local RED=""    # red
    local GREEN=""    # green
    local YELLOW=""    # yellow
    local BLUE=""    # blue
    local MAGENTA=""    # magenta
    local CYAN=""    # cyan
    local WHITE=""    # white
else
@end=sh@

# emphasized (bolded) colors
@begin=sh@
if [[ -t 1 ]]; then
    local EMBLACK="\033[1;30m"
    local EMRED="\033[1;31m"
    local EMGREEN="\033[1;32m"
    local EMYELLOW="\033[1;33m"
    local EMBLUE="\033[1;34m"
    local EMMAGENTA="\033[1;35m"
    local EMCYAN="\033[1;36m"
    local EMWHITE="\033[1;37m"
else
    local EMBLACK=""
    local EMRED=""
    local EMGREEN=""
    local EMYELLOW=""
    local EMBLUE=""
    local EMMAGENTA=""
    local EMCYAN=""
    local EMWHITE=""
fi
@end=sh@

# background colors
@begin=sh@
if [[ -t 1 ]]; then
    local BGBLACK="\033[40m"
    local BGRED="\033[41m"
    local BGGREEN="\033[42m"
    local BGYELLOW="\033[43m"
    local BGBLUE="\033[44m"
    local BGMAGENTA="\033[45m"
    local BGCYAN="\033[46m"
    local BGWHITE="\033[47m"
fi
@end=sh@

shuf # shuffle randomize
sort -R # pseudo-shuffle/randomize,  sort according to hash value



# http://stackoverflow.com/questions/1167746/how-to-assign-a-heredoc-value-to-a-variable-in-bash
read -r -d '' VAR <<'EOF'
abc'asdf"
$(dont-execute-this)
foo"bar"''
EOF

echo \
'multiline
echo'

cat - << EOF > /tmp/hehe
heredocument multiline cat
super
EOF


export http_proxy=http://mitmproxy.$USER.local:8080; export https_proxy=$http_proxy

# https://unix.stackexchange.com/questions/159010/how-can-i-see-the-exact-command-line-being-executed-inside-some-bash-instance?noredirect=1&lq=1
$ gdb --pid 8909
(gdb) call write_history("/tmp/foo")
$1 = 0
(gdb) detach
(gdb) q
cat /tmp/too


VAR1="${VAR1:-default value}" # default value if variable doesn't exist


# test is a number
re='^[0-9]+$'
if ! [[ $yournumber =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

_tempdir=$(mktemp -d); function cleanup() { [[ -n "${_tempdir:-}" && -d "$_tempdir" ]] && rm -rf $_tempdir || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
_tempfile=$(mktemp); function cleanup() { [[ -n "${_tempfile:-}" && -f "$_tempfile" ]] && rm -f $_tempfile || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
_tempfiles=();function my_mktemp() {local f;f="$(mktemp)";$_tempfiles+=($f);echo "$f";};myfile=$(my_mktemp); function cleanup() { local f;for f in "${!_tempfiles[@]}"; do [[ -n "${f:-}" && -f "$f" ]] && rm -f $f || true; }; trap 'cleanup' SIGHUP SIGINT SIGQUIT SIGTERM
true
cleanup
exit 0

#!/usr/bin/env bash
# ex: set filetype=sh :
##
##Usage:  __SCRIPT__ REMOTEHOST [REMOTEPORT]
##configures whatever action with whatever config
##    REMOTEHOST: remote host where to ssh
##    REMOTEPORT: JMX port (default: 12345)
## Author: Donald Duck, 2017 Jun 24th
##
set -euo pipefail
function usage() { sed -r -n -e "s/__SCRIPT__/$(basename $0)/" -e '/^##/s/^..// p'   $0 ; }
[[ $# -eq 1 && ( "$1" == -h || "$1" == --help ) ]] && usage && exit 0
[[ $# -lt 1 || $# -gt 2 ]] && echo "FATAL: incorrect number of args" && usage && exit 1
for i in sed which grep; do ! command -v "$i" && echo "FATAL: unexisting dependency $i" && exit 1; done
REMOTEHOST=$1
REMOTEPORT=${2:-12345}
echo EOF
exit 1

@begin=sh@
#!/usr/bin/env bash
# debug script
L=/tmp/$(basename $0 .sh).log
echo "$(date) - $(whoami) - $0 $@" | tee -a $L
chmod a+w $L
@end=sh@

find . -type f -mtime -30 -exec du -ch {} + | grep total$ #  if more than one total need to be added https://unix.stackexchange.com/questions/41550/find-the-total-size-of-certain-files-within-a-directory-branch

ARRAY=() # creates an empty array
ARRAY+=('foo') # append to an array
ARRAY+=('bar')


# tunnel
mkfifo /tmp/myfifo
while :; do nc -l -4 25 < /tmp/myfifo | tee -a /tmp/traffic | nc mail.bop.com 25 | tee -a /tmp/traffic > /tmp/myfifo; done
while sleep 10; do true; done

die() {
  local frame=0
  while caller $frame; do
    ((frame++));
  done
  echo "$*"
  exit 1
}

trace_calls() {
    caller 0 >> /tmp/trace_function.log
}


#!/bin/bash
#### getopts example
#### There are three implementations that may be considered:
#### Bash builtin getopts. This does not support long option names with the double-dash prefix. It only supports single-character options.
#### BSD UNIX implementation of standalone getopt command (which is what MacOS uses). This does not support long options either.
#### GNU implementation of standalone getopt. GNU getopt(3) (used by the command-line getopt(1) on Linux) supports parsing long options.
#### The basic syntax of getopts is (see: man bash):
####   getopts OPTSTRING VARNAME [ARGS...]
#### where:
#### OPTSTRING is string with list of expected arguments,
####   h - check for option -h without parameters; gives error on unsupported options;
####   h: - check for option -h with parameter; gives errors on unsupported options;
####   abc - check for options -a, -b, -c; gives errors on unsupported options;
####   :abc - check for options -a, -b, -c; silences errors on unsupported options;
####      Notes: In other words, colon in front of options allows you handle the errors in your code. Variable will contain ? in the case of unsupported option, : in the case of missing value.
#### OPTARG - is set to current argument value,
#### OPTERR - indicates if Bash should display error messages.
usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; }
# while getopts ":s:p:" o "-s" 45 "-s" "salut les cocos"; do
while getopts ":s:p:h" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            ! ((s == 45 || s == 90)) && usage && exit 1
            ;;
        p)
            p=${OPTARG}
            ;;
        h)
            usage
            exit 0
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1)) || true
if [ -z "${s:-}" ] || [ -z "${p:-}" ]; then
    usage
    exit 1
fi
echo "s = ${s}"
echo "p = ${p}"
echo "rest = $@"

echo 'scale =  3; 10829 / 1560'  | bc

http://repo.or.cz/w/retty.git Terminal attaching without screen


set -m  # Monitor mode.  Job control is enabled.  This option is on by default for interactive shells on systems that support it (see JOB CONTROL above). https://stackoverflow.com/questions/690266/why-cant-i-use-job-control-in-a-bash-script


command 2>&1 >/dev/null # invert stdin and stderr https://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout

: # To avoid this you can use the no-op :, which evaluates its argument and then throws it away, rather than executing it.  https://stackoverflow.com/questions/7444504/explanation-of-colon-operator-in-foo-value


cat << 'QUOTEDHEREDOCUMENT' | kubectl create -f -
hehe
QUOTEDHEREDOCUMENT

| awk '{ print strftime("%Y-%m-%d %H:%M:%S"), $0; fflush(); }' # https://stackoverflow.com/questions/21564/is-there-a-unix-utility-to-prepend-timestamps-to-stdin
ts # https://stackoverflow.com/questions/21564/is-there-a-unix-utility-to-prepend-timestamps-to-stdin datestamp tail follow tail -f

```sh
# connect from local to remote host
random_local_port() {
    python -c 'import socket; s = socket.socket(); s.bind(("127.0.0.1", 0)); print s.getsockname()[1]; s.close();'
}
PROD_HOST=hehe.burp.com
LOCAL_PORT="$(random_local_port)"
REMOTE_PORT=8000
ssh -f \
    -o ExitOnForwardFailure=yes \
    -L "127.0.0.1:$LOCAL_PORT:127.0.0.1:$REMOTE_PORT" \
    $PROD_HOST \
    sleep 10
nc 127.0.0.1 $LOCAL_PORT &
NC_PID=$!
sleep 20
curl http://127.0.0.1:$LOCAL_PORT
kill -9 $NC_PID
```

# comments in multiline piped
# https://stackoverflow.com/questions/1455988/commenting-in-a-bash-script
# https://stackoverflow.com/questions/9522631/how-to-put-a-line-comment-for-a-multi-line-command?noredirect=1&lq=1
```sh
tr "\n" "," | \
# I hate phone numbers in my output
sed -e 's/,\([0-9]*-[0-9]*-[0-9]*\)/\n\1/g' -e 's/,$//' | \
# one more sed call and then send it to the CSV file
sed -e 's/^/"/g' -e 's/$/"/g' -e 's/,/","/g' >> ${CSV}

# OR
echo abc        | # Normal comment OK here
     tr a-z A-Z | # Another normal comment OK here
     sort       | # The pipelines are automatically continued
     uniq         # Final comment
# it's rather good since multiple, intermediate commented out lines seems possible
# such as in the following example
echo abc        | # Normal comment OK here
     #tr a-z A-Z | # Another normal comment OK here
     #sort       | # The pipelines are automatically continued
     uniq         # Final comment

```
#  while subshell avoidance by using process substitution https://stackoverflow.com/questions/13726764/while-loop-subshell-dilemma-in-bash
```sh
var=0
while read i;
do
  # perform computations on $i
  ((var++))
done < <(find . -type f -name "*.bin" -maxdepth 1)
```

[[ $_ != $0 ]] && echo "Script is being sourced" || echo "Script is a subshell" # bash and ksh compatible
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && echo "script ${BASH_SOURCE[0]} is being sourced ..." # bash only
([[ -n $ZSH_EVAL_CONTEXT && $ZSH_EVAL_CONTEXT =~ :file$ ]] || [[ -n $KSH_VERSION && $(cd "$(dirname -- "$0")" && printf '%s' "${PWD%/}/")$(basename -- "$0") != "${.sh.file}" ]] || [[ -n $BASH_VERSION ]] && (return 0 2>/dev/null)) && sourced=1 || sourced=0 # zsh, bash, ksh. For ZSH, must be called outside a function https://stackoverflow.com/a/28776166
[[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && sourced=1 || sourced=0 # must be called outside a function https://stackoverflow.com/a/28776166


echo -n "Are you sure you want to proceed (yN): " # read
read _read
echo # read
case "${_read,,}" in \
y|yes) true ;; # read
*)   echo "ABORTING"; exit 1;; # read
esac # read

echo -e "\e[1mbold\e[0m" # ansi escape color
echo -e "\e[3mitalic\e[0m" # ansi escape color
echo -e "\e[4munderline\e[0m" # ansi escape color
echo -e "\e[9mstrikethrough\e[0m" # ansi escape color
echo -e "\e[31mHello World\e[0m" # ansi escape color
echo -e "\x1B[31mHello World\e[0m" # ansi escape color

# https://linuxconfig.org/how-to-backup-and-restore-permissions-for-entire-directory-on-linux
getfacl -nR /data/ > ~/getfacl.txt
setfacl --restore=~/getfacl.txt

# prepend each arg https://stackoverflow.com/questions/44745046/bash-pass-all-arguments-exactly-as-they-are-to-a-function-and-prepend-a-flag-on
```sh
myfunc() {
   echo "myfunc I was given $# args"
}
ARRAY=()
for var in "$@"; do
    ARRAY+=('--var' "$var")
done
myfunc "${ARRAY[@]}"
```

A=$(</tmp/myfile) # built-in builtin read file into variable


# pipebuffer
tail -f /var/log/foo | stdbuf -o0 cut
tail -f /var/log/foo | grep --line-buffered
tail -f /var/log/foo | sed -u
tail -f /var/log/foo | python -u
