#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import urllib
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

def go(args):
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMRUNTIME' in os.environ: args = ['-D', 'https://www.google.com/search?biw=2194&bih=1152&tbs=itp%3Alineart%2Cic%3Agray%2Cisz%3Alt%2Cislt%3Axga&tbm=isch&sa=1&ei=IV7lW9_fDMWYlwS0vaCwDQ&q=unicorn+funky&oq=unicorn+funky&gs_l=img.3..0i8i30k1l3.52551.54719.0.54919.10.8.2.0.0.0.101.650.7j1.8.0....0...1c.1.64.img..0.10.648...0j0i67k1j0i5i30k1j0i24k1.0.vEufixEdfVw']
    parser = argparse.ArgumentParser(description="Dequote URL to display in a human readable way")
    parser.add_argument("URL", type=str, nargs='+', help="file to process")
    parser.add_argument("-d", "--python-dict", help="outputs in python dict using the {} notation", action="store_true")
    parser.add_argument("-D", "--python-dict-function", help="outputs in python dict using the dict() notation", action="store_true")
    parser.add_argument("-y", "--yaml", help="outputs in yaml", action="store_true")
    parser.add_argument("-j", "--json", help="outputs in json in pretty mode", action="store_true")
    parser.add_argument("-J", "--json-not-pretty", help="outputs in json on one line", action="store_true")
    ar = parser.parse_args(args)
    p = not(ar.python_dict or ar.yaml or ar.json or ar.json_not_pretty or ar.python_dict_function)
    rH = dict()
    for k, url in enumerate(ar.URL):
        if k > 0: print('\n\n')
        print(url)
        urlA = urllib.splitquery(url)
        print(urlA[0])
        for q in urlA[1].split('&'):
            k, v = q.split('=', 1)
            v = urllib.unquote_plus(v)
            rH[k] = v
            if p: print('{}: {}'.format(k, v))

    if ar.python_dict:
        pprint(rH)
    if ar.python_dict_function:
        print('dict({})'.format(
            ', '.join(map(lambda x: '{}={}'.format(x, pformat(rH[x])), rH.keys()))))
    if ar.json:
        import json
        print(json.dumps(rH, indent=4))
    if ar.json_not_pretty:
        import json
        print(json.dumps(rH))
    if ar.yaml:
        import yaml
        print(yaml.safe_dump(dict(root=rH), default_flow_style=False))
        
    # pprint(ar)

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        #logging.exception('oups for %s', sys.argv)
        logging.error('oups for %s', sys.argv)
        raise type(e), type(e)(e), sys.exc_info()[2]

