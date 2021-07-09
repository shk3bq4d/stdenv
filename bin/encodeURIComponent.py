#!/usr/bin/env python3

import fileinput
import sys
import urllib.parse


def process(files):

    for k, line in enumerate(fileinput.input(files=files)):
        line = line.strip()
        #if line == '': continue
        if k > 0:
            sys.stdout.write(urllib.parse.quote('\n'.encode("utf-8"))) 
        sys.stdout.write(urllib.parse.quote(line.encode("utf-8"))) 

if len(sys.argv) > 1:
    map(process, sys.argv[1:])
else:
    process(None)

