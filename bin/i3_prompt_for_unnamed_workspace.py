#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

from pprint import pprint
import mrstack
import i3ipc
import sys
import os
import re
import logging
import sh


logger = logging.getLogger(__name__)

def auto(
        level='INFO', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    script_directory, script_name = os.path.split(__file__)
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           },
       'handlers':{
           'stdout': {'level':level,'formatter': 'standard','class':'logging.StreamHandler','stream': 'ext://sys.stdout'},
           'file': {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))}, #
           'syslog': {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})

english = \
{'0': 'zero', '1': 'one', '2': 'two', '3': 'three', '4': 'four', '5': 'five', '6': 'six', '7': 'seven', '8': 'eight', '9': 'nine',
'10': 'ten', '11': 'eleven', '12': 'twelve', '13': 'thirteen', '14': 'fourteen', '15': 'fifteen', '16': 'sixteen', '17': 'seventeen', '18': 'eighteen', '19': 'nineteen',
'20': 'twenty', '21': 'twenty-one', '22': 'twenty-two', '23': 'twenty-three', '24': 'twenty-four', '25': 'twenty-five', '26': 'twenty-six', '27': 'twenty-seven', '28': 'twenty-eight', '29': 'twenty-nine',
'30': 'thirty', '31': 'thirty-one', '32': 'thirty-two', '33': 'thirty-three', '34': 'thirty-four', '35': 'thirty-five', '36': 'thirty-six', '37': 'thirty-seven', '38': 'thirty-eight', '39': 'thirty-nine',
'40': 'fourty', '41': 'fourty-one', '42': 'fourty-two', '43': 'fourty-three', '44': 'fourty-four', '45': 'fourty-five', '46': 'fourty-six', '47': 'fourty-seven', '48': 'fourty-eight', '49': 'fourty-nine',
'50': 'fifty', '51': 'fifty-one', '52': 'fifty-two', '53': 'fifty-three', '54': 'fifty-four', '55': 'fifty-five', '56': 'fifty-six', '57': 'fifty-seven', '58': 'fifty-eight', '59': 'fifty-nine',
'60': 'sixty', '61': 'sixty-one', '62': 'sixty-two', '63': 'sixty-three', '64': 'sixty-four', '65': 'sixty-five', '66': 'sixty-six', '67': 'sixty-seven', '68': 'sixty-eight', '69': 'sixty-nine',
'$': 'dollar',
'%': 'percent',
'&': 'ampersand',
'&amp;': 'ampersand',
'#': 'hash',
'`': 'backquote',
}
mrstack_excludes = 'comm whatsapp bg vpn doc $ % & &amp; # `'.split()

names = [
'$',
'&amp;',
'7',
'5',
'3',
'1',
'9',
'0',
'2',
'4',
'6',
'8',
'!',
'#']
def mrdmenu(prompt, items):
    if 0:
        try:
            from sh import rofi
            #dmenu = rofi.bake('-dmenu').bake('-normal-window')
            dmenu = rofi.bake('-dmenu')
        except:
            from sh import dmenu
    else:
        from sh import dmenu
    import socket
    small = socket.gethostname() in ['acer2011']
    monitor1 = socket.gethostname() in ['ru'+'mo-pc']

    # set default menu args for supported menus
    menu_args = []
    #menu_args += ['-i', '-p', prompt, '-f', '-b', '-fn']
    menu_args += ['-i', '-f', '-b', '-fn']
    if small:
        menu_args += ['DejaVuSansMono-11']
    else:
        menu_args += ['DejaVuSansMono-28']
    if monitor1:
        menu_args += ['-m', '1']
    #menu_input = bytes(str.join('\n', items), 'UTF-8')
    menu_input = '\n'.join(items)
    l = str(max(1, min(50, len(items))))
    menu_cmd = ['-l', l] + menu_args
    pprint(menu_cmd)
    try:
        menu_result = dmenu(*menu_cmd, _in=menu_input)
    except sh.ErrorReturnCode_1 as e:
        menu_result = ''
    r = menu_result.strip()
    print('show_menu r:{}'.format(r))
    return r

def go(args=[]):
    logger.info('go()')
    i3 = i3ipc.Connection()
    debug_mode = len(args) > 0
    if debug_mode:
        ws = args[0]
    else:
        ws = i3.get_tree().find_focused().workspace().name
    logger.info('Current workspace is "{}"'.format(ws))

    words = ws.split()


    if len(words) != 1 and not re.match(r'^\d+\s+(\d+|&amp;?|[$&%`#])$',ws.strip()):
        logger.info('len(words), {} != 1'.format(len(words)))
        return

    ws_number = words[0]
    logger.info('ws_number is {}'.format(ws_number))

    proposalsH = {'comm':None,'whatsapp':None,'doc':None,'vpn':'~/bin/vpn-start.sh', 'bg':'~/bin/bg-start.sh'}
    proposals = [' '] + sorted(proposalsH.keys())
    if debug_mode:
        output = ' '.join(args[1:])
    else:
        #output = i3_input.go("w:")
        prompt = words[1] if len(words) > 1 else ws
        for i in range(6):
            proposals.append(' ')
        output = mrdmenu(prompt, proposals)
    logger.info('prompted value is {}'.format(output))
    if not debug_mode or True:
        i3.command('rename workspace to ' + workspace_name(ws_number, output, prepend_real_number=True, append_english=True, quotes=True))
        if output.strip() and output not in mrstack_excludes:
            mrstack.write(u'workspace: ' + unicode(output))
        if output in proposalsH:
            i3.command('exec ' + proposalsH[output])
            #from sh import bash
            #bash('-c', proposalsH[output])

def workspace_name(real_number, desired_name, append_english=False, prepend_real_number=False, quotes=False):

    try:
        converted_number = names[int(real_number)]
        display_number = converted_number
    except:
        converted_number = str(real_number)
        display_number = 'r' + str(real_number)

    if append_english and (desired_name is None or len(desired_name.strip()) == 0):
        desired_name = 'noid {}'.format(display_number)
        desired_name = 'noid'
        try:
            desired_name = english[converted_number]
        except:
            pass

    left_padding = right_padding = "   "
    #new_name = '"{left_padding}{ws} {desired_name}{right_padding}"'.format(**locals())
    new_name = '{display_number} {desired_name}'.format(**locals())
    new_name = new_name.strip()
    new_name = re.sub(r'\s+', ' ', new_name)
    if not new_name:
        left_padding = right_padding = ""
    if not prepend_real_number:
        real_number=''


    #ws = ws.strip()
    q = '"' if quotes else ''
    new_name = '{q}{real_number}{left_padding}{new_name}{right_padding}{q}'.format(**locals())
    logger.info('new_name is "{}"'.format(new_name))
    return new_name

if __name__ ==  "__main__":
    auto(use='stdout file syslog')
    print(go(sys.argv[1:]))
