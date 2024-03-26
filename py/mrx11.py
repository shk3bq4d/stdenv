#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from Xlib import X, display
import os
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

def logging_conf(
        level='INFO', # DEBUG
        use='stdout', # "stdout syslog" "stdout syslog file"
        filepath=None,
        ) -> None:
    import logging.config
    script_directory, script_name = os.path.split(__file__)
    # logging.getLogger('sh.command').setLevel(logging.WARN)
    if filepath is None:
        filepath = os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           #'graylogf':{"format":"%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s"},
           },
       'handlers':{
           'stdout':   {'level':level,'formatter': 'standard','class':'logging.StreamHandler',         'stream': 'ext://sys.stdout'},
           'file':     {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': filepath}, #
           'syslog':   {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
           #'graylog': {'level':level,'formatter': 'graylogf','class':'pygelf.GelfTcpHandler',         'host': 'log.mydomain.local', 'port': 12201, 'include_extra_fields': True, 'debug': True, '_ide_script_name':script_name},
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})
    try: logging.getLogger('sh.command').setLevel(logging.WARN)
    except: pass

def go(args: List[str]) -> int:
    list_modes()

def list_modes():
    d = display.Display()
    if 0:
        pprint(d.xrandr_list_output_properties(65))
        # <ListOutputProperties serial = 16, data = {'sequence_number': 16, 'atoms': [69, 90, 89, 86, 81, 77, 74, 73, 72, 71]}, error = None>
        return
    if 1:
        help(d.screen().root.xrandr_get_screen_resources())
        vars(d.screen().root.xrandr_get_screen_resources())
        pprint(d.screen().root.xrandr_get_screen_resources())
        return
    help(d)
    pprint(vars(d))
    screen = d.screen()
    help(screen)
    pprint(vars(screen))
    root = screen.root
    help(root)
    pprint(vars(root))

    res = root.xrandr_get_screen_resources()
    help(res)
    pprint(vars(res))

    for mode in res.modes:
        print(f"Mode ID: {mode.id}, Width: {mode.width}, Height: {mode.height}")

    d.close()

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ and False:
        unittest.main()
    else:
        try:
            r = go(sys.argv[1:])
        except BaseException as e:
            logger.exception('oups for %s', sys.argv)
            sys.exit(1)
        sys.exit(r)

