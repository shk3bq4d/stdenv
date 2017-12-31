#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
try:
    import cPickle as pickle
except:
    import pickle
import sys
import re
import argparse
import logging

from pprint import pprint

logger = logging.getLogger(__name__)

def logging_conf(
        level='INFO', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           },
       'handlers':{
           'stdout': {'level':level,'formatter': 'standard','class':'logging.StreamHandler','stream': 'ext://sys.stdout'},
           'file':   {'level':level,'formatter': 'standard','class':'logging.FileHandler','filename': '/tmp/zabbix-kg_maintenance.log'}, #
           'syslog': {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})

def go(args):
    # https://docs.python.org/2/library/argparse.html
    logger.info(__file__)
    logger.debug(__file__)
    parser = argparse.ArgumentParser(description="This is the description of what I do")
    parser.add_argument("FILENAME", type=str, nargs='+', help="file to process")
    ar = parser.parse_args(args)
    for k, f in enumerate(ar.FILENAME):
        if k > 1:
            print(u'')
        with open(f, 'rb') as fd:
            r = pickle.load(fd)
        print(u'f: ' + f)
        pprint(r)


if __name__ == '__main__':
    #reload(sys)
    #sys.setdefaultencoding('utf-8')

    logging_conf('ERROR')
    go(sys.argv[1:])

