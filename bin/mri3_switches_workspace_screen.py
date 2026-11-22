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
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--current", help="if set, then only consider currently focused workspace", action="store_true")
    ar = parser.parse_args(args)

    i3 = i3ipc.Connection()
    focused_object = mri3.focused()
    focused_workspace = focused_object.workspace()
    focused_workspace_output = mri3.get_output_name(focused_workspace)
    output_names = mri3.output_names()
    excluded_outputs = []
    if mri3.gethostname() == 'feb22':
        excluded_outputs = ['DP-4']
    elif len(output_names) > 2:
        # eDP and eDP-1 are common display names for laptops
        # when you have 2 screens + the laptop screen, you probably don't want
        # to switch to laptop screen anymore
        # Just rewrite the condition so that this heuristic is evaluated last
        # and possibly check that eDP or eDP-1 are part of the output_names
        # at the time of the writing this basic logic works perfectly for me
        excluded_outputs = ['eDP', 'eDP-1']

    if focused_workspace_output in excluded_outputs:
        excluded_outputs.remove(focused_workspace_output)

    output_names = list(set(output_names) - set(excluded_outputs))
    to_focus = []

    for workspace in mri3.workspaces():
        if ar.current:
            # apparently, comparing objects fails, hence comparing the name
            if workspace.name != focused_workspace.name or mri3.get_output_name(workspace) != focused_workspace_output:
                print(f"--current: skipping workspace: {workspace.name} != focused_workspace {focused_workspace.name}")
                continue
        workspace_output_name = mri3.get_output_name(workspace)
        if workspace_output_name in excluded_outputs: continue
        following_output_name = output_names[(output_names.index(workspace_output_name) + 1) % len(output_names)]
        command = f"move to output '{following_output_name}'"
        command = f"move workspace to output '{following_output_name}'"
        command = f'move workspace to output "{following_output_name}"'
        logger.info(f'workspace {workspace.name:<30s} on output {workspace_output_name:<14s} will be moved to output {following_output_name}')
        logger.info(command)

        if mri3.is_workspace_focused_within_output(workspace): to_focus.append(workspace)
        # i3-msg '[workspace="workspace_name"]' move workspace to output output_index # https://unix.stackexchange.com/questions/397269/i3wm-how-to-move-workspaces-between-monitors
        #continue
        reply = workspace.command(command)
        first_reply = reply[0]
        if not first_reply.success:
            logger.warn(vars(first_reply))
            pprint(vars(first_reply))
    #to_focus.remove(focused_workspace)
    #to_focus.append(focused_workspace)

    for workspace in to_focus:
        workspace.command('focus')
    focused_object.command('focus')
    logger.info("Success")

if __name__ ==  "__main__":
    auto(use='stdout file syslog')
    go(sys.argv[1:])
