#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from sh import i3_msg
from pprint import pprint
import json
import sys
import mri3_prompt_for_unnamed_workspace
import i3ipc
import logging
import os
try:
    import mri3
except:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3
logger = logging.getLogger(__name__)

def auto(
        level='INFO', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    script_directory, script_name = os.path.split(__file__)
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           },
       'handlers':{
           'stdout': {'level':level,'formatter': 'standard','class':'logging.StreamHandler','stream': 'ext://sys.stdout'},
           'file': {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))}, #
           'syslog': {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})



def go(args):
    mri3.renumber_workspaces()
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
        logger.info("o: %s", o)
        i3_msg(*o)
        logger.info("name: _%s_", name)
        try:
            i3_msg('move','workspace','to','output', name)
        except:
            # since version 4.20 (previously tried on 4.18) it appears that this generate an exception if name is already current workspace
            pass
        logger.info("then")
        mri3_prompt_for_unnamed_workspace.go()
        logger.info("after")
        try:
            i3_msg('move','workspace','to','output', name)
        except:
            # since version 4.20 (previously tried on 4.18) it appears that this generate an exception if name is already current workspace
            pass
        print(w)
        break

if __name__ ==  "__main__":
  auto()
  go(sys.argv[1:])
