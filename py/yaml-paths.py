#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import glob
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


def serialize(d):
    return unicode(d).replace('\n', '\\n')

def walk(d, path=None):
    if path is None: path = []
    # https://stackoverflow.com/a/54000999
    #pprint(d)
    if isinstance(d, unicode) or isinstance(d, str) or isinstance(d, int) or isinstance(d, float):
        print("{}={}".format(".".join(path), serialize(d)))
        return
    for k,v in d.items():
        if isinstance(v, unicode) or isinstance(v, str) or isinstance(v, int) or isinstance(v, float):
            path.append(k)
            print("{}={}".format(".".join(path), serialize(v)))
            path.pop()
        elif v is None:
            path.append(k)
            # do something special
            path.pop()
        elif isinstance(v, list):
            path.append(k)
            if len(v) == 0:
                print("{}=[]".format(".".join(path)))
            for v_int in v:
               walk(v_int, path)
            path.pop()
        elif isinstance(v, dict):
            path.append(k)
            if len(v) == 0:
                print("{}={{}}".format(".".join(path)))
            walk(v, path)
            path.pop()
        else:
            print("###Type {} not recognized: {}.{}={}".format(type(v), ".".join(path),k, v))

def go(args):
    import yaml
    class folded_unicode(unicode): pass
    class literal_unicode(unicode): pass
    def folded_unicode_representer(dumper, data):
        return dumper.represent_scalar(u'tag:yaml.org,2002:str', data, style='>')
    def literal_unicode_representer(dumper, data):
        return dumper.represent_scalar(u'tag:yaml.org,2002:str', data, style='|')
    yaml.add_representer(folded_unicode, folded_unicode_representer)
    yaml.add_representer(literal_unicode, literal_unicode_representer)
    for filepath in args:
        with open(filepath, 'rb') as f:
            document_generator = yaml.load_all(f) # multi document read
            for k, rH in enumerate(document_generator):
                #pprint(rH)
                walk(rH)

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

