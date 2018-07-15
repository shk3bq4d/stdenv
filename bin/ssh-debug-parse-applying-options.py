#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from functools import partial
import argparse
import copy
import os
import sys
import re
import logging
import subprocess
from collections import namedtuple, OrderedDict

from pprint import pprint, pformat

logger = logging.getLogger(__name__)
if sys.stdout.isatty():
    NONE="\033[0m"    # unsets color to term's fg color
    BOLD="\033[1m"
    OFF="\033[m"
    BLACK="\033[0;30m"    # black
    RED="\033[0;31m"    # red
    GREEN="\033[0;32m"    # green
    YELLOW="\033[0;33m"    # yellow
    BLUE="\033[0;34m"    # blue
    MAGENTA="\033[0;35m"    # magenta
    CYAN="\033[0;36m"    # cyan
    WHITE="\033[0;37m"    # white
    EMBLACK="\033[1;30m"
    EMRED="\033[1;31m"
    EMGREEN="\033[1;32m"
    EMYELLOW="\033[1;33m"
    EMBLUE="\033[1;34m"
    EMMAGENTA="\033[1;35m"
    EMCYAN="\033[1;36m"
    EMWHITE="\033[1;37m"
    BGBLACK="\033[40m"
    BGRED="\033[41m"
    BGGREEN="\033[42m"
    BGYELLOW="\033[43m"
    BGBLUE="\033[44m"
    BGMAGENTA="\033[45m"
    BGCYAN="\033[46m"
    BGWHITE="\033[47m"
else:
    NONE=BOLD=OFF=BLACK=RED=GREEN=YELLOW=BLUE=MAGENTA=CYAN=\
        WHITE=EMBLACK=EMRED=EMGREEN=EMYELLOW=EMBLUE=EMMAGENTA=\
        EMCYAN=EMWHITE=BGBLACK=BGRED=BGGREEN=BGYELLOW=BGBLUE=\
        BGMAGENTA=BGCYAN=BGWHITE=''

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
#SshKey = namedtuple('SshKey', 'Name Source Result')
class SshKey:
    def __init__(self, name, source, result):
        self.Name = name
        self.Source = source
        self.Result = result
    def _asdict(self):
        r = vars(self)
        return r

def filereader(filename):
    linenumber = 0
    if not os.path.isfile(filename):
        logger.warn('Ignoring unexisting file %s. Likely a ssh-vvv from another machine', filename)
        return
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
    parser = argparse.ArgumentParser(description="Parses ssh -vvv output")
    #parser.add_argument("SSH_ARGS", type=str, nargs='*', help="SSH options + host. If not set, you'll have to provide your debugged output on stdin")
    script_directory, script_name = os.path.split(__file__)
    script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    ar, unknown = parser.parse_known_args(args)
    #pprint(unknown)
    if len(unknown) > 0:
        go_by_process(unknown)
    else:
        if sys.stdin.isatty():
            print('Please paste your ssh -vvv output and hit Enter, then Control-D')
            sys.stdout.flush()
        process(stdin_iterator)

def stdin_iterator():
    import fileinput
    for line in fileinput.input():
        line = line.strip()
        if line == '':
            continue
        yield line

def go_by_process(args):
    host = args[-1]
    args.insert(0, 'ControlMaster=no')
    args.insert(0, '-o')
    args.insert(0, 'ConnectTimeout=5')
    args.insert(0, '-o')
    args.insert(0, '-vvv')
    args.insert(0, 'ssh')
    args.append('true')
    iterator = partial(myrun, args)
    applied_options = process(iterator, host=host)
    if 'proxycommand' in applied_options:
        cmd = applied_options['proxycommand'].Value
        cmd = re.sub(r'^\s*ssh\s+', '', cmd) # removes leading ssh command
        cmd = re.sub(r'\B-q\b', '', cmd) # removes quiet option
        cmd = re.sub(r'\B-W\s+\S+\b', '', cmd) # removes -W %h:%p
        print('\n====================')
        go_by_process(cmd.split())

