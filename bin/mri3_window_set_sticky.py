#!/usr/bin/env python3

import re
import os
import sys
from sh import xwininfo
import i3ipc
from pprint import pprint
import logging
logger = logging.getLogger(__name__)

def go(args):
    logger.info('->')
    i3 = i3ipc.Connection()
    if 1:
        bip = unicode(xwininfo('-int'))
    else:
        bip = u"""
xwininfo: Please select the window about which you
          would like information by clicking the
          mouse in that window.

xwininfo: Window id: 58720265 "ack window *py "

  Absolute upper-left X:  1926
            """

    i = re.search('Window id: ([0-9x]+)', bip).group(1)
    #pprint(vars(i3.get_tree().leaves()[9]))
    #print('\n- '.join(map(lambda x: '{:<12d} {}'.format(x.window, x.name), i3.get_tree().leaves())))
    #help(i3.get_tree())
    #return
    window = i3.get_tree().find_by_window(int(i))
    #pprint(window)
    #pprint(vars(window))
    if window.floating in ['user_on', 'auto_on']:
        window.command('floating disable')
        window.command('sticky disable')
        window.command('focus')
    else:
        pprint(window.command('floating enable'))
        window.command('sticky enable')

    #help(window)

    #window.command('sticky toggle'.format(id))

    return

    focused = i3.get_tree().find_focused()
    #pprint(vars(focused))


    if focused.orientation == 'vertical':
        container = focused
    elif focused.orientation == 'horizontal':
        container = focused.parent
    elif focused.parent.orientation == 'vertical':
        container = focused.parent
    else:
        container = focused
    idx = container.parent.nodes.index(container)
    if idx == 0:
        #for i in range(len(container.parent.nodes)): container.command('move right')
        container.command('move left')
    else:
        #other_container = container.parent.nodes[len(container.parent.nodes) - 1]
        other_container = container.parent.nodes[idx - 1]
        if False:
            cmd = 'swap container {} with {}'.format(container.id, other_container.id)
            logger.info(cmd)
            pprint(i3.command(cmd))
        if True:
            container.command('focus')
            cmd = 'swap container with con_id {}'.format(other_container.id)
            logger.info(cmd)
            container.command(cmd)
            focused.command('focus')

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

if __name__ == '__main__':
    #reload(sys)
    #sys.setdefaultencoding('utf-8')

    logging_conf(use='stdout syslog')
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e
sys.exit(0)
