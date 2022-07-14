#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

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

class SqlToLowercaseTest(unittest.TestCase):
    #def __init__(self, methodName='runTest'): pass
    def tearDown(self) -> None: pass
    def setUp(self) -> None: pass

    @classmethod
    def setUpClass(cls) -> None: pass

    @classmethod
    def tearDownClass(cls) -> None: pass

    def test_queue_summary_alter(self) -> None:
        self.assertIn(   'a', 'abcde', msg='a is supposed to be in abcde')
        self.assertNotIn('z', 'abcde', msg='z is not supposed to be in abcde')
        self.assertNotEqual('expected', 'actual', msg='expected is first argument')
        # assertAlmostEqual assertAlmostEquals assertDictContainsSubset assertDictEqual
        # assertEqual assertEquals assertFalse assertGreater assertGreaterEqual
        # assertIn assertIs assertIsInstance assertIsNone assertIsNot assertIsNotNone
        # assertItemsEqual assertLess assertLessEqual assertListEqual assertMultiLineEqual
        # assertNotAlmostEqual assertNotAlmostEquals assertNotEqual assertNotEquals
        # assertNotIn assertNotIsInstance assertNotRegexpMatches assertRaises
        # assertRaisesRegexp assertRegexpMatches assertSequenceEqual assertSetEqual
        # assertTrue assertTupleEqual assert_ countTestCases debug defaultTestResult
        # doCleanups fail failIf failIfAlmostEqual failIfEqual failUnless failUnlessAlmostEqual
        # failUnlessEqual failUnlessRaises failureException id longMessage maxDiff
        # run setUp setUpClass shortDescription skipTest tearDown tearDownClass

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
state_normal = 0
state_single_quote_str = 1
state_square_column = 2
state_single_quote_str_backslash = 3
def process(fp):
    logger.info("-> %s", fp)
    previous_char = ''
    state = state_normal
    bA = []
    outA = []
    for char in read_char(fp):
        if state == state_normal:
            if char == "'":
                next_state = state_single_quote_str
                outA.append(lower_case(''.join(bA)))
                outA.append(char)
                bA = []
            elif char == '[':
                next_state = state_square_column
                outA.append(lower_case(''.join(bA)))
                outA.append(char)
                bA = []
            else:
                next_state = state_normal
                bA.append(char)
        elif state == state_single_quote_str:
            if char == '\\':
                next_state = state_single_quote_str_backslash
            elif char == "'":
                outA.append(char)
                next_state = state_normal
            else:
                outA.append(char)
        elif state == state_square_column:
            if char == "]":
                outA.append(char)
                next_state = state_normal
            else:
                outA.append(char)
        elif state == state_single_quote_str_backslash:
            outA.append(previous_char)
            outA.append(char)
            next_state = state_single_quote_str

        state = next_state
        previous_char = char
    return ''.join(outA)

def lower_case(s):
    def _inner(m):
        return m.group(0).lower()
    return re.sub(r'\b(left|right|inner|outer|join|insert|is|null|values|update|replace|delete|from|into|set|where|with|as)\b', _inner, s, flags=re.I)

def read_char(fp):
    for line in fileinput.input(fp): # stdin
        line = line.rstrip() # stdin
        if line == '': # stdin
            continue # stdin
        for char in line:
            yield char
        yield '\n'

def go(args) -> None:
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMF6' in os.environ: args = [os.path.expanduser('~/tmp/bip')]
    parser = argparse.ArgumentParser(description="lowercase SQL keywords in passed query (stdin or file)")
    parser.add_argument("FILENAME", type=str, nargs='?', default='-', help="file to process")
    script_directory, script_name = os.path.split(__file__)
    script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    # print(script_txt)
    ar = parser.parse_args(args)
    s = process(ar.FILENAME)
    print('``' + '`sql')
    print(s)
    print('``' + '`')

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

