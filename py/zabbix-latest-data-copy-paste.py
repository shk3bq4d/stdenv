#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

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

default_data = """
tag
Contains
value
ApplyReset

Host
Name
Last check\tLast value\tChange\tTags
\tSWWAP014P01
CPU utilization
2022-05-31 11:10:10\t4 %\t-1 %\tApplication: CPU\tGraph
\tSWWAP000P08
CPU utilization
2022-05-31 11:10:06\t70 %\t-11 %\tApplication: CPU\tGraph
\tSWWAP007P06
CPU utilization
2022-05-31 11:10:14\t94 %\t-3 %\tApplication: CPU\tGraph
\tSWWAP007P05
CPU utilization
2022-05-31 11:10:35\t12 %\t+7 %\tApplication: CPU\tGraph
\tSWWAP021P02
CPU utilization
2022-05-31 11:10:34\t5 %\t-2 %\tApplication: CPU\tGraph
\tSWWAP007P31
CPU utilization
2022-05-31 11:10:37\t28 %\t+3 %\tApplication: CPU\tGraph
Displaying 88 of 88 found
0 selectedDisplay stacked graphDisplay graph
Zabbix 5.4.12. © 2001–2022, Zabbix SIA
"""

def get_data(ar):
    if 'VIMF6' in os.environ: return default_data

    return "\n".join(filter(None, map(str.rstrip, fileinput.input(files=ar.FILENAME))))

def go(args) -> None:
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    parser = argparse.ArgumentParser(description="Process a Zabbix latest data page that has been copied in the clipboard")
    parser.add_argument("FILENAME", type=str, nargs='?', help="file to process. Uses stdin otherwise")
    # print(script_txt)
    ar = parser.parse_args(args)

    process(get_data(ar))

def process(data):
    pattern = "\t(.*)\n(.*)\n([^\t\n]*)\t([^\t\n]*)\t"
    for m in re.finditer(pattern, data):
        host, name, last_check, last_value = m.groups()
        print("{host:<35s} {last_value}".format(**locals()))
    # pprint(ar)

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

