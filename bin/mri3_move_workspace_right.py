#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from pprint import pprint
import argparse
import os
import sys
try:
    import mri3
except ModuleNotFoundError:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3
import i3ipc
import re
import logging
import unittest
import sh


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

def go(args=[]):
    logger.info('go()')

    i3 = i3ipc.Connection()
    focused_workspace = mri3.focused().workspace()
    all_workspaces = mri3.get_root().workspaces()
    all_workspaces_names = list(map(lambda x: x.name, all_workspaces))
    focused_index = all_workspaces_names.index(focused_workspace.name)
    if focused_index >= len(all_workspaces) - 1:
        logger.info('Returning as already absolute right')
        return
    right_workspace = all_workspaces[focused_index + 1]
    right_number,    right_leftover    = re.match(r'(\d+)(.*)', right_workspace.name   ).groups()
    focused_number, focused_leftover = re.match(r'(\d+)(.*)', focused_workspace.name).groups()

    logger.info('focused_workspace %s', focused_workspace.name)
    logger.info('focused_index %s', focused_index)
    logger.info('right_workspace name %s', right_workspace.name)
    logger.info('all_workspaces %s', list(map(lambda x: x.name, all_workspaces)))
    print((right_number, right_leftover))
    print((focused_number, focused_leftover))
    i3.command('rename workspace "{}" to "{}{}"'.format(right_workspace.name,   focused_number, right_leftover))
    i3.command('rename workspace "{}" to "{}{}"'.format(focused_workspace.name, right_number,   focused_leftover))

if __name__ ==  "__main__":
    auto(use='stdout file syslog')
    go(sys.argv[1:])
