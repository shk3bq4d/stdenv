#!/usr/bin/env python3
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
           'file':     {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': '/tmp/{}.log'.format(os.path.splitext(script_name)[0])}, #
           'syslog':   {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
           #'graylog': {'level':level,'formatter': 'graylogf','class':'pygelf.GelfTcpHandler',         'host': 'log.mydomain.local', 'port': 12201, 'include_extra_fields': True, 'debug': True, '_ide_script_name':script_name},
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})

def go(args):
    # https://docs.python.org/2/library/argparse.html
    parser = argparse.ArgumentParser(description="This is a convenience script to be used embedded in a 'docker run' call to expose each file in a host directory to the container. This allow for a virtual overlay mount which doesn't hide container files not exposed by the host directory")
    parser.add_argument("CONTAINER_FILES", type=str, nargs='*', default=[os.getcwd()], help="files or folders on the host containing the files to expose")
    parser.add_argument("-w", "--rw", action="store_true", help='if set, then files are exposed as read-write instead of the default read-only')
    parser.add_argument("-p", "--prefix", type=str, nargs='?', default='', help='prefix each container path with this value')
    #script_directory, script_name = os.path.split(__file__)
    #script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    #print(script_txt)
    ar = parser.parse_args(args)

    # prepare file list
    fA = []
    for f in ar.CONTAINER_FILES:
        f = os.path.realpath(f)
        if os.path.isfile(f):
            fA.append((os.getcwd(), f))
        elif os.path.isdir(f): 
            fA.extend(map(lambda x: (f, x), filter(lambda y: os.path.isfile(y), glob.glob('{}/**/*'.format(f), recursive=True))))
            #fA.extend(map(lambda x: (f, x), glob.glob('{}/*'.format(f))))
        else:
            logger.fatal('not a file nor a dir %s', f)

    #if not prefix.endswith('/'): ref = ref[:-1]
    for ref, f in fA:
        if ref.endswith('/'): ref = ref[:-1]
        print('-v {}:{}{}:{}'.format(
            f,
            ar.prefix,
            f[len(ref):],
            'rw' if ar.rw else 'ro'
            ))


if __name__ == '__main__':
    #reload(sys)
    #sys.setdefaultencoding('utf-8')

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

