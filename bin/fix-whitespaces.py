#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import copy
import sys
import re
import unittest
import argparse
import fileinput
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

    def test_space_to_tabs_2(self):
        conf = parse_args("-t --tab-stops 2".split())
        dA = [
            ("", ""),
            ("abcd", "abcd"),
            ("abcd ", "abcd"),
            (" abcd", " abcd"),
            ("  abcd", "\tabcd"),
            ("\tabcd", "\tabcd"),
            ("{\tabcd",    "{\tabcd"),
            ("{\t\tabcd",  "{\t\tabcd"),
            ("{\t{\tabcd", "{\t{\tabcd"),
            ("{ abcd",    "{\tabcd"),
            ("  abcd",    "\tabcd"),
            ("   abcd",    "\t abcd"),
            ("    abcd",    "\t\tabcd"),
            ("     abcd",    "\t\t abcd"),
            ("      abcd",    "\t\t\tabcd"),
            ("\t    abcd",    "\t\t\tabcd"),
            ("\t  \tabcd",    "\t\t\tabcd"),
            ("\t\t  abcd",    "\t\t\tabcd"),
            ]
        for d in dA:
            found = process_line(d[0], conf)
            self.assertEqual(d[1], found, msg=rr(found, d[1], d[0]))


    def test_default(self):
        conf = parse_args([])
        dA = [
            ("", ""),
            ("abcd", "abcd"),
            ("abcd ", "abcd"),
            (" abcd", " abcd"),
            ("  abcd", "  abcd"),
            ("\tabcd", "    abcd"),
            ("{\tabcd",    "{   abcd"),
            ("{\t\tabcd",  "{       abcd"),
            ("{\t{\tabcd", "{   {   abcd"),
            ]
        for d in dA:
            self.assertEqual(d[1], process_line(d[0], conf), msg=rr(d))

    def test_empty_lines(self):
        a = "\n\n\n"
        oA = []
        args = []
        go(args, a.splitlines(), oA.append)
        found = '\n'.join(oA) + "\n"
        self.assertEquals(a, found)

    def test_empty_lines_2(self):
        import textwrap
        a = textwrap.dedent("""
            a = 5

            b = 6
            """).strip() + "\n"
        oA = []
        args = []
        go(args, a.splitlines(), oA.append)
        found = '\n'.join(oA) + "\n"
        self.assertEquals(a, found)


def rr(i,j=None, k=None):
    if k is None:
        if j is None:
            if isinstance(i, str) or isinstance(i, unicode):
                return i.replace("\t", "\\t")
            return rr(*i)
        return "expected '{}', found '{}'".format(rr(j), rr(i))
    return "expected '{}', found '{}' for input '{}'".format(rr(j), rr(i), rr(k))

def process_line(line, conf):
    line = line.rstrip()
    if conf.tabs:
        line = process_line_space_to_tab(line, conf)
    else:
        line = process_line_tab_to_space(line, conf)
    return line

def process_line_space_to_tab(line, conf):
    if " " not in line: return line
    outA = []
    nb_consecutive_spaces = 0
    position_modulo_ts = 0
    prev_char = None
    for curr_char in line:
        if curr_char == "\t":
            nb_consecutive_spaces = 0
            position_modulo_ts = 0
            outA.append("\t")
        elif curr_char == " ":
            nb_consecutive_spaces = nb_consecutive_spaces + 1
            position_modulo_ts = position_modulo_ts + 1
            if position_modulo_ts % conf.tab_stops == 0:
                if nb_consecutive_spaces == 1:
                    if prev_char in ["{"]:
                        outA.append("\t")
                    else:
                        outA.append(" ")
                else:
                    outA.append("\t")
                nb_consecutive_spaces = 0
                position_modulo_ts = 0
        else:
            if nb_consecutive_spaces > 0:
                outA.append(" " * nb_consecutive_spaces)
                nb_consecutive_spaces = 0
            position_modulo_ts = ( position_modulo_ts + 1 ) % conf.tab_stops
            outA.append(curr_char)
        prev_char = curr_char
    return ''.join(outA)

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
           #'graylogf':{"format":"%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s"},
           },
       'handlers':{
           'stdout':   {'level':level,'formatter': 'standard','class':'logging.StreamHandler',         'stream': 'ext://sys.stdout'},
           'file':     {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))}, #
           #'graylog': {'level':level,'formatter': 'graylogf','class':'pygelf.GelfTcpHandler',         'host': 'log.mydomain.local', 'port': 12201, 'include_extra_fields': True, 'debug': True, '_ide_script_name':script_name},
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})
    try: logging.getLogger('sh.command').setLevel(logging.WARN)
    except: pass

def parse_args(args):
    parser = argparse.ArgumentParser(description="Convert tabs (or vice-versa) in each FILE to spaces, writing to standard output. With no FILE, or when FILE is -, read standard input.")
    parser.add_argument("FILENAME", type=str, nargs='*', help="file to process")
    #parser.add_argument("-i", "--initial", help="do not convert after non-blank", action="store_true")
    parser.add_argument("-s", "--spaces", help="convert tabs to spaces", action="store_true")
    parser.add_argument("-t", "--tabs", help="convert spaces to tabs", action="store_true")
    #parser.add_argument("-n", "--no-auto", help="skips auto-detection of tab2space or space2tab detection", action="store_true")
    parser.add_argument("--tab-stops", type=int, default=4)
    ar = parser.parse_args(args)
    if ar.spaces and ar.tabs:
        raise BaseException("invalid combination of --spaces and --tabs")
    return ar

def detect(line, conf):
    if len(line) == 0:
        return None
    if line[0] not in [' ', "\t"]:
        return None
    if re.match(r'^\s+', line) is not None:
        return None
    new_conf = copy.deep_copy(conf)
    if line[0] == ' ':
        new_conf.spaces = True
    else:
        new_conf.tabs = True
    return new_conf

def output(line):
    print(line)

def go(args, iterator=None, outputter=output):
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    conf = parse_args(args)
    auto = False
    if not conf.spaces and not conf.tabs:
        auto = True
    if iterator is None:
        iterator = fileinput.input(files=conf.FILENAME)

    process(auto, conf, iterator, outputter)

def process(auto, conf, iterator, outputter=output):
    if auto:
        in_memory = []
    for line in map(str.rstrip, iterator):
        if auto:
            new_conf = detect(line, conf)
            if new_conf is not None:
                conf = new_conf
                for line2 in in_memory:
                    outputter(process_line(line2, conf))
                auto = False
                in_memory = None # release memory
                outputter(process_line(line, conf))
            else:
                in_memory.append(line)
            continue
        outputter(process_line(line, conf))
    if auto:
        for line2 in in_memory:
            outputter(process_line(line2, conf))

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logging.exception('oups for %s', sys.argv)
            #logging.error('oups for %s', sys.argv)
            #raise type(e), type(e)(e), sys.exc_info()[2]