def process(iterator, host=None):
    current_file = current_criteria = current_exec_linenumber = None
    # keys are the name of a valid SSH option, values are SshOption namedtuples
    applied_options = {}
    config_filelist = []
    keysH = OrderedDict()
    num_password = 0
    last_key = None
    errors = []
    port = None
    ip = None
    no_longer_parsing = False
    for line in iterator():
        if no_longer_parsing: continue # gotta consume iterator until EOF

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

        # OpenSSH_7.5p1 Ubuntu-10ubuntu0.1, OpenSSL 1.0.2g  1 Mar 2016
        matcher = re.match(r'^OpenSSH', line)
        if matcher is not None:
            continue

        # ssh: Could not resolve hostname bip: Name or service not known
        matcher = re.match(r'^debug\d: ', line)
        if matcher is None:
            errors.append(line)
            continue

        # debug1: Connecting to myhost [myip] port 22.
        matcher = re.match(r'^debug1: Connecting to (.*) \[(.*)\] port (.*)\.$', line)
        if matcher is not None:
            host, ip, port = matcher.groups()
            continue

        # debug2: resolving "myhost" port 22
        matcher = re.match(r'^debug2: resolving "(.*)" port (.*)$', line)
        if matcher is not None:
            host, port = matcher.groups()
            continue

        #debug2: key: /home/bob/.ssh/id_rsa (0x560ec35uef0), agent
        matcher = re.match(r'^debug2: key: (.*) \((.*)\), (.*)', line)
        if matcher is not None and matcher.group(2) != '(nil)':
            s = keysH.get(matcher.group(1), SshKey(matcher.group(1), matcher.group(3), 'Unsent'))
            s.Source = matcher.group(3)
            s.Result = 'Unsent'
            keysH[matcher.group(1)] = s
            continue

        #debug1: Offering RSA public key: /home/bob/.ssh/id_rsa
        matcher = re.match(r'^debug1: Offering (\w+ )?public key: (.*)', line)
        if matcher is not None:
            last_key = matcher.group(2)
            if last_key not in keysH:
                s = SshKey(last_key, 'SourceUnknown', 'Offered')
                keysH[last_key] = s
            else:
                keysH[last_key].Result = 'Offered'
            continue

        #debug1: Authentication succeeded
        matcher = re.match(r'^debug1: Authentication succeeded.*', line)
        if matcher is not None:
            if last_key in keysH:
                keysH[last_key].Result = 'Accepted'
            continue

        #debug2: userauth_kbdint
        matcher = re.match(r'^debug2: userauth_kbdint', line)
        if matcher is not None:
            last_key = 'Keyboard-interactive#{}'.format(num_password)
            num_password = num_password + 1
            s = SshKey(last_key, '', 'Offered')
            keysH[last_key] = s
            continue

        # debug1: Entering interactive session.
        matcher = re.match(r'^debug1: Entering interactive session.', line)
        if matcher is not None:
            no_longer_parsing = True
            continue

        #debug3: receive packet: type 51
        matcher = re.match(r'^debug3: receive packet: type (\d+)', line)
        if matcher is not None:
            if matcher.group(1) in [
                '51', # authentication rejected, try next one
                '1',  # authentication rejected, will not allow you any other try
                ]:
                if last_key is not None:
                    s = keysH.get(last_key, None)
                    if s is not None:
                        s.Result = 'Rejected (Final)' if matcher.group(1) == '1' else 'Rejected'
                    last_key = None
                    continue


        #debug2: we did not send a packet, disable method
        matcher = re.match(r'^debug2: we did not send a packet, disable method', line)
        if matcher is not None:
            last_key = None
            continue

        #print(line)

    dump(host, ip, port, keysH, config_filelist, applied_options, errors)
    return applied_options


def dump(host, ip, port, keysH, config_filelist, applied_options, errors):
    # SshOption = namedtuple('SshOption', 'Name Value SourceFile LineNumber Criteria')
    f = '{LineNumberColon:<5s}{MAGENTA}{Name:<26s} {Value:<40s} <= {Criteria}'
    f = '{LineNumberColon:<5s}{MAGENTA}{Name:<26s}{NONE} {Value:<40s}'
    current_file = None
    if port is None:
        if 'port' in applied_options:
            port = applied_options['port']
        else:
            port = 22
    print('{BLUE}{host}{NONE}{toip}:{port}'.format(
        BLUE=BLUE,
        host=host,
        NONE=NONE,
        toip = '' if ip is None or ip == host else ' => {}'.format(ip),
        port=port
        ))
    if len(errors) > 0:
        print(RED + '- ' + '\n- '.join(errors) + NONE)

    if len(keysH) > 0:
        print('\nAuth:')
    for k,v in keysH.iteritems():
        v = copy.deepcopy(v._asdict())
        v['Source'] = '' if v['Source'] == '' else '({})'.format(v['Source'])
        v['Result'] += ':'
        print('{Result:<18s} {Name:<34s} {Source}'.format(**v))

    for i in sorted(applied_options.keys(), key=lambda x: (config_filelist.index(applied_options.get(x).SourceFile), applied_options.get(x).LineNumber)):
        v = applied_options.get(i)
        if v.SourceFile != current_file:
            current_file = v.SourceFile
            print('\n{}:'.format(GREEN + current_file + NONE))
        args = v._asdict()
        args['LineNumberColon'] ='{}:'.format(v.LineNumber)
        args['SourceFileNumber'] ='{}:{}'.format(v.SourceFile, v.LineNumber)
        #args['Name'] = MAGENTA + args['Name'] + NONE
        args['MAGENTA'] = MAGENTA
        args['NONE'] = NONE
        print(f.format(**args))

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

