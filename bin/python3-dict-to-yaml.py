#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from pprint import pprint
import yaml
import ast
import fileinput
import sys
import urllib


def process(files):

    content = []
    for k, line in enumerate(fileinput.input(files=files)):
        content.append(line.strip())

    content = '\n'.join(content)
    #print(content)
    doc = ast.literal_eval(content)

    print(yaml.dump(doc, default_flow_style=False))

if len(sys.argv) > 1:
    map(process, sys.argv[1:])
else:
    process(None)
