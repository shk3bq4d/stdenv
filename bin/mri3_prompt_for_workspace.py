#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import mri3_prompt_for_unnamed_workspace
import i3ipc
import sys
import os
import re
import logging
import sh


logger = logging.getLogger(__name__)


def go(args=[]):
    logger.info('go()')

if __name__ ==  "__main__":

    mri3_prompt_for_unnamed_workspace.auto(use='stdout file syslog')
    mri3_prompt_for_unnamed_workspace.go2(sys.argv[1:], False)
