#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

_python_script() {
    sed -n -r -e '/^# PYTHON SCRIPT MARKER/,$ p' $0
}

_process() {
    local BIN
    if false; then
        hash python3 2>/dev/null && BIN=python3 || BIN=python
    else
        # favouring python2, just for testing
        hash python 2>/dev/null && BIN=python || BIN=python3
    fi
    $BIN <(_python_script)

}

consume() {
    local SUDO
    if [[ -n "${VIMF6:-}" ]]; then
        cat ~/tmp/docker-inspect
    else
        docker ps &>/dev/null && SUDO="" || SUDO=sudo
        $SUDO docker inspect "$@"
    fi
}


consume "$@" | _process

exit 0
# PYTHON SCRIPT MARKER
#```python

import json
import sys
from pprint import pprint

jH = json.load(sys.stdin)
pprint(jH)
print("output")
print("""
{Name}
id:         {Id}
image:      {Config[Image]}
cmd:        {Config[Cmd]}
entrypoint: {Config[Entrypoint]}
hostname:   {Config[Hostname]}
""".strip().format(**jH[0]))
