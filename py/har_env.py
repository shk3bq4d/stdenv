#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import textwrap
import datetime
import json
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

def print_yaml(i, indent=0):
    print(textwrap.indent(yaml.safe_dump(i), " " * indent))

def print_request_cookie(rH):
    cookie = None
    # rH['cookies'] contain more data, but headers has a sufficiently well formatted value
    for hH in rH['headers']:
        #print(hH['name'])
        if hH['name'].lower() == 'cookie':
            cookie = hH['value']
            break
    indent = " " * 20
    if cookie:
        print(f'{indent}cookies: {cookie}\n')

def print_entry(eH):
    ts_str = eH.get('startedDateTime') # '2021-07-22T12:00:34.111Z'
    ts = datetime.datetime.strptime(ts_str, '%Y-%m-%dT%H:%M:%S.%f%z')
    qH = eH['request']
    method = qH['method']
    pH = eH['response']
    status = pH['status']
    url = qH['url']
    short_url = url[:url.index("?") if "?" in url else len(url)]
    if  method == 'GET' and  \
        ( short_url.endswith('.css') or \
            short_url.endswith('.js') or \
            short_url.endswith('.txt') or \
            short_url.endswith('.ico') or \
            short_url.endswith('.svg') or \
            short_url.endswith('.png') or \
            short_url.endswith('.jpeg') or \
            pH['content']['mimeType'] in ['text/html'] or \
            False \
        ):
        print(f"{ts:%H:%M:%S.%f} {status} {qH['method']:<6s} {url}")
        return

    print(f"{ts:%H:%M:%S.%f} ->  {method:<6s} {url}")
    print_request_cookie(qH)
    bH = qH.get('postData', None)
    if bH:
        try:
            jH = json.loads(bH['text'])
            print_yaml(jH, 20)
        except:
            try:
                print_yaml(dict(formparams=bH['params']), 20)
            except:
                print(bH['text'])
            #del bH['text']
            #print_yaml(pH, 20)


    response_ts = ts + datetime.timedelta(milliseconds=eH['time'])
    try:
        jH = json.loads(pH['content']['text'])
    except:
        jH = None
    if status == 101 and url.startswith("wss:"):
        print(f"{response_ts:%H:%M:%S.%f} <-  {status} {pH['statusText']}")
    elif status >= 200 and status < 300:
        print(f"{response_ts:%H:%M:%S.%f} <-  {status} {pH['statusText']}")
        if jH:
            print_yaml(jH, 20)
        else:
            print_yaml(pH)
    elif status >= 300 and status < 400:
        print(f"{response_ts:%H:%M:%S.%f} <-  {status} {pH['statusText']}")
    elif status >= 400 and status < 500:
        print(f"{response_ts:%H:%M:%S.%f} <-  {status} {pH['statusText']}")
        if jH:
            print_yaml(jH, 20)
        else:
            print_yaml(pH)
            sys.exit(0)
    else:
        print(f"{response_ts:%H:%M:%S.%f} <-  {status} {pH['statusText']}")
    #print_yaml(eH['request'])
    if 0:
        print("->")
        print_yaml(qH)
        print("<-")
        print_yaml(pH)
        sys.exit(0)
    print()


def go(args) -> None:
    fp = '~/har/villars-hotel-panorama-webauth-transparent-still-within-duration.har'
    fp = '~/har/panopub.lan.har'
    fp = os.path.expanduser(fp)
    logger.debug("go for %s", fp)
    with open(fp, 'r') as f:
        logger.debug("reading")
        cH = json.load(f)
        logger.debug("/read")
    cH = cH['log']
    logger.debug(list(cH.keys()))
    logger.debug(cH['version'])
    logger.debug(cH['creator'])
    logger.debug(cH['pages'])
    for entry in cH['entries']:
        print_entry(entry)
    logger.debug("yaml dumped")

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

