#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from sh import kubectl
import yaml
import os
import sys
import re
import argparse
import logging

color = False
if sys.stdout.isatty() or os.environ.get('MRCOLORSAFE', '0') == '1':
    try:
        from pygments import highlight
        from pygments.lexers import YamlLexer
        from pygments.formatters import Terminal256Formatter, TerminalFormatter
        color = True
    except:
        pass


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

def walk(d):
    if isinstance(d, list):
        for i in d:
            walk(i)
    elif isinstance(d, dict):
        keys_to_delete = []
        for k,v in d.iteritems():
            if k in ['status', 'resourceVersion', 'selfLink', 'uid', 'generation', 'creationTimestamp', 'kubectl.kubernetes.io/last-applied-configuration']:
                keys_to_delete.append(k)
                continue
            walk(v)
        for k in keys_to_delete:
            del d[k]

def go(args):
    if 'get' not in args:
        args = ['get'] + args
    if '-o yaml' not in ' '.join(args):
        args = ['-o', 'yaml'] + args

    y = unicode(kubectl(*args))
    yH = yaml.load(y)
    walk(yH)
    s = yaml.dump(yH, default_flow_style=False)
    if color:
        highlight(s, YamlLexer(), Terminal256Formatter(), sys.stdout)
    else:
        print(s)

if __name__ == '__main__':

    logging_conf()
    go(sys.argv[1:])
