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
    if 1: set_border_all()
    if 1:
        #help(i3)
        #help(i3.get_tree())
        #pprint(vars(i3.get_tree().nodes[0]))

        #debug(i3.get_tree(), _print=True)
        for w in i3.get_tree().workspaces():
            debug(w, _print=True)
        return
    if 1:
        #remove_single_child_containers(i3.get_tree().find_focused().workspace())
        #remove_single_child_containers(i3.get_tree().find_focused())
        remove_single_child_containers(None)

def debug(e, recursive=True, indent='', _rA=None, _print=False):
    if _rA is None:
        _rA = []
    if e == None:
        _rA.append(u'{indent}Python None'.format(indent=indent))
    elif is_window(e):
        _rA.append(u'{indent}w:{window_class} "{name}"'.format(indent=indent, **vars(e)))
    elif e.type in ['workspace', 'root', 'output'] or True:
        extra = ''
        if e.type in ['workspace', 'con'] and e.layout is not None: extra = '{} {}'.format(extra, e.layout)
        if e.type in ['workspace', 'con'] and e.orientation is not None: extra = '{} {}'.format(extra, e.orientation)
        if e.name is not None and e.name.lower() != 'none': extra = '{} "{}"'.format(extra, e.name)
        extra = extra.strip()
        _rA.append(u'{indent}o:{type}: {extra}'.format(extra=extra, indent=indent, **vars(e)))
        if recursive:
            for n in e.nodes:
                debug(n, recursive=recursive, indent=indent + ' ', _rA=_rA, _print=False)
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

def traverse_all_elem():
    rA = [i3ipc.Connection().get_tree()]
    k = 0
    while k < len(rA):
        yield rA[k]
        rA.extend(rA[k].nodes)
        k = k + 1

def set_border_all():
    for e in traverse_all_elem():
        if e.type == 'con':
            e.command('border normal')

def remove_border_all():
    for e in traverse_all_elem():
        if e.type == 'con':
            e.command('border none')

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
    #elif c.type == 'workspace' or len(c.nodes) != 1:
    elif len(c.nodes) == 1 and c.parent is not None and c.type not in ['workspace', 'output'] and c.nodes[0].type not in ['workspace', 'output']:
        cmd = 'move {}'.format(
            'up' if c.parent.orientation == 'vertical' else 'left'
            )
        logger.info('sending cmd %s to %s', cmd, debug(c.nodes[0], recursive=False))
        c.nodes[0].command(cmd)
    for n in c.nodes:
        if is_window(n):
            # since this functions goes up in the tree if called on one window
            # we need to avoid going down is such cases to avoid infinite loop
            logger.info("Skipping %s", debug(n, recursive=False))
            continue
        remove_single_child_containers(n, recurse=recurse, _focus=False)
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
    #reload(sys)
    #sys.setdefaultencoding('utf-8')
    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        #logging.exception('oups for %s', sys.argv)
        logging.exception('oups for %s', sys.argv)
        #raise type(e), type(e)(e), sys.exc_info()[2]
