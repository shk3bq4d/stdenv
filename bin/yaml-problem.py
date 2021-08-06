#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import yaml
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
    parser = argparse.ArgumentParser(description="Reads a (incorrect) YAML file and returns the line number until which it's valid")
    parser.add_argument("FILENAME", type=str, help="file to process")
    script_directory, script_name = os.path.split(__file__)
    script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    # print(script_txt)
    ar = parser.parse_args(args)
    process(ar.FILENAME)

def process(fp):
    with open(fp, 'r') as f:
        lines = f.readlines()
    total_lines = len(lines)
    nb_lines = total_lines

    while nb_lines > 0:
        try:
            parsed_document = yaml.load('\n'.join(lines[:nb_lines]), Loader=yaml.FullLoader)
        except yaml.parser.ParserError:
            nb_lines = nb_lines -1
            continue

        break
    if nb_lines <= 0:
        print("Couldn't find any valid YAML document in subset of lines starting from first line")
        return
    if nb_lines == total_lines:
        print("Document is valid YAML file")
        return
    print(yaml.safe_dump(parsed_document))
    print(f'success at line {nb_lines} out ouf {total_lines}')
    print(f'First failing line content is {lines[nb_lines]}')



if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ and False:
        sys.argv.append(os.path.expanduser("~/git/bip.txt"))
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logger.exception('oups for %s', sys.argv)
        sys.exit(1)

