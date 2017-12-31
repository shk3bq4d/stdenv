#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import argparse
import logging

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

def parse_xev_output():
    """ taken from a manual run of 'xev 2>&1 | grep -A3 KeyPress'
        Note: couldn't pipe output of grep for reason I couldn't explain,
              had to do a urxvt-print (Shift + PrintScreen)
    """
    raw = """

        state 0x1, keycode 47 (keysym 0x3a, colon), same_screen YES,
        state 0x0, keycode 49 (keysym 0x60, grave), same_screen YES,
        state 0x0, keycode 10 (keysym 0x31, 1), same_screen YES,
        state 0x0, keycode 11 (keysym 0x32, 2), same_screen YES,
        state 0x0, keycode 12 (keysym 0x33, 3), same_screen YES,
        state 0x0, keycode 13 (keysym 0x34, 4), same_screen YES,
        state 0x0, keycode 14 (keysym 0x35, 5), same_screen YES,
        state 0x0, keycode 15 (keysym 0x36, 6), same_screen YES,
        state 0x0, keycode 16 (keysym 0x37, 7), same_screen YES,
        state 0x0, keycode 17 (keysym 0x38, 8), same_screen YES,
        state 0x0, keycode 18 (keysym 0x39, 9), same_screen YES,
        state 0x0, keycode 19 (keysym 0x30, 0), same_screen YES,
        state 0x0, keycode 20 (keysym 0x2d, minus), same_screen YES,
        state 0x0, keycode 21 (keysym 0x3d, equal), same_screen YES,
        state 0x0, keycode 22 (keysym 0xff08, BackSpace), same_screen YES,
        state 0x0, keycode 23 (keysym 0xff09, Tab), same_screen YES,
        state 0x0, keycode 24 (keysym 0x71, q), same_screen YES,
        state 0x0, keycode 25 (keysym 0x77, w), same_screen YES,
        state 0x0, keycode 26 (keysym 0x65, e), same_screen YES,
        state 0x0, keycode 27 (keysym 0x72, r), same_screen YES,
        state 0x0, keycode 28 (keysym 0x74, t), same_screen YES,
        state 0x0, keycode 29 (keysym 0x79, y), same_screen YES,
        state 0x0, keycode 30 (keysym 0x75, u), same_screen YES,
        state 0x0, keycode 31 (keysym 0x69, i), same_screen YES,
        state 0x0, keycode 32 (keysym 0x6f, o), same_screen YES,
        state 0x0, keycode 33 (keysym 0x70, p), same_screen YES,
        state 0x0, keycode 34 (keysym 0x5b, bracketleft), same_screen YES,
        state 0x0, keycode 35 (keysym 0x5d, bracketright), same_screen YES,
        state 0x0, keycode 51 (keysym 0x5c, backslash), same_screen YES,
        state 0x0, keycode 66 (keysym 0xff1b, Escape), same_screen YES,
        state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
        state 0x0, keycode 39 (keysym 0x73, s), same_screen YES,
        state 0x0, keycode 40 (keysym 0x64, d), same_screen YES,
        state 0x0, keycode 41 (keysym 0x66, f), same_screen YES,
        state 0x0, keycode 42 (keysym 0x67, g), same_screen YES,
        state 0x0, keycode 43 (keysym 0x68, h), same_screen YES,
        state 0x0, keycode 44 (keysym 0x6a, j), same_screen YES,
        state 0x0, keycode 45 (keysym 0x6b, k), same_screen YES,
        state 0x0, keycode 46 (keysym 0x6c, l), same_screen YES,
        state 0x0, keycode 47 (keysym 0x3b, semicolon), same_screen YES,
        state 0x0, keycode 48 (keysym 0x27, apostrophe), same_screen YES,
        state 0x0, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
        state 0x0, keycode 52 (keysym 0x7a, z), same_screen YES,
        state 0x0, keycode 53 (keysym 0x78, x), same_screen YES,
        state 0x0, keycode 54 (keysym 0x63, c), same_screen YES,
        state 0x0, keycode 55 (keysym 0x76, v), same_screen YES,
        state 0x0, keycode 56 (keysym 0x62, b), same_screen YES,
        state 0x0, keycode 57 (keysym 0x6e, n), same_screen YES,
        state 0x0, keycode 58 (keysym 0x6d, m), same_screen YES,
        state 0x0, keycode 59 (keysym 0x2c, comma), same_screen YES,
        state 0x0, keycode 60 (keysym 0x2e, period), same_screen YES,
        state 0x0, keycode 61 (keysym 0x2f, slash), same_screen YES,
        state 0x0, keycode 62 (keysym 0xffe2, Shift_R), same_screen YES,
        state 0x0, keycode 36 (keysym 0xff0d, Return), same_screen YES,
    """
    code2sym = {}
    code2symbol = {}
    symbol2code = {}
    symbol2sym = {}

    pattern = r'keycode (\S+) .keysym ([^,)]+) ([^)]+)'
    pattern = r'keycode (\S+)(.)(.*)'
    pattern = r'keycode (\S+) .keysym ([^,)]+), ([^)]+)(.*)'
    for line in filter(lambda x: x.rstrip(), raw.splitlines()):
        matcher = re.search(pattern, line)
        if not matcher:
            logger.warn('line doesnt match %s', line)
            continue
        keycode, keysym, symbol, leftover  = matcher.groups()
        #print(keycode)
        #print(keysym)
        #print(symbol)
        #print(leftover)
        code2sym[keycode] = keysym
        code2symbol[keycode] = symbol
        symbol2code[symbol] = keycode
        symbol2sym[symbol] = keysym

    return (code2sym, code2symbol, symbol2code, symbol2sym)


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
           #'graylog': {'level':level,'formatter': 'graylogf','class':'pygelf.GelfTcpHandler',         'host': 'log.domain.local', 'port': 12201, 'include_extra_fields': True, 'debug': True, '_ide_script_name':script_name},
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})

