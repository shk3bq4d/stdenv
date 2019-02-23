#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from sh import git
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

def abbreviated_hostname(hostname):
    return re.sub(r'\.com$', '', hostname)

def go(args):
    url = args[0]
    try:
        protocol, _, hostname, path = url.split('/', 3)
    except ValueError as e:
        logger.fatal("Doesn't look like a valid URL %s", url)
        return 1

    if protocol not in ['git:', 'https:']:
        logger.fatal("Unknown protocol {}".format(protocol))
        return 1
    if hostname not in ['gitlab.com', 'github.com']:
        logger.fatal("Unknown hostname {}".format(hostname))
        return 1
    hostname = abbreviated_hostname(hostname)
    path = re.sub(r'\.git$', '', path)
    clone_target = os.path.expanduser(
        '~/git/{hostname}/{path}'.format(**locals())
        )
    if os.path.exists(clone_target):
        logger.fatal("Target already exists %s", clone_target)
        return 1
    parent_dir = os.path.dirname(clone_target)
    if not os.path.isdir(parent_dir):
        os.makedirs(parent_dir)
    git(
        'clone',
        url,
        clone_target,
        _out=sys.stdout,
        _err=sys.stderr
        )
    with open(os.path.expanduser('~/.tmp/git-clone.py.txt'), 'wb') as f:
        f.write(clone_target)

    return 0



if __name__ == '__main__':

    logging_conf()
    try:
        r = go(sys.argv[1:])
    except BaseException as e:
        #logging.exception('oups for %s', sys.argv)
        logging.error('oups for %s', sys.argv)
        raise type(e), type(e)(e), sys.exc_info()[2]
    sys.exit(r)

