#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
from datetime import datetime as dt
import sys
import fileinput # stdin
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

def go(args):
    # https://docs.python.org/2/library/argparse.html
    parser = argparse.ArgumentParser(description="Try to human format a date")
    #parser.add_argument("ts", type=str, nargs='*', help="timestampe", default=[dt.utcnow().strftime('%s'), dt.now().strftime('%s')])
    parser.add_argument("ts", type=str, nargs='*', help="timestamp", default=[])
    ar = parser.parse_args(args)
    if len(ar.ts) == 0:
        filepath = '-' # or empty, stdin
        for line in fileinput.input(filepath): # stdin
            line = line.rstrip() # stdin fileinput
            if line == '': # stdin fileinput
                continue # stdin fileinput
            do(line)
    else:
        do(' '.join(ar.ts))

def do(bip):
    if re.match('^u\d+', bip): # $ timestamp.py u'1493354506'
        bip = bip[1:]
    try:
        bip_int = int(bip)
        if  bip_int > 1000000000000 and  \
            bip_int < 1000000000000000:
            #         1687343714105
            bip = '{},{}'.format(bip[:-3], bip[-3:])
            bip_int = bip_int / 1000
        print('{} => {}'.format(bip, dt.fromtimestamp(bip_int)))
    except BaseException as e:
        if ' ' in bip:
            for i in bip.split():
                do(i)
        pass

if __name__ == '__main__':
    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

