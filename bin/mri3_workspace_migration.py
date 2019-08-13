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

class Mri3WorkspaceMigrationTest(unittest.TestCase):
    #def __init__(self, methodName='runTest'): pass
    def tearDown(self): pass
    def tearUp(self): pass

    @classmethod
    def setUpClass(cls): pass

    @classmethod
    def tearDownClass(cls): pass

    def test_mri3_workspace_migration(self):
        for size in range(20):
            self.assertEqual(0, get_index_uniform(mri3.WORKSPACES_NAMES[0], size))

        size = 2
        for i in range(0, 7):
            self.assertEqual(0, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))
        for i in range(7, len(mri3.WORKSPACES_NAMES)):
            self.assertEqual(1, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))

        size = 3
        for i in range(0, 5):
            self.assertEqual(0, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))
        for i in range(5, 9):
            self.assertEqual(1, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))
        for i in range(9, len(mri3.WORKSPACES_NAMES)):
            self.assertEqual(2, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))

        size = 4
        for i in range(0, 4):
            self.assertEqual(0, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))
        for i in range(4, 7):
            self.assertEqual(1, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))
        for i in range(7, 10):
            self.assertEqual(2, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))
        for i in range(10, len(mri3.WORKSPACES_NAMES)):
            self.assertEqual(3, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))

        size = 30
        for i in range(0, len(mri3.WORKSPACES_NAMES)):
            self.assertEqual(i, get_index_uniform(mri3.WORKSPACES_NAMES[i], size))

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
    if 'VIMF6' in os.environ: args = ["0   $   ", '-s']
    if 'VIMF6' in os.environ: args = ["0   $   "]

    parser = argparse.ArgumentParser(description="single entrypoint for the i3.config.bindcode+workspace to allow easy switch between future and roll back version")
    parser.add_argument("DESKTOP", type=str, help="desktop name")
    parser.add_argument("-s", "--shift", help="saves output in place", action="store_true")
    # script_directory, script_name = os.path.split(__file__)
    # script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    # print(script_txt)
    ar = parser.parse_args(args)
    logger.info(ar)
    if 0:
        legacy(ar)
        return
    if 0 and ar.shift:
        legacy(ar)
        return
    try3(ar)

def current_workspaces_letter_obj():
    return {mri3.workspace_name_to_letter(x.num): x for x in mri3.get_root().workspaces()}

def get_index_uniform(requested_desktop_key, nb_existing_desktops):
    if nb_existing_desktops == 0:
        return 0
    percentage = mri3.workspace_name_index(requested_desktop_key) / len(mri3.WORKSPACES_NAMES)
    idx = int(percentage * min(len(mri3.WORKSPACES_NAMES), nb_existing_desktops))
    if idx >= nb_existing_desktops:
        idx = nb_existing_desktops - 1
    logger.info("asked for %s out of %s => %s => %s", requested_desktop_key, nb_existing_desktops, percentage, idx)
    return idx

def try2(ar):
    wH = current_workspaces_letter_obj()
    kH = list(wH.keys())
    logger.info("Current workspaces: %s", [x for x in kH])
    idx = get_index_uniform(ar.DESKTOP, len(kH))
    target_workspace = wH[kH[idx]]
    i3 = i3ipc.Connection()
    back_and_forth_allowed_for_shift = False
    back_and_forth_allowed_for_non_shift = False
    if mri3.is_workspace_focused(target_workspace):
        if ar.shift:
            #logger.info("workspace is already focused %s and ignoring back and forth", target_workspace.name)
            if not back_and_forth_allowed_for_shift:
                return
        else:
            if not back_and_forth_allowed_for_non_shift:
                return
            #logger.info("workspace is already focused %s but continuing due to allowing back and forth", target_workspace.name)
    if ar.shift:
        mri3.focused().command('move workspace "{}"'.format(target_workspace.name))
    i3.command('workspace "{}"'.format(target_workspace.name))

def try3(ar):
    wH = current_workspaces_letter_obj()
    kH = list(wH.keys())
    logger.info("Current workspaces: %s", [x for x in kH])
    idx = mri3.workspace_name_index(ar.DESKTOP)
    if idx < 0:
        idx = 0
    if idx >= len(kH):
        idx = len(kH) - 1
    target_workspace = wH[kH[idx]]
    i3 = i3ipc.Connection()
    back_and_forth_allowed_for_shift = False
    back_and_forth_allowed_for_non_shift = False
    if mri3.is_workspace_focused(target_workspace):
        if ar.shift:
            #logger.info("workspace is already focused %s and ignoring back and forth", target_workspace.name)
            if not back_and_forth_allowed_for_shift:
                return
        else:
            if not back_and_forth_allowed_for_non_shift:
                return
            #logger.info("workspace is already focused %s but continuing due to allowing back and forth", target_workspace.name)
    if ar.shift:
        mri3.focused().command('move workspace "{}"'.format(target_workspace.name))
    i3.command('workspace "{}"'.format(target_workspace.name))

def legacy(ar):
    i3 = i3ipc.Connection()
    if ar.shift:
        mri3.focused().command('move workspace number ' + ar.DESKTOP)
    i3.command('workspace number ' + ar.DESKTOP)
    os.system(os.path.expanduser('~/bin/mri3_prompt_for_unnamed_workspace.py'))

if __name__ ==  "__main__":
    if 'VIMRUNTIME' in os.environ:
        auto(use='stdout file syslog')
        unittest.main()
    else:
        auto(use='stdout file syslog')
        go(sys.argv[1:])
