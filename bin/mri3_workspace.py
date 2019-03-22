#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import argparse
import logging
import i3ipc
import mri3

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

def logging_conf(
        level='INFO', # DEBUG
        use='stdout file syslog' # "stdout syslog" "stdout syslog file"
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
    try: logging.getLogger('sh.command').setLevel(logging.WARN)
    except: pass

def current_workspaces_letter_obj():
    return {mri3.workspace_name_to_letter(x.num): x for x in mri3.get_root().workspaces()}
    for w in mri3.get_root().workspaces():
        #mri3.debug(w, _print=True)
        #help(w)
        #_focused = w.num == focused_workspace.num
        #pprint(vars(w))
        print('{num} {_focused} {name}'.format(_focused=_focused, **vars(w)))

WORKSPACES_PRIORITY = [
'7',
'5',
'3',
'1',
'9',
'0',
'2',
'4',
'6',
'8',
'$',
'&amp;',
'!',
'#']

def go(args):
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMRUNTIME' in os.environ: args = ['1']
    parser = argparse.ArgumentParser(description="Switch to workspace or create a new one following preferred order")
    parser.add_argument("WORKSPACE", type=str, nargs='?', help="workspace to switch to")
    #parser.add_argument("-i", "--in-place", help="saves output in place", action="store_true")
    ar = parser.parse_args(args)
    #script_directory, script_name = os.path.split(__file__)
    focused_workspace = mri3.focused().workspace()
    #pprint(vars(focused_workspace))
    logger.info('ar.WORKSPACE is %s', ar.WORKSPACE)
    if ar.WORKSPACE:
        logger.info('ar.WORKSPACE is %s', ar.WORKSPACE)
        desired_letter = mri3.workspace_name_to_letter(ar.WORKSPACE)
        wH = current_workspaces_letter_obj()
        if desired_letter in wH:
            desired_workspace = wH[desired_letter]
            if mri3.is_workspace_focused(desired_workspace):
                # to be seen what to do in here
                pass
            else:
                desired_workspace.focus()
        else:
            actual_letter = next(x for x in WORKSPACES_PRIORITY if x not in wH)
            #print(wH.keys())
            #print(actual_letter)
            #print(desired_letter)
            i = mri3.WORKSPACES_LETTER.index(actual_letter)
            #print(i)
            desired_name = mri3.WORKSPACES_NAMES[i]
            #print(desired_name)
            #help(mri3.get_root().command)
            mri3.get_root().command('workspace number ' + desired_name)
            # bindcode  $mod+49 workspace number $ws0; exec ~/bin/mri3_prompt_for_unnamed_workspace.py
        return
    mri3.get_root().command('workspace number 8')

    if False:


        pprint(list(current_workspaces_letter()))
        returt
        for w in mri3.get_root().workspaces():
            #mri3.debug(w, _print=True)
            #help(w)
            _focused = w.num == focused_workspace.num
            #pprint(vars(w))
            print('{num} {_focused} {name}'.format(_focused=_focused, **vars(w)))

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        #logging.exception('oups for %s', sys.argv)
        logging.error('oups for %s', sys.argv)
        raise e
        #raise type(e), type(e)(e), sys.exc_info()[2]

