#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from sh import i3_msg
from pprint import pprint
import json
import sys
import i3_prompt_for_unnamed_workspace
import i3ipc


def go(args):
    i3 = i3ipc.Connection()
    i3.get_tree().find_focused().workspace().parent.parent.workspace()
    name = i3.get_tree().find_focused().workspace().parent.parent.name
    workspaces = [x['num'] for x in json.loads(str(i3_msg('-t', 'get_workspaces')))]
    for w in range(0, 100):
      if w not in workspaces:
        o = ['workspace', w]
        if len(args) > 0:
          args = args + o
          i3_msg(*args)
        i3_msg(*o)
        i3_msg('move','workspace','to','output', name)
        i3_prompt_for_unnamed_workspace.go()
        i3_msg('move','workspace','to','output', name)
        print(w)
        break

if __name__ ==  "__main__":
  go(sys.argv[1:])
