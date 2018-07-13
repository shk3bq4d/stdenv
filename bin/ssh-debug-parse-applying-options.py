#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import copy
import os
import sys
import re
import logging
import subprocess
from collections import namedtuple

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

def myrun(cmd):
    """from http://blog.kagesenshi.org/2008/02/teeing-python-subprocesspopen-output.html
    """
    #p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    logger.info(cmd)
    while True:
        line = p.stdout.readline()
        line = re.sub(r'\r?\n$', '', line)
        if line == '' and p.poll() != None:
            break
        yield line

SshOption = namedtuple('SshOption', 'Name Value SourceFile LineNumber Criteria')

def filereader(filename):
    linenumber = 0
    with open(filename, 'rb') as f:
        while True:
            linenumber = linenumber + 1
            line = f.readline()
            if line == '': break
            line = re.sub(r'\r?\n$', '', line)
            yield linenumber, line


def process_config_file(applied_options, filename, linenumber, criteria):
    #logger.info((applied_options, filename, linenumber, criteria))
    linenumber = int(linenumber)
    rH = copy.deepcopy(applied_options)
    for conf_linenumber, conf_line in filereader(filename):
        #logger.info((conf_linenumber, conf_line))
        if conf_linenumber <= linenumber: continue
        conf_line = re.sub('#.*', '', conf_line)
        conf_line = conf_line.strip()
        if conf_line == '': continue
        if re.search(r'^(Host|Match)\s', conf_line, flags=re.IGNORECASE) is not None:
            break
        #logger.info(conf_line)
        option_name, option_value = re.split(r'\s+', conf_line, 1)
        option_name_lower = option_name.lower()
        if option_name_lower not in rH:
            # SshOption = namedtuple('SshOption', 'Name Value SourceFile LineNumber Criteria')
            rH[option_name_lower] = SshOption(option_name, option_value, filename, conf_linenumber, criteria)
    return rH

def go(args):
    logger.info(__file__)
    logger.debug(__file__)
    args.insert(0, '-vvv')
    args.insert(0, 'ssh')
    args.append('true')

    current_file = current_criteria = current_exec_linenumber = None
    # keys are the name of a valid SSH option, values are SshOption namedtuples
    applied_options = {}
    for line in myrun(args):

        matcher = re.match(r'^debug1: Reading configuration data (.*)', line)
        if matcher is not None:
            current_file = current_criteria = current_exec_linenumber = None
            current_file = matcher.group(1)
            continue

        matcher = re.match(r'^debug1: (?P<filename>.+) line (?P<linenumber>[0-9]+): Applying options for (?P<criteria>.*)', line)
        if matcher is not None:
            applied_options = process_config_file(applied_options, **matcher.groupdict())
            current_file = current_criteria = current_exec_linenumber = None
            continue

        # debug2: checking match for 'exec "test %l \\=\\= bob-pc" originalhost ubuntu-corp,ubuntu-corp-tunnel' host charlo originally charlo
        matcher = re.match(r'^debug2: checking match for (.*)', line)
        if matcher is not None:
            current_criteria = matcher.group(1)
            continue

        # debug3: /home/bob/.ssh/config line 148: matched
        matcher = re.match(r'^debug3: (.*) line (\d+): (not )?matched .*', line)
        if matcher is not None:
            current_file = matcher.group(1)
            current_exec_linenumber = matcher.group(2)
            continue

        # debug2: match not found
        matcher = re.match(r'^debug2: match (not )?found$', line)
        if matcher is not None:
            if matcher.group(1) is None:
                applied_options = process_config_file(
                    applied_options,
                    current_file,
                    current_exec_linenumber,
                    current_criteria
                    )
            current_criteria = current_exec_linenumber = None
            continue

    dump(applied_options)

def dump(applied_options):
    # SshOption = namedtuple('SshOption', 'Name Value SourceFile LineNumber Criteria')
    f = '{LineNumberColon:<5s}{Name:<26s} {Value:<40s} <= {Criteria}'
    current_file = None
    for i in sorted(applied_options.keys(), key=lambda x: (applied_options.get(x).SourceFile, applied_options.get(x).LineNumber)):
        v = applied_options.get(i)
        if v.SourceFile != current_file:
            current_file = v.SourceFile
            print('{}:'.format(current_file)
        print(f.format(
            LineNumberColon='{}:{}'.format(v.SourceFile, v.LineNumber),
            SourceFileNumber='{}:{}'.format(v.SourceFile, v.LineNumber),
            **v._asdict()
            ))

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

