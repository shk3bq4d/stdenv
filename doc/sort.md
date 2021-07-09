cat testfile | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- # sort by line length
sort -n # numeric doesn't work to well, use -V
sort -V # better for numeric and string    -V, --version-sort natural sort of (version) numbers within text # human

sort -u ~/.tmp/bashrc-events --key 1.1,1.11
tac ~/.tmp/bashrc-events | sort -u --key 1.1,1.11

{ cat ~/.tmp/bashrc-events ~/.tmp/i3lock/events | sort -r | sort -u --key 1.1,1.11; cat ~/.tmp/bashrc-events ~/.tmp/i3lock/events |           sort -u --key 1.1,1.11; } | sort
