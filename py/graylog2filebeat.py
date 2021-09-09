#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

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

class Graylog2FilebeatTest(unittest.TestCase):

    def test_queue_summary_alter(self) -> None:
        cAA = [
                [{}, {}],
                [dict(a="hehe"), dict(a="hehe")],
                [dict(a_b="hehe"), dict(a=dict(b="hehe"))],
                ]

        for k, test_case in enumerate(cAA):
            if len(test_case) == 3:
                _in, expected, msg = test_case
            else:
                _in, expected      = test_case
                msg = f"test case #{k}"

            actual = graylog_to_filebeat(_in)
            self.assertEquals(expected, actual, msg)

def graylog_to_filebeat(inH):
    returnH = dict()
    def _ensure_key(rH, key, value):
        key = key.replace('_', '.')
        keyA = key.split('.')
        for k in range(len(keyA)):
            subkey = keyA[k]
            if k < len(keyA) - 1:
                next_subkey = keyA[k + 1]
            else:
                next_subkey = None
            if subkey not in rH:
                if next_subkey:
                    if re.match(r'\d+', next_subkey) is not None:
                        rH[subkey] = []
                    else:
                        rH[subkey] = {}
                else:
                    rH[subkey] = value
            rH = rH[subkey]

    for key, value in inH.items():
        eH = _ensure_key(returnH, key, value)

    return returnH

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
    parser.add_argument("FILENAME", type=str, nargs='+', help="file to process")
    parser.add_argument("-i", "--in-place", help="saves output in place", action="store_true")
    script_directory, script_name = os.path.split(__file__)
    script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    # print(script_txt)
    ar = parser.parse_args(args)
    # pprint(ar)

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logger.exception('oups for %s', sys.argv)
            sys.exit(1)

