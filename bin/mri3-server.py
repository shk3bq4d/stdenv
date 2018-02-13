#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

try:
    import cPickle as pickle
except:
    import pickle
import os
import sys
import re
import argparse
import logging
import i3ipc
import subprocess
from sh import pkill

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

def logging_conf(
        level='WARN', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           },
       'handlers':{
           'stdout': {'level':level,'formatter': 'standard','class':'logging.StreamHandler','stream': 'ext://sys.stdout'},
           'file':   {'level':level,'formatter': 'standard','class':'logging.FileHandler','filename': '/tmp/zabbix-kg_maintenance.log'}, #
           'syslog': {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})


wA = None

def on_window(i3, e):
    logging.warn('on_window %s', e.change)
    i3blocklet(e)
    if e.change == 'close':
        wid = e.container.window
        if wid in wA:
            wA.remove(wid)
            persist(wA)
    elif e.change == 'focus':
        wid = e.container.window
        if wid in wA:
            wA.remove(wid)
        wA.append(wid)
        persist(wA)
    logging.warn('/on_window %s', e.change)

i3blocklet_count = 0
def i3blocklet(event):
    global i3blocklet_count
    nb_event_before_trunc = 100
    change = event.change
    name = event.container.name
    if change not in ('focus', 'title'): return
    if i3blocklet_count % nb_event_before_trunc == 0:
        i3blocklet_count = 0 # resetting to zero prevents overflow
        flag = 'w'
    else:
        flag = 'a'
    i3blocklet_count = i3blocklet_count + 1
        
    name = re.sub('^vim - ', '\uf27d  ', name)
    name = re.sub('(.*?) - Stack Overflow - Chromium$', '\uf16c  \\1', name)
    name = re.sub('(.*?) - Stack Exchange - Chromium$', '\uf18d  \\1', name)
    name = re.sub(r'^(?:(\S{1,3})\s+)?urxvt\s+(.*)', '\\1 \uf120 \\2', name)
    name = re.sub('(.*?) - Chromium$', '\uf268  \\1', name)
    with open(i3block_fp, flag) as f:
        f.write('{}\n'.format(name))
    #try: pkill(['-RTMIN+10', 'i3blocks']) except subprocess.CalledProcessError: pass

def on_workspace(i3, e):
    logging.warn('on_workspace %s', e.change)
    return
    print_separator()
    print('Got workspace event:')
    print_time()
    print('Change: %s' % e.change)
    print('Current:')
    print_con_info(e.current)
    print('Old:')
    print_con_info(e.old)

def on_binding(i3, e):
    logging.debug(e.change)
    b = e.binding
    logger.debug(pformat(vars(b)))
    if \
        not(b.symbol == 'p' or \
        b.input_code == 27 ) or \
        b.input_type != 'keyboard' or \
        False:
        return
    c = '-'.join(b.mods)
    logger.warn(c)
    if 'shift-Mod4' == c:
        while len(wA) > 0:
            w = wA[0]
            del wA[0]
            if not exists(w):
                continue
            wA.append(w)
            focus(i3, w)
            break
        persist(wA)
        return
    if 'Mod4' == c:
        while len(wA) > 0:
            w = wA.pop()
            if not exists(w):
                continue
            wA.insert(0, w)
            w = wA[-1]
            focus(i3, w)
            break
        persist(wA)
        return

def exists(w):
    try:
        xprop = subprocess.check_output(['xprop', '-id', str(w)]).decode()
    except subprocess.CalledProcessError:
        return False
    except FileNotFoundError:
        raise SystemExit("The `xprop` utility is not found!"
                         " Please install it and retry.")
    #pprint(xprop)
    return True

def descendents_recursive(container, li=None):
    if li is None:
        li = []
    for d in container.descendents():
        if d not in li:
            li.append(d)
            descendents_recursive(d, li)
    return li

def find_window_id(container, window_id):
    for d in descendents_recursive(container):
        if d.window == window_id:
            return d
    return None

def find_workspace(i3, window_id):
    for workspace in i3.get_tree().workspaces():
        if find_window_id(workspace, window_id) is not None:
            return workspace
    return None

def focus(i3, window_id):
    workspace = find_workspace(i3, window_id)
    if workspace is not None:
        for container in descendents_recursive(workspace):
            if container.type == 'con' and container.fullscreen_mode:
                cmd = '[id="{}"] fullscreen'.format(container.window)
                logger.warn(cmd)
                i3.command(cmd)

    cmd = '[id="{}"] focus'.format(window_id)
    logger.warn(cmd)
    i3.command(cmd)


fp = os.environ['HOME'] +  '/.tmp/mri3-server.pickle'
def persist(bipA):
    with open(fp, 'wb') as f:
        pickle.dump(bipA, f)

def load():
    global wA
    try:
        with open(fp, 'rb') as f:
            wA = pickle.load(f)
        logger.warn('successfully loaded')
    except:
        logger.exception('error loading')
        wA = []

i3block_fp = os.path.expanduser('~/.tmp/mri3server-block.msg')

def go(args):
    logger.warn('go')
    i3 = i3ipc.Connection()
    load()
    i3.on('window', on_window)
    i3.on('workspace', on_workspace)
    i3.on('binding', on_binding)
    i3.main()
    logger.warn('/go')


if __name__ == '__main__':

    logging_conf(use='stdout syslog')
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

