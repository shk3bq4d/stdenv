#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import unittest
import argparse
import logging

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

class FixWhitespacesTest(unittest.TestCase):
    #def __init__(self, methodName='runTest'): pass
    def tearDown(self): pass
    def tearUp(self): pass

    @classmethod
    def setUpClass(cls): pass

    @classmethod
    def tearDownClass(cls): pass

    def test_tabs_to_space(self):
        conf = parse_args([])
        dA = [
            ("abcd", "abcd"),
            ("abcd ", "abcd"),
            (" abcd", " abcd"),
            ("  abcd", "  abcd"),
            (" abcd", " abcd"),
            ("\tabcd", "    abcd"),
            ("{\tabcd",    "{   abcd"),
            ("{\t\tabcd",  "{       abcd"),
            ("{\t{\tabcd", "{   {   abcd"),
            ]
        for d in dA:
            self.assertEqual(d[1], process_line(d[0], conf), msg=rr(d))

def rr(i,j=None):
    if j is None:
        if isinstance(i, str) or isinstance(i, unicode):
            return i.replace("\t", "\\t")
        return rr(*i)
    return "expected '{}', found '{}'".format(rr(j), rr(i))

def process_line(line, conf):
    line = line.rstrip()
    if conf.tabs:
        line = process_line_space_to_tab(line, conf)
    else:
        line = process_line_tab_to_space(line, conf)
    return line

def process_line_space_to_tab(line, conf):
    raise BaseException("unimplemented")

def process_line_tab_to_space(line, conf):
    if "\t" not in line: return line
    outA = []
    for i, c in enumerate(line):
        if c == "\t":
            outA.append(' ')
            while len(outA) % conf.tab_stops != 0:
                outA.append(' ')
        else:
            outA.append(c)
    return ''.join(outA)

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
    try: logging.getLogger('sh.command').setLevel(logging.WARN)
    except: pass

def parse_args(args):
    parser = argparse.ArgumentParser(description="Convert tabs (or vice-versa) in each FILE to spaces, writing to standard output. With no FILE, or when FILE is -, read standard input.")
    #parser.add_argument("FILENAME", type=str, nargs='+', help="file to process")
    #parser.add_argument("-i", "--initial", help="do not convert after non-blank", action="store_true")
    parser.add_argument("-t", "--tabs", help="convert spaces to tabs instead", action="store_true")
    parser.add_argument("--tab-stops", type=int, default=4)
    ar = parser.parse_args(args)
    return ar

def go(args):
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMRUNTIME' in os.environ: args = ['HEHE', '-i']
    ar = parse_args(args)
    # pprint(ar)

if __name__ == '__main__':
    logging_conf()
    if 'VIMRUNTIME' in os.environ:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logging.exception('oups for %s', sys.argv)
            #logging.error('oups for %s', sys.argv)
            #raise type(e), type(e)(e), sys.exc_info()[2]

