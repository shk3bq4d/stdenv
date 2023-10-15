#!/usr/bin/env python3

import fileinput
import sys
import random
import urllib.parse

def anagram(s):
    bA = list(s)
    random.shuffle(bA)
    return ''.join(bA)

def process(files):

    for k, line in enumerate(fileinput.input(files=files)):
        line = line.strip()
        #if line == '': continue
        if k > 0:
            sys.stdout.write("\n") 
        sys.stdout.write(anagram(line)) 

if len(sys.argv) > 1:
    map(process, sys.argv[1:])
else:
    process(None)

