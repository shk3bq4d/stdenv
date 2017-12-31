#!/usr/bin/env python

from sh import i3_msg
from pprint import pprint
import json
import sys
import i3_prompt_for_unnamed_workspace


def go(args):
	workspaces = [x['num'] for x in json.loads(str(i3_msg('-t', 'get_workspaces')))]
        for w in xrange(0, 100):
            if w not in workspaces:
                o = ['workspace', w]
                if len(args) > 0:
                    args = args + o
                    i3_msg(*args)
                i3_msg(*o)
                i3_prompt_for_unnamed_workspace.go()
                print(w)
                
                break
	

if __name__ ==  "__main__":
    go(sys.argv[1:])
