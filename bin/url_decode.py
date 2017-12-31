#!/usr/bin/env python

import fileinput
import sys
import urllib


def process(files):

    for k, line in enumerate(fileinput.input(files=files)):
        line = line.strip()
        #if line == '': continue
        print(urllib.unquote(line.encode("utf-8"))) 

if len(sys.argv) > 1:
    map(process, sys.argv[1:])
else:
    process(None)

