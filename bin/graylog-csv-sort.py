#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from collections import OrderedDict
import csv
import datetime
import fileinput
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

def go(args) -> None:
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMF6' in os.environ and False: args = ['HEHE', '-i']
    parser = argparse.ArgumentParser(description="This is the description of what I do")
    parser.add_argument("FILENAME", type=str, nargs='*', default='-', help="file to process")
    parser.add_argument("-t", "--ts", action='store_true', help="outputs timestamp")
    ar = parser.parse_args(args)
    # 2023-06-13T21:45:03.751Z
    fA = ['%Y-%m-%dT%H:%M:%S.%fZ']
    o = '%Y.%m.%d %H:%M:%S.%f'
    skip = False
    for i in ar.FILENAME:
        doc = csv.reader(fileinput.FileInput([i]))
        timestamp_idx = 0
        message_idx = 1
        log_original_idx = -1
        dH = OrderedDict()
        for k, row in enumerate(doc):
            if k == 0:
                skip = False
                if 'timestamp' in row:
                    timestamp_idx = row.index('timestamp')
                    skip = True
                if 'message' in row:
                    message_idx = row.index('message')
                    skip = True
                if 'log_original' in row:
                    log_original_idx = row.index('log_original')
                    skip = True
                if skip:
                    continue
            ts_str = row[timestamp_idx]
            #print(k)
            #pprint(row)
            #print('timestamp' in row)
            #print(skip)
            #print(ts_str)
            ts = datetime.datetime.strptime(ts_str, fA[0])
            if ts in dH:
                rA = dH[ts]
            else:
                dH[ts] = rA = []
            if log_original_idx >= 0 and len(row[log_original_idx] or '') > 0:
                rA.append(row[log_original_idx])
            else:
                rA.append(row[message_idx])

        for ts, rA in dH.items():
            ts = ts.strftime(o)
            ts = ts[:-3]
            for m in rA:
                if ar.ts:
                    print('{ts} {m}'.format(**locals()))
                else:
                    print(m)

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ and False:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logger.exception('oups for %s', sys.argv)
            sys.exit(1)

