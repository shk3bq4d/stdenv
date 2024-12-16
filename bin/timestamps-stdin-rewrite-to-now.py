#!/usr/bin/env bash
# ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 :

set -euo pipefail
umask 027
export PATH=/usr/local/sbin:/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:~/bin

py_script() {

#```py
cat << 'EOF'
import datetime
from pprint import pprint
import re
import fileinput # stdin

def get_line():
    filepath = '-' # or empty, stdin
    for line in fileinput.input(filepath): # stdin
        line = line.rstrip() # stdin fileinput
        if line == '': # stdin fileinput
            continue # stdin fileinput
        yield line

def get_date_format(s):
    all_formats = {
        r'^20\d{2}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}\.\d{3}\b': ['%Y.%m.%d %H:%M:%S.%f', 23],
        }
    for pattern, python_format in all_formats.items():
        if re.search(pattern, s):
            return pattern, python_format
    return None, None

        
ONE_MILLIS = datetime.timedelta(microseconds=1000)
previous_date = None
for line in get_line():
    pattern, python_format = get_date_format(line)
    if not pattern:
        print(line)
        continue
    matcher = re.search(pattern, line)
    new_date = datetime.datetime.utcnow()
    if previous_date is not None and new_date <= previous_date + ONE_MILLIS:
        new_date = previous_date + ONE_MILLIS
    if type(python_format) != str:
        python_format, width = python_format
    else:
        width = 100 # large number
    #help(matcher)
    print(
        line[0:matcher.start()] +
        new_date.strftime(python_format)[:width] +
        line[matcher.end():] +
        '')
    #pprint(matcher)
    previous_date = new_date

EOF
#```
}

if command -v python3 &>/dev/null; then
    python3 -c "$(py_script)"
elif hash -v python &>/dev/null; then
    python -c "$(py_script)"
else
    >&2 echo "FATAL: no python"
    exit 1
fi
exit 0
