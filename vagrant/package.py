#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from sh import vagrant
from sh import sha256sum
import json
import datetime
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

boxes_directory = os.path.expanduser('~/vagrant/boxes')

def boxname():
    script_directory, script_name = os.path.split(__file__)
    return os.path.basename(os.path.abspath(script_directory))

def metadata_filepath():
    return os.path.join(boxes_directory, '{}.json'.format(boxname()))

def metadata_content(version, box_filepath, box_sha256):
    fp = metadata_filepath()
    mH = {}
    if os.path.isfile(fp):
        with open(fp, 'rb') as f:
            try:
                mH = json.load(f)
            except BaseException as e:
                logger.warn('Exception parsing json %s', e)
    mH['name'] = boxname()
    mH['description'] = mH.get('description', '')
    mH['versions'] = mH.get('versions', [])
    vH = dict(
        version=version,
        providers=[dict(
            name='virtualbox',
            url='file://' + box_filepath,
            checksum_type='sha256',
            checksum=box_sha256
            )])
    mH['versions'].append(vH)
    return json.dumps(mH, indent=2)

def _box_filepath(version):
    return os.path.join(boxes_directory, '{}_{}.box'.format(boxname(), version))

def sha256(fp):
    return sha256sum(fp).split()[0]

def version_iterator():
    v = datetime.date.today().strftime('%Y.%m.%d')
    yield v
    i = 1
    while i < 200:
        yield '{}.{}'.format(v, i)
        i = i + 1

def box_version():
    for v in version_iterator():
        if not os.path.isfile(_box_filepath(v)):
            return v
    raise BaseException("Couldn't find suitable version. Ended at " + v)

def assert_valid_cwd():
    script_directory, script_name = os.path.split(__file__)
    fp = os.path.join(script_directory, 'Vagrantfile')
    if not os.path.isfile(fp):
        raise BaseException("Current dir {} does not contain a Vagrantfile".format(script_directory))

def write_metadata(version, box_filepath, box_sha256):
    # this needs to be called outside the open for writing
    content = metadata_content(version, box_filepath, box_sha256)
    fp = metadata_filepath()
    with open(fp, 'w') as f:
        f.write(content)

def go(args) -> None:
    assert_valid_cwd()
    v = box_version()
    box_filepath = _box_filepath(v)
    logger.info("Ready to 'vagrant package --output %s'", box_filepath)
    vagrant('package', '--output', box_filepath)
    logger.info("/done")
    checksum = sha256(box_filepath)
    write_metadata(v, box_filepath, checksum)

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

