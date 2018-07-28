#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import datetime
import sys
import re
import argparse
import logging
import json

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

FP = os.path.expanduser('~/.tmp/mrstack.txt')
DT  = u'%Y.%m.%d %H:%M:%S'
OUT = u'{:<3d} {:%a %b%d %H:%M} {}'
IN  = u'{:%Y.%m.%d %H:%M:%S} {}\n'


def reader():
    if not os.path.isfile(FP): return
    with open(FP, 'rb') as f:
        #for line in f.readline():
        #for idx, line in enumerate(f.readline()):
        for idx, line in enumerate(f):
            line = line.strip()
            if line == '': continue
            words = line.split(' ', 3)
            #print(idx)
            #print(line)
            #pprint(words)
            #idx = words[0]
            try:
                dt = datetime.datetime.strptime(' '.join(words[0:1]), DT)
            except:
                dt = datetime.datetime.now()
            txt = unescape(words[2])
            yield idx, dt, txt

def escape(txt):
    r = txt
    r = r.strip()
    r = json.dumps(r)
    r = r[1:-1] # removes leading and trailing "
    return r

def unescape(txt):
    r = '"{}"'.format(txt)
    r = json.loads(r)
    return r

def write(txt):
    with open(FP, 'ab') as f:
        f.write(IN.format(
            datetime.datetime.now(),
            escape(txt)
            ))

def go_dump():
    for line in reader():
        print(OUT.format(*line))

def go_write(txtA):
    write(' '.join(txtA))

def go_delete(line_number):
    try:
        idx, dt, txt = next(i for i in reader() if i[0] == line_number)
    except StopIteration as e:
        print('No such line number {}'.format(line_number))
    response = raw_input("Are you sure you want do delete (y|N):\n{}\n".format(txt))
    if response.strip().lower() != 'y':
        print('OK, aborting')
        return
    print('proceed')
    

def go(args):
    # https://docs.python.org/2/library/argparse.html
    #logger.info(__file__)
    #logger.debug(__file__)
    parser = argparse.ArgumentParser(description="This is the description of what I do")
    parser.add_argument("TEXT", type=str, nargs='*', help="text to add")
    parser.add_argument("-d", "--delete", type=int, help="delete line number")
    #script_directory, script_name = os.path.split(__file__)
    #script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    #print(script_txt)
    ar = parser.parse_args(args)
    if ar.delete is not None:
        go_delete(ar.delete)
    elif len(ar.TEXT) == 0:
        go_dump()
    else:
        go_write(ar.TEXT)

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