def i3_fp():
    return '{}/.config/i3/config.template'.format(os.environ['HOME'])

def i3_config_lines():
    with open(i3_fp(), 'rb') as f:
        return map(str.rstrip, f.readlines())

def go(args):
    code2sym, code2symbol, symbol2code, symbol2sym = parse_xev_output()
    script_directory, script_name = os.path.split(__file__)
    for line in i3_config_lines():
        if not line.lstrip().startswith('bind') or \
            line.lstrip().startswith('binding_mode'):
            continue
        if line.lstrip().startswith('bindcode'):
            code = re.search(r'\+\s*(\d+)', line).groups()[0]
            try:
                add_line(new_file_lines, '# code:{} => sym: {}, symbol: {}\n{}'.format(
                    code,
                    code2sym[code],
                    code2symbol[code],
                    line
                    ))
            except BaseException as e:
                print('(for line: {})'.format(line))
                raise e
        elif line.lstrip().startswith('bindsym'):
            matcher = re.search(r'^(\s*)(bindsym)\s+((--release)\s+)*(((\$mod|shift|control)\s*\+\s*)*)(\w+)(.*)', line, flags=re.I)
            if matcher is None:
                raise BaseException('no bindsym match for ' + line)
            sym = matcher.groups()[7]
            if len(sym) == 1: sym = sym.lower() # lower case single letter
            if sym in ['Print', 'Down', 'Up', 'Right', 'Left', 'space', 'button4', 'button5', 'Return', 'Escape']:
                add_line(new_file_lines, line)
                continue
            code = symbol2code[sym]
            try:
                if 0:
                    add_line(new_file_lines, '# {} # {} # symbol:{} => sym: {}, code: {}'.format(
                        script_name,
                        line,
                        sym,
                        symbol2sym[sym],
                        symbol2code[sym]
                        ))
                add_line(new_file_lines, '# code:{} => sym: {}, symbol:{}\n{}{} {}{}{} {}'.format(
                    code,
                    code2sym[code],
                    code2symbol[code],
                    matcher.group(1) or '',
                    'bindcode',
                    matcher.group(3) or '',
                    matcher.group(5) or '',
                    code,
                    matcher.group(9)
                    ))
            except BaseException as e:
                print('(for line: {})'.format(line))
                raise e
        else:
            raise BaseException('Unknown start line: ' + line)
    write_lines(new_file_lines, None) #'/tmp/bip')

if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf-8')

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e
