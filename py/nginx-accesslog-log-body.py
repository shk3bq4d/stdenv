#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import yaml
import codecs
import json
import gzip
import os
import fileinput
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

def print_yaml(i):
    print(yaml.dump(i))

def is_gzip(data: bytes) -> bool:
    return data.startswith(b"\x1f\x8b")

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

default_data = r"""
10.201.4.3 - - [20/Aug/2025:09:23:44 +0000] "POST /api/v2/trees/main%406c717c72fd1ccd62c7c3f31caf11ca1eaf9af27705b5b0b44cde02a06839b493/history/commit HTTP/1.1" 200 303 "-" "Java-http-client/11.0.28" -- \x1F\x8B\x08\x00\x00\x00\x00\x00\x00\x00m\x91QO\x830\x10\xC7\xDF\xFD\x14\x0D\xCF\xEB\xA0P`\xF3m3\xC4\x98h4:\x9F\xCCb\x8E\xF66PJ\x09\xED\x1E\x16\xB3\xEF.\x85\xB19\x95\x87\x92\xFE\xEF\xDF\xBB\xDF\xDD}]\x11\xE2\x09\xADTi\x1F\xD0\x82G\xAE\xC9W'ub\x01\xA6p\xD7zWU\x93A\x1A|\x16\xDB_:\xECl\xA1[\xE3\xD47\xE2\xA9v\xA7\xF4\x14\x9A\xC6#\xEB\xD1PU/\xE5\xB6F\xF9\xB8\xD9,\xF7\x83o\x8C)4\x06\xB6\xE8D\xEF\xE69[\xAC2\xB2Z,\xEF3\xD2\xA7q\x87Ec\xBD\x0B\x84U\xA9\xF0_\x86\x9F\x81N?\xB8\xA0\xA7\x1Bl\xC1\x96\xBA>\x12\x1E\x1B\xB4\xFBf\xA8\xFA\xF4\xBA\x1A\xD3\x7F\xE2\xFE<\x82\xEE\x8E\x15*\xAC\xED\xD8\x9A\xA3\xF1&\xC3\xBF\xA7\x22\xEB\xDEy8\xD1\xD5\xB6\xB3_\xA48\x95\xB9\xBB\xC9\x96\xD9\xF3\xED{\xDF\xDD\xB1`\x17/\xE5e'\xFDH,H\xB0p\xAFE\xCF\xDD?7\xD1\xB5\xEF\x97\x02sl\xB7T\x8A\x90\xAA\xB2\x82Z\x83\xF0\x1D\x8D?\x22\xBD'i\x98F\x1B\xB9\xA1\x11\x8FR\xCAe>\xA7\xF3$\x09)\xE3\x01\x0B\x99\x04\x06I\xEC\x8F\x15\xFC\xC0}T\xC6A\xC4\x99\x08\xE8,\x84\x9C\xF2Y\x9ERH\x81\xD3\x94\xA1\xC0y\x9C#\x8B\xD3\xE9\xF8f\xFAa:\xA4\x13\xAC\xA9\xA11\x85\xB6w}\x1F,\x9C\xB3\x803\xCE\x838\x9C%\xD1,I\xD9\xD9)\x0AT0\xF8\x82\xB3\xDA\xA0\xF8\xA3\xE9\xD6>\xB6\x12\xDBc\xE0b\xC8R\x8B\x9D[\xCAi4\xE3\xB2\xBBe\x1C\xBE\x01\xF0\x0A;v\xD0\x02\x00\x00
"""

log_pattern = re.compile(r"""
    (?P<ip>\d{1,3}(?:\.\d{1,3}){3})    # IP address
    \s+ - \s+ - \s+
    \[(?P<time>[^\]]+)\]               # Timestamp in [brackets]
    \s+
    "(?P<method>[A-Z]+)                # HTTP method
    \s+
    (?P<url>[^"]+)                     # Requested URL
    \s+
    (?P<protocol>HTTP/\d\.\d)"         # Protocol version
    \s+
    (?P<status>\d{3})                  # Status code
    \s+
    (?P<size>\d+)                      # Response size
    \s+
    "(?P<referrer>[^"]*)"              # Referrer
    \s+
    "(?P<user_agent>[^"]*)"            # User-Agent
    \s+ --
    (?:\s(?P<body>.*))?                 # Extra body/content
""", re.VERBOSE)

def get_data(ar):
    if 'VIMF6' in os.environ:
        for i in filter(None, map(str.rstrip, default_data.splitlines())):
            yield i
    else:
        for i in filter(None, map(str.rstrip, fileinput.input(files=ar.FILENAME))):
            yield i

def go(args) -> None:
    parser = argparse.ArgumentParser(description="Process nginx logs files or stdin, which adhere to a specific nginx log line template and pretty prints the HTTP client request body")
    parser.add_argument("FILENAME", type=str, nargs='?', help="file to process. Uses stdin otherwise")
    parser.add_argument("-b", "--include-requests-with-empty-body", action='store_true')
    ar = parser.parse_args(args)

    for line in get_data(ar):
        process(line, ar)

line_separator = "================"
body_separator = "== body"

def process(data, ar):
    m = log_pattern.match(data)
    if m:
        mH = m.groupdict()
        body = mH.pop('body')
        if body is not None:
            print(line_separator)
            print_yaml(mH)
            data = codecs.decode(body, "unicode_escape").encode("latin1")
            if is_gzip(data):
                data = gzip.decompress(data)
            try:
                jH = json.loads(data)
                print(body_separator + " json")
                print_yaml(jH)
            except BaseException as e:
                print(body_separator + " raw")
                print(data)
        else:
            if ar.include_requests_with_empty_body:
                print_yaml(mH)
    else:
        print(f"No match {data}")

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

