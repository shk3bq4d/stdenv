#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */
#
# https://github.com/acrisci/i3ipc-python

import os
import sys
import re
import argparse
import logging
import logging.config
import i3ipc

from pprint import pprint

logger = logging.getLogger(__name__)

def logging_conf(
        level='INFO', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    script_directory, script_name = os.path.split(__file__)
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           #'graylogf':{"format":"%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s"},
           },
       'handlers':{
           'stdout':   {'level':level,'formatter': 'standard','class':'logging.StreamHandler',         'stream': 'ext://sys.stdout'},
           'file':     {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))}, #
           'syslog':   {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
           #'graylog': {'level':level,'formatter': 'graylogf','class':'pygelf.GelfTcpHandler',         'host': 'log.mydomain.local', 'port': 12201, 'include_extra_fields': True, 'debug': True, '_ide_script_name':script_name},
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})

def go(args):
    i3 = i3ipc.Connection()
    if 0:
        help(i3)
        help(i3.get_tree())
        pprint(i3.get_tree())
        debug(i3.get_tree(), _print=True)
        return
    if 1:
        #remove_single_child_containers(i3.get_tree().find_focused().workspace())
        remove_single_child_containers(i3.get_tree().find_focused())

def debug(e, recursive=True, indent='', _rA=None, _print=False):
    if _rA is None:
        _rA = []
    if e == None:
        _rA.append(u'{indent}Python None'.format(indent=indent))
    elif e.type == 'workspace':
        _rA.append(u'{indent}{type}: "{name}"'.format(indent=indent, **vars(e)))
        if recursive:
            for n in e.nodes:
                debug(n, recursive=recursive, indent=indent + ' ', _rA=_rA, _print=False)
    elif len(e.nodes) == 0:
        _rA.append(u'{indent}{type}-{window_class} "{name}"'.format(indent=indent, **vars(e)))
    else:
        _rA.append(u'{indent}container: {layout} {orientation}'.format(indent=indent, **vars(e)))
        if recursive:
            for n in e.nodes:
                debug(n, recursive=recursive, indent=indent + ' ', _rA=_rA, _print=False)
    r = '\n'.join(_rA)
    if _print:
        print(r)
    return r

def is_window(w):
    return w.window is not None

def remove_single_child_containers(c, recurse=True, _focus=True):
    root = i3ipc.Connection().get_tree()
    if c is None:
        c = root
        logger.info("None was given, applying on %s", debug(c, recursive=False))
    else:
        logger.info("on %s", debug(c, recursive=False))
    if _focus: current = root.find_focused()

    if c.type == 'root':
        for w in c.workspaces():
            remove_single_child_containers(w, recurse=recurse, _focus=False)
    elif is_window(c):
        # going up in the tree is rather week
        remove_single_child_containers(c.parent)
    elif c.type == 'workspace' or len(c.nodes) != 1:
        for n in c.nodes:
            if is_window(n):
                # since this functions goes up in the tree if called on one window
                # we need to avoid going down is such cases to avoid infinite loop
                continue
            remove_single_child_containers(n, recurse=recurse, _focus=False)
    elif len(c.nodes) == 1 and c.parent is not None:
        c.nodes[0].command('move {}'.format(
            'up' if c.parent.orientation == 'vertical' else 'left'
            ))
    #if _focus: current.focus()

def mrinspect(foA, foO):
    foA.append(foO)
    if foO['focused']:
        return True
    for i in foO['nodes']:
        if mrinspect(foA, i):
            return True
    foA.pop()
    return False

def mrFocusedStack():
    """ returns a list of container in which the latest is the focused window """
    import json
    import subprocess
    rA = []
    bString = subprocess.check_output(["i3-msg", "-t", "get_tree"])
    cO = json.loads(bString)
    rA = []
    mrinspect(rA, cO)
    return rA

if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf-8')
    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        #logging.exception('oups for %s', sys.argv)
        logging.exception('oups for %s', sys.argv)
        #raise type(e), type(e)(e), sys.exc_info()[2]
