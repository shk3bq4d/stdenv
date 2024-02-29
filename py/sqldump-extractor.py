#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import gzip
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

class SqldumpExtractorTest(unittest.TestCase):
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

def get_reader(fp):
    if fp.endswith('.gz'):
        return gzip.open(fp, 'rt')
    return open(fp, 'rt')

def should_process(table_name, instruction, ar):
    if len(ar.table or []) > 0:
        r = False
        for t in ar.table:
            if re.match(t, table_name):
                r = True
                break
        if not r:
            return False
    if len(ar.statement_type or []) > 0:
        r = False
        for y in ar.statement_type:
            if re.match(y, instruction):
                r = True
                break
        if not r:
            return False
    return True


STATE_READY = 0
STATE_CREATE_DATABASE = 1
STATE_C_COMMENT = 2
STATE_CREATE_TABLE = 3
STATE_INSERT_INTO = 4
def go(args: List[str]) -> int:
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMF6' in os.environ and False: args = ['HEHE', '-i']
    parser = argparse.ArgumentParser(description="Parses a mysql or postgres dump and extracts part of it")
    parser.add_argument("FILENAME", type=str, nargs='+', help="file to process")
    parser.add_argument("-t", "--table", help="table name(s) to process, supports regexp and can be repeated", nargs='*')
    parser.add_argument("-s", "--statement-type", help="statement types to process, insert, create, create table, ...", nargs='*')
    parser.add_argument("-d", "--print-data", help="not only print matching table names, but also the data, whet it applies", action='store_true')
    ar = parser.parse_args(args)
    buffer = []

    for fp in ar.FILENAME:
        with get_reader(fp) as f:
            state = STATE_READY
            for line in f.readlines():
                #if line[-1] == '\r': line = line[:-1]
                line = line.rstrip()
                subline = line[:64]
                subline_lower = subline.lower()
                nextstate = state
                if state == STATE_READY:
                    if len(buffer) > 0:
                        buffer = []
                    if not line.strip():
                        continue
                    if line.startswith('--'):
                        process_comment(line, ar)
                    elif line.startswith('/*!') and line.endswith('*/;'):
                        process_dbhint(line, ar)
                    elif subline_lower.startswith('create database '):
                        if line.endswith(';'):
                            process_create_database(line, ar)
                        else:
                            buffer.append(line)
                            nextstate = STATE_CREATE_DATABASE
                    elif subline_lower.startswith('create table '):
                        if line.endswith(';'):
                            process_create_table(line, ar)
                        else:
                            buffer.append(line)
                            nextstate = STATE_CREATE_TABLE
                    elif subline_lower.startswith('insert into '):
                        if line.endswith(';'):
                            process_insert_into(line, ar)
                        else:
                            buffer.append(line)
                            nextstate = STATE_INSERT_INTO
                    elif subline_lower.startswith('use '): process_use(line, ar)
                    elif subline_lower.startswith('drop table if exists '): process_drop_table_if_exists(line, ar)
                    elif subline_lower.startswith('lock tables '): process_lock_tables(line, ar)
                    elif subline_lower.startswith('unlock tables'): process_unlock_tables(line, ar)
                    else:
                        raise BaseException("Couldn't interpret line " + line)
                elif state == STATE_CREATE_TABLE:
                    buffer.append(line)
                    if line.endswith(';'):
                        nextstate = STATE_READY
                        process_create_table("\n".join(buffer), ar)
                elif state == STATE_INSERT_INTO:
                    buffer.append(line)
                    if line.endswith(';'):
                        nextstate = STATE_READY
                        process_insert_into("\n".join(buffer), ar)
                else:
                    raise BaseException("Unimplemented state " + str(state))
                state = nextstate

def process_comment(line, ar): pass
def process_c_comment(line, ar): pass
def process_create_database(line, ar): pass
def process_use(line, ar): pass
def process_drop_table_if_exists(line, ar): pass
def process_lock_tables(line, ar): pass
def process_unlock_tables(line, ar): pass
def process_dbhint(line, ar): pass

def process_create_table(line, ar):
    m_table_name = re.search('^create table ([`]?)([a-z_][a-z0-9_]{0,63})\\1', line, flags=re.I)
    instruction = 'create table'
    if m_table_name:
        table_name = m_table_name[2]
    else:
        raise BaseException("couldn't extract table name for  " + line[:64])
    if not should_process(table_name, instruction, ar):
        return
    if ar.print_data:
        print("-- process_create_table")
        print(line)
    else:
        print("-- create table " + table_name + ", length: " + str(len(line)))

def process_insert_into(line, ar):
    m_table_name = re.search('^insert into ([`]?)([a-z_][a-z0-9_]{0,63})\\1', line, flags=re.I)
    instruction = 'insert'
    if m_table_name:
        table_name = m_table_name[2]
    else:
        raise BaseException("couldn't extract table name for  " + line[:64])
    if not should_process(table_name, instruction, ar):
        return
    if ar.print_data:
        print("-- process_insert_into")
        print(line)
    else:
        print("-- insert into " + table_name + ", length: " + str(len(line)))


if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ and False:
        unittest.main()
    else:
        try:
            r = go(sys.argv[1:])
        except BaseException as e:
            logger.exception('oups for %s', sys.argv)
            sys.exit(1)
        sys.exit(r)

