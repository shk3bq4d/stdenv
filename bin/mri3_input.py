#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */
#
from sh import mri3_input as sh_i3_input
import sys

def go(*args):
    args2 = []
    if len(args) > 0:
        text = ' '.join(args)
        if not text.endswith(' ') and not text.endswith(':'):
            text = text + ': '
        args2 = ['-l', 1000, '-f', 'pango:Monospace Regular 30', '-P', text]
    output = str(sh_i3_input(*args2))
    last_line_words = output.splitlines().pop().split()
    if last_line_words[0] == 'command':
        result = ' '.join(last_line_words[2:])
        return result
    return None # for example if escaped was pressed

if __name__ == "__main__":
    print(go(*sys.argv[1:]))

