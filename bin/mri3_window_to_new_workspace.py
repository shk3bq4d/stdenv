#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from sh import i3_msg
from pprint import pprint
import json
import sys
import mri3_prompt_for_unnamed_workspace
import i3ipc
import os
try:
    import mri3
except:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3


def go(args):
    mri3.renumber_workspaces()
    i3 = i3ipc.Connection()
    i3.get_tree().find_focused().workspace().parent.parent.workspace()
    window = i3.get_tree().find_focused()
    name = i3.get_tree().find_focused().workspace().parent.parent.name
    workspaces = [x['num'] for x in json.loads(str(i3_msg('-t', 'get_workspaces')))]
    for w in range(0, 100):
        if w not in workspaces:
            window.command('move container to workspace {}'.format(w))
            i3.command('workspace {}'.format(w))
            mri3_prompt_for_unnamed_workspace.go()
            return
        continue
        if len(args) > 0:
            args = args + o
            i3_msg(*args)
        i3_msg(*o)
        i3_msg('move','workspace','to','output', name)
        i3_msg('move','workspace','to','output', name)
        print(w)
        break

if __name__ ==  "__main__":
  go(sys.argv[1:])
