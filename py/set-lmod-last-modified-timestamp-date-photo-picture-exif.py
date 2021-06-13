#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import unittest
import argparse
import datetime
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

from PIL import Image
def get_date_taken(path):
    magic_value = 36867
    exif = Image.open(path)._getexif()
    if exif is None: return None
    date_str = exif.get(magic_value, None)
    if date_str is None: return None
    try:
        return datetime.datetime.strptime(date_str, "%Y:%m:%d %H:%M:%S")
    except BaseException as e:
        logger.warn("couldn't parse %s due to %s", date_str, e)
        return None

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
    script_directory, script_name = os.path.split(__file__)
    script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    # print(script_txt)
    ar = parser.parse_args(args)
    for f in ar.FILENAME:
        process(f)

def process(f):
    d = get_date_taken(f)
    logger.info("%s %s", f, d)
    if d is not None:
        unix_timestamp = int(d.strftime('%s'))
        access_time = unix_timestamp
        modification_time = unix_timestamp
        os.utime(f, (access_time, modification_time))

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ:
        sys.argv.append(os.path.expanduser('~/Pictures/rumo-2010.jpeg'))
        sys.argv.append(os.path.expanduser('~/Pictures/2021-06-01_06-47.png'))
        sys.argv.append(os.path.expanduser('~/tmp/IMG_4283.JPEG'))
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups for %s', sys.argv)
        sys.exit(1)

