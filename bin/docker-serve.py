#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
from sh import docker
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
    parser.add_argument("-r", "--root-dir", type=str, help="www root directory", default=".")
    parser.add_argument("-p", "--host-port", type=int, help="host port", default=8080)
    parser.add_argument("-b", "--host-bind", type=str, help="host interface bind", default="127.0.0.1")
    ar = parser.parse_args(args)
    pprint(ar)
    docker([
        'run',
        '--volume',
        '{}:/var/www/localhost/htdocs:ro'.format(os.path.realpath(ar.root_dir)),
        '--publish',
        '{}:{}:80'.format(ar.host_bind, ar.host_port),
        '-t',
        'sebp/lighttpd'
        ], _fg=True)


if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf-8')

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

