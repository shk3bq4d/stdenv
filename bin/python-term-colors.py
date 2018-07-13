#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import argparse
import logging

from pprint import pprint, pformat

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
    if sys.stdout.isatty():
        NONE="\033[0m"    # unsets color to term's fg color
        BOLD="\033[1m"
        OFF="\033[m"
        BLACK="\033[0;30m"    # black
        RED="\033[0;31m"    # red
        GREEN="\033[0;32m"    # green
        YELLOW="\033[0;33m"    # yellow
        BLUE="\033[0;34m"    # blue
        MAGENTA="\033[0;35m"    # magenta
        CYAN="\033[0;36m"    # cyan
        WHITE="\033[0;37m"    # white
        EMBLACK="\033[1;30m"
        EMRED="\033[1;31m"
        EMGREEN="\033[1;32m"
        EMYELLOW="\033[1;33m"
        EMBLUE="\033[1;34m"
        EMMAGENTA="\033[1;35m"
        EMCYAN="\033[1;36m"
        EMWHITE="\033[1;37m"
        BGBLACK="\033[40m"
        BGRED="\033[41m"
        BGGREEN="\033[42m"
        BGYELLOW="\033[43m"
        BGBLUE="\033[44m"
        BGMAGENTA="\033[45m"
        BGCYAN="\033[46m"
        BGWHITE="\033[47m"
    else:
        NONE=BOLD=OFF=BLACK=RED=GREEN=YELLOW=BLUE=MAGENTA=CYAN=\
            WHITE=EMBLACK=EMRED=EMGREEN=EMYELLOW=EMBLUE=EMMAGENTA=\
            EMCYAN=EMWHITE=BGBLACK=BGRED=BGGREEN=BGYELLOW=BGBLUE=\
            BGMAGENTA=BGCYAN=BGWHITE=''

    print(MAGENTA + ' bip ' + NONE)

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

