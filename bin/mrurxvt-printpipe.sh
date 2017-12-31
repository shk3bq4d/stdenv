#!/usr/bin/env bash

# !URxvt.print-pipe: cat > $(TMPDIR=$HOME/tmp/ mktemp urxvt.XXXXXX)
# !URxvt.print-pipe: cat > $HOME/tmp/urxvt.dump.$(date +'%Y%M%d%H%m%S')
touch /tmp/haha
# !URxvt.print-pipe: cat > $HOME/tmp/urxvt.dump.$(date +'%Y%M%d%H%m%S')

set -eux
file=$HOME/tmp/urxvt.dump.$(date +'%Y%M%d%H%m%S')
cat > $file

[[ -z "$TERMINAL" ]] && TERMINAL=xterm

$TERMINAL -e vim -- $file &
