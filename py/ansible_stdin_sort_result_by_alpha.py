#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from enum import Enum, auto
import textwrap
import os
import functools
import fileinput
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Dict, Tuple, no_type_check, Any, Optional
from collections.abc import Callable

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

class AnsibleStdinSortResultByAlphaTest(unittest.TestCase):
    def test_me(self) -> None:
        i = textwrap.dedent("""
            PLAY [Ansible Ad-Hoc] **********************************************************

            TASK [debug] *******************************************************************
            Thursday 23 January 2025  14:50:54 +0100 (0:00:00.067)       0:00:00.067 ******
            ok: [braz0140502] =>
              myvar: ''
            ok: [braz0140501] =>
              myvar: ''
            ok: [braz0140500] =>
              myvar: ''
            ok: [bisounours] =>
              myvar: ''
            ok: [habon] =>
              myvar: ''
            ok: [hehe] =>
              myvar: ''
            ok: [zoubi] =>
              myvar: ''
            ok: [aaabbbcc] =>
              myvar: ''
            ok: [animal] =>
              myvar: ''
            ok: [ylephant] =>
              myvar: ''
            ok: [mouais] =>
              myvar:
              - 10.102.1.8
              - 10.102.1.9
            ok: [non] =>
              myvar:
              - 10.102.1.8
              - 10.102.1.9
              """)
        o = textwrap.dedent("""
            ====
            aaabbbcc:
              myvar: ''
            animal:
              myvar: ''
            bisounours:
              myvar: ''
            braz0140500:
              myvar: ''
            braz0140501:
              myvar: ''
            braz0140502:
              myvar: ''
            habon:
              myvar: ''
            hehe:
              myvar: ''
            mouais:
              myvar:
              - 10.102.1.8
              - 10.102.1.9
            non:
              myvar:
              - 10.102.1.8
              - 10.102.1.9
            ylephant:
              myvar: ''
            zoubi:
              myvar: ''
              """).strip()
        self.assertEqual(process(i), o)

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

def read_string(i):
    for line in i.splitlines():
        yield line

def read_stdin():
    import fileinput # stdin
    filepath = '-' # or empty, stdin
    for line in fileinput.input(filepath): # stdin
        line = line.rstrip() # stdin fileinput
        if line == '': # stdin fileinput
            continue # stdin fileinput
        yield line

class State(Enum):
    UNKNOWN = auto()
    PLAY = auto()
    TASK = auto()
    HOST_RESULT = auto()
    PLAY_RECAP = auto()

def process(ii: Union[str, Callable]) -> None:
    if type(ii) == str:
        reader = functools.partial(read_string, ii)
    else:
        reader = ii

    taskAH = []

    current_state = State.UNKNOWN
    next_state = State.UNKNOWN
    current_host = None
    current_host_lines = []
    current_host = None
    current_taskH = None
    for line in reader():
        logger.info(f"{current_state} {line}")
        if re.match(r'^TASK \[', line) is not None:
            next_state = State.TASK
            current_host = None
            current_taskH = {}
            taskAH.append(current_taskH)
        elif re.match(r'^PLAY \[', line) is not None:
            next_state = State.PLAY
        elif re.match(r'^PLAY RECAP ', line) is not None:
            next_state = State.PLAY_RECAP
        else:
            if current_state == State.UNKNOWN:
                pass
            if current_state == State.PLAY:
                pass
            if current_state in [State.TASK, State.HOST_RESULT]:
                #if current_state == State.HOST_RESULT:
                matcher = re.match(r'^(ok|changed|failed): \[([^\]]+)\].*', line)
                if matcher:
                    next_state = State.HOST_RESULT
                    current_host = matcher.group(2)
                    current_taskH[current_host] = ''
                else:
                    if not current_host:
                        if False:
                            raise BaseException("No current host while consuming HOST_RESULT")
                    if current_host:
                        if current_taskH[current_host]:
                            current_taskH[current_host] = current_taskH[current_host] + '\n' + line.lstrip()
                        else:
                            current_taskH[current_host] = line.lstrip()


        if current_state == State.PLAY_RECAP:
            # consumes line until the end
            pass

        current_state = next_state

    rA = []
    for tH in taskAH:
        rA.append("====")
        for host in sorted(tH.keys()):
            rA.append(f"{host}:")
            rA.append(textwrap.indent(tH[host], "  "))
    return "\n".join(rA)



def go(args: List[str]) -> int:
    print(process(read_stdin))

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ:
        unittest.main()
    else:
        try:
            r = go(sys.argv[1:])
        except BaseException as e:
            logger.exception('oups for %s', sys.argv)
            sys.exit(1)
        sys.exit(r)

