#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import hashlib
import os
import sys
import re
import argparse
import logging

from pprint import pprint, pformat

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
    #logger.info(__file__)
    #logger.debug(__file__)
    #help(hashlib)
    #args = ['ricardo']
    parser = argparse.ArgumentParser(description="Returns a unique email for the provider")
    parser.add_argument("identifier", type=str, help="site identifier")
    script_directory, script_name = os.path.split(__file__)
    script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    ar = parser.parse_args(args)
    h = hashlib.sha512(ar.identifier).hexdigest()
    print("""123r4p+{}{}@gmail.com
{}-{}@abc1.ch
password:
Abcd12.-{}
""".format(
        ar.identifier, h[:8],
        ar.identifier, h[:8],
        h[8:14]
        ))

if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf-8')

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

