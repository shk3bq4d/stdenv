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
    #logger.info(cmd)
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


def process_config_file(applied_options, config_filelist, filename, linenumber, criteria):
    logger.debug((len(applied_options.keys()), filename, linenumber, criteria))
    linenumber = int(linenumber)
    rH = copy.deepcopy(applied_options)
    rA = copy.deepcopy(config_filelist)
    if filename not in rA:
        rA.append(filename)
    for conf_linenumber, conf_line in filereader(filename):
        #logger.info((conf_linenumber, conf_line))
        if conf_linenumber <= linenumber: continue
        conf_line = re.sub('#.*', '', conf_line)
        conf_line = conf_line.strip()
        if conf_line == '': continue
        if re.search(r'^(Host|Match)\s', conf_line, flags=re.IGNORECASE) is not None:
            logger.debug('Aborting at line %s', conf_linenumber)
            break
        #logger.info(conf_line)
        option_name, option_value = re.split(r'\s+', conf_line, 1)
        option_name_lower = option_name.lower()
        if option_name_lower not in rH:
            # SshOption = namedtuple('SshOption', 'Name Value SourceFile LineNumber Criteria')
            rH[option_name_lower] = SshOption(option_name, option_value, filename, conf_linenumber, criteria)
    return rH, rA

def go(args):
    host = args[-1]
    args.insert(0, 'ConnectTimeout=5')
    args.insert(0, '-o')
    args.insert(0, '-vvv')
    args.insert(0, 'ssh')
    args.append('true')

    current_file = current_criteria = current_exec_linenumber = None
    # keys are the name of a valid SSH option, values are SshOption namedtuples
    applied_options = {}
    config_filelist = []
    errors = []
    for line in myrun(args):

        matcher = re.match(r'^debug1: Reading configuration data (.*)', line)
        if matcher is not None:
            current_file = current_criteria = current_exec_linenumber = None
            current_file = matcher.group(1)
            applied_options, config_filelist = process_config_file(
                applied_options,
                config_filelist,
                current_file,
                0,
                'No criteria'
                )
            continue

        matcher = re.match(r'^debug1: (?P<filename>.+) line (?P<linenumber>[0-9]+): Applying options for (?P<criteria>.*)', line)
        if matcher is not None:
            applied_options, config_filelist = process_config_file(applied_options, config_filelist, **matcher.groupdict())
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
                applied_options, config_filelist = process_config_file(
                    applied_options,
                    config_filelist,
                    current_file,
                    current_exec_linenumber,
                    current_criteria
                    )
            current_criteria = current_exec_linenumber = None
            continue

        # ssh: Could not resolve hostname bip: Name or service not known
        matcher = re.match(r'^ssh: Could not resolve hostname (.*): Name or service not known', line)
        if matcher is not None:
            errors.append(line)
            continue

    dump(host, config_filelist, applied_options, errors)

    if 'proxycommand' in applied_options:
        cmd = applied_options['proxycommand'].Value
        cmd = re.sub(r'^\s*ssh\s+', '', cmd) # removes leading ssh command
        cmd = re.sub(r'\B-q\b', '', cmd) # removes quiet option
        cmd = re.sub(r'\B-W\s+\S+\b', '', cmd) # removes -W %h:%p
        print('\n====================')
        go(cmd.split())

def dump(host, config_filelist, applied_options, errors):
    # SshOption = namedtuple('SshOption', 'Name Value SourceFile LineNumber Criteria')
    f = '{LineNumberColon:<5s}{Name:<26s} {Value:<40s} <= {Criteria}'
    f = '{LineNumberColon:<5s}{Name:<26s} {Value:<40s}'
    current_file = None
    print(host)
    if len(errors) > 0:
        print('- ' + '\n- '.join(errors))
    for i in sorted(applied_options.keys(), key=lambda x: (config_filelist.index(applied_options.get(x).SourceFile), applied_options.get(x).LineNumber)):
        v = applied_options.get(i)
        if v.SourceFile != current_file:
            current_file = v.SourceFile
            print('\n{}:'.format(current_file))
        print(f.format(
            LineNumberColon='{}:'.format(v.LineNumber),
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

