#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

try:
    import cPickle as pickle
except:
    import pickle
import sys
import os
try:
    import mri3
except:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3
import atexit
import getpass
import socket
import signal
import json
try:
    import cgi
    cgi.escape('test')
except:
    import html as cgi
import errno
import re
import argparse
import logging
import i3ipc
import subprocess
from sh import pkill
import fontawesome

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

def pid_exists(pid):
    """Check whether pid exists in the current process table.
    https://stackoverflow.com/questions/568271/how-to-check-if-there-exists-a-process-with-a-given-pid-in-python
    UNIX only.
    """
    if pid < 0:
        return False
    if pid == 0:
        # According to "man 2 kill" PID 0 refers to every process
        # in the process group of the calling process.
        # On certain systems 0 is a valid PID but we have no way
        # to know that in a portable fashion.
        raise ValueError('invalid PID 0')
    try:
        os.kill(pid, 0)
    except OSError as err:
        if err.errno == errno.ESRCH:
            # ESRCH == No such process
            return False
        elif err.errno == errno.EPERM:
            # EPERM clearly means there's a process to deny access to
            return True
        else:
            # According to "man 2 kill" possible error values are
            # (EINVAL, EPERM, ESRCH)
            raise
    else:
        return True

def logging_conf(
        level='INFO', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           },
       'handlers':{
           'stdout': {'level':level,'formatter': 'standard','class':'logging.StreamHandler','stream': 'ext://sys.stdout'},
           'file':   {'level':level,'formatter': 'standard','class':'logging.FileHandler','filename': '/tmp/zabbix-kg_maintenance.log'}, #
           'syslog': {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})


wA = None
fa = fontawesome.icons

def on_window(i3, e):
    logging.warn('on_window %s', e.change)
    i3blocklet(i3, e)
    if e.change == 'close':
        wid = e.container.window
        if wid in wA:
            wA.remove(wid)
            persist(wA)
    elif e.change == 'focus':
        #e.container.command('[class="[.]*"] border pixel 0')
        #e.container.command('border pixel 6')
        #e.container.command('gaps inner current plus 40')
        #e.container.command('gaps outer current plus 40')
        wid = e.container.window
        if wid in wA:
            wA.remove(wid)
        wA.append(wid)
        persist(wA)
    logging.warn('/on_window %s', e.change)

def blockpidcheck(pid):
    try:
        with open('/proc/{}/cmdline'.format(pid), mode='rb') as fd:
            content = fd.read().decode().split('\x00')[0]
    except Exception:
        return False
    logger.debug('pid: %s, content: %s', pid,  content)
    return content == 'i3blocks'

_lastpid = None
def blockpid():
    global _lastpid
    if _lastpid is not None:
        return _lastpid
    _lastpid = []
    for dirname in os.listdir('/proc'):
        if dirname == 'curproc':
            continue
        if blockpidcheck(dirname):
            _lastpid.append(int(dirname))
    return _lastpid

_machine = socket.gethostname()
_remove_user_at_host = r'(( - )?{}@{}(\.\w+\.(lan|local|net))?$|{}@{}(\.\w+\.(lan|local|net))?:?)'.format(
            getpass.getuser(),
            _machine,
            getpass.getuser(),
            _machine
            )
if _machine in ['dec17', 'acer2011']:
    border_width=1
else:
    border_width=3
def remove_user_at_host(name):
    return re.sub(_remove_user_at_host, '', name)

def focused_window_name(i3):
    window = i3.get_tree().find_focused()
    if window.type == 'workspace':
        logger.info('bop %s', window.type)
        name = ''
    else:
        logger.info('bip %s', window.type)
        name = window.name if window else ''
    return name

spanc = '<span color=\''
spane = '</span>'
def i3blocklet(i3, event):
    change = event.change
    if change in ('focus', 'title'):
        name = event.container.name
    elif change in ('close'):
        name = focused_window_name(i3)
    else:
        return
    i3blocklet_name(name)

_prev = None
def i3blocklet_name(name):
    global _prev
    if name == _prev:
        return
    name = name or ''
    _prev = name
    with open(i3blockraw_fp, 'wb') as f:
        f.write(name.encode())

    pid = blockpid()
    if pid is None: return
    border = '#000000'
    border_bottom=0
    short_text = None
    if 'urxvt' in name and re.match('^(\S{1,3}\s+)?urxvt', name):
        pre = post = ''
        if '\u2713' in name:
            pre = "{}green' weight='bold'>".format(spanc)
            post = spane
            border = '#008800'
            border_bottom = border_width
        elif '\u2718' in name:
            pre = "{}red' weight='bold'>".format(spanc)
            border = '#ff0000'
            border_bottom = border_width
            post = spane
        else:
            border = '#ffffff'
            border_bottom = border_width
        short_text = '{}{}{}'.format(pre, fa['terminal'], post)
        name = re.sub(r'^(?:(\S{1,3})\s+)?urxvt\s+(?:-\s*)?(.*)', '\\2', name)
        name = remove_user_at_host(name)
        name = name.replace(os.path.expanduser('~'), '~')
        full_text = '{} {}'.format(short_text, name)
    elif name.startswith('\u231b'):
        border_bottom = border_width
        border = '#FFAF00'
        short_text = "{}{}' weight='bold'>{} {}{}".format(spanc, border, '\u231b', fa['terminal'], spane)
        name = name[1:].strip()
        name = remove_user_at_host(name)
        name = name.replace(os.path.expanduser('~'), '~')
        full_text = '{} {}'.format(short_text, name)
    elif name.endswith(' - Stack Overflow - Chromium'):
        border_bottom = border_width
        border = '#F48021'
        short_text = "{}{}'>{}{}".format(spanc, border, fa['stack-overflow'], spane)
        name = re.sub('(.*?) - Stack Overflow - Chromium$', '\\1', name)
        name = cgi.escape(name)
        full_text = '{} {}'.format(short_text, name)
    elif name.endswith(' - Stack Exchange - Chromium'):
        border_bottom = border_width
        border = '#304F9A'
        short_text = "{}{}'>{}{}".format(spanc, border, fa['stack-exchange'], spane)
        name = re.sub('(.*?) - Stack Exchange - Chromium$', '\\1', name)
        name = cgi.escape(name)
        full_text = '{} {}'.format(short_text, name)
    elif name.endswith(' - Wikipedia - Chromium'):
        border_bottom = border_width
        border = '#717171'
        short_text = "{}{}'>{}{}".format(spanc, border, fa['wikipedia-w'], spane)
        name = cgi.escape(name)
        name = re.sub('(.*?) - Wikipedia - Chromium$', '\\1', name)
        full_text = '{} {}'.format(short_text, name)
    elif name.endswith(' - Google Search - Chromium'):
        border_bottom = border_width
        border = '#4483F3'
        short_text = "{}{}'>{}{}".format(spanc, border, fa['google'], spane)
        name = re.sub('(.*?) - Google Search - Chromium$', '\\1', name)
        name = cgi.escape(name)
        full_text = '{} {}'.format(short_text, name)
    elif name.endswith(' - Chromium'):
        border_bottom = border_width
        border = '#679CF7'
        short_text = "{}{}'>{}{}".format(spanc, border, fa['chrome'], spane)
        name = re.sub('(.*?) - Chromium$', '\\1', name)
        name = cgi.escape(name)
        full_text = '{} {}'.format(short_text, name)
    elif name.endswith(' - Mozilla Firefox'):
        border_bottom = border_width
        border = '#FE9400'
        short_text = "{}{}'>{}{}".format(spanc, border, fa['firefox'], spane)
        name = re.sub('(.*?) - Mozilla Firefox$', '\\1', name)
        name = cgi.escape(name)
        full_text = '{} {}'.format(short_text, name)
    elif name.startswith('vim'):
        border_bottom = border_width
        border = '#0F9636'
        short_text = "{}{}'>{}{}".format(spanc, border, fa['vimeo'], spane)
        name = re.sub('^vim - ', "".format(spanc, spane), name)
        name = remove_user_at_host(name)
        name = name.replace(os.path.expanduser('~'), '~')
        name = cgi.escape(name)
        full_text = '{}  {}'.format(short_text, name)
    else:
        full_text = name

    if short_text is None: short_text = full_text
        #short_text=short_text.replace('"', "'"), # reader can't read espaced double quote
    #full_text = full_text.replace(':', '')
    #full_text = full_text.replace('&', '&amp;')
    j = dict(
        full_text=full_text.replace('"', "'"), # reader can't read espaced double quote
        markup='pango',
        border=border,
        border_bottom=border_bottom,
        border_top=0,
        border_left=0,
        border_right=0,

        )
    # https://github.com/Airblader/i3
    # https://i3wm.org/docs/i3bar-protocol.html
    # { "full_text": "example", \
    #   "short_text": "10.0.0.1",
    #   "color": "\#FFFFFF", \
    #   "background": "\#222222", \
    #   "border": "\#9FBC00", \
    #   "border_bottom": 0 \
    #   "min_width": 300,
    #   "align": "right",
    #   "urgent": false,
    #   "name": "ethernet",
    #   "instance": "eth0",
    #   "separator": true,
    #   "separator_block_width": 9
    # }

    with open(i3block_fp, 'w') as f:
        json.dump(j, f, ensure_ascii=False) # reader can't read escaped unicode
        #json.dump(j, f)
        #f.write(name + '\n')

    s = signal.SIGUSR1 + signal.SIGRTMIN
    for p in pid:
        logger.info('sending signal %s to process %s', s, p)
        os.kill(p, s)

def on_workspace(i3, e):
    logging.warn('on_workspace %s', e.change)
    i3blocklet_name(focused_window_name(i3))
    mri3.remove_single_child_containers(None)
    return
    print_separator()
    print('Got workspace event:')
    print_time()
    print('Change: %s' % e.change)
    print('Current:')
    print_con_info(e.current)
    print('Old:')
    print_con_info(e.old)

def on_binding(i3, e):
    logging.debug(e.change)
    b = e.binding
    logger.debug(pformat(vars(b)))
    if \
        not(b.symbol == 'p' or \
        b.input_code == 27 ) or \
        b.input_type != 'keyboard' or \
        False:
        return
    c = '-'.join(b.mods)
    logger.warn(c)
    if 'shift-Mod4' == c:
        while len(wA) > 0:
            w = wA[0]
            del wA[0]
            if not exists(w):
                continue
            wA.append(w)
            focus(i3, w)
            break
        persist(wA)
        return
    if 'Mod4' == c:
        while len(wA) > 0:
            w = wA.pop()
            if not exists(w):
                continue
            wA.insert(0, w)
            w = wA[-1]
            focus(i3, w)
            break
        persist(wA)
        return

def exists(w):
    try:
        xprop = subprocess.check_output(['xprop', '-id', str(w)]).decode()
    except subprocess.CalledProcessError:
        return False
    except FileNotFoundError:
        raise SystemExit("The `xprop` utility is not found!"
                         " Please install it and retry.")
    #pprint(xprop)
    return True

def descendents_recursive(container, li=None):
    if li is None:
        li = []
    for d in container.descendents():
        if d not in li:
            li.append(d)
            descendents_recursive(d, li)
    return li

def find_window_id(container, window_id):
    for d in descendents_recursive(container):
        if d.window == window_id:
            return d
    return None

def find_workspace(i3, window_id):
    for workspace in i3.get_tree().workspaces():
        if find_window_id(workspace, window_id) is not None:
            return workspace
    return None

def focus(i3, window_id):
    workspace = find_workspace(i3, window_id)
    if workspace is not None:
        for container in descendents_recursive(workspace):
            if container.type == 'con' and container.fullscreen_mode:
                cmd = '[id="{}"] fullscreen'.format(container.window)
                logger.warn(cmd)
                i3.command(cmd)

    cmd = '[id="{}"] focus'.format(window_id)
    logger.warn(cmd)
    i3.command(cmd)


pickle_fp = os.environ['HOME'] +  '/.tmp/mri3_server.pickle'
def persist(bipA):
    with open(pickle_fp, 'wb') as f:
        pickle.dump(bipA, f)

def load():
    global wA
    try:
        with open(pickle_fp, 'rb') as f:
            wA = pickle.load(f)
        logger.warn('successfully loaded')
    except:
        logger.exception('error loading')
        wA = []

i3block_fp = os.path.expanduser('~/.tmp/mri3server-block.msg')
i3blockraw_fp = os.path.expanduser('~/.tmp/mri3server-rawname')

pid_fp = os.path.expanduser('~/.tmp/pid/mri3_server.pid')
def pidfile_cleanup():
    os.unlink(pid_fp)

def handle_concurrent_process():
    """ - if running in interactive mode, propose what to do:
          (kill other instance or abort)
        - else abort
    """
    if os.path.exists(pid_fp):
        with open(pid_fp, 'rb') as f:
            content = f.read().decode()
        if re.match(r'\d+', content):
            old_pid = int(content)
            if pid_exists(old_pid):
                if sys.stdin.isatty():
                    #sys.stdout.write
                    r = input('An existing instance run with pid {}. Would you like to kill it (y) or abort: '.format(old_pid))
                    logger.info('input was %s', r)
                    if r.strip().lower() != 'y':
                        return False
                    s = signal.SIGKILL
                    logger.info('sending signal %s to process %s', s, old_pid)
                    try:
                        os.kill(old_pid, s)
                    except BaseException as e:
                        logger.info('failed killing')
                        time.sleep(2)
                        if pid_exists(old_pid):
                            logger.info('so raising')
                            raise e
                        logger.info('but process is no longer')
                else:
                    logger.info('Existing process with pid %s', old_pid)
                    return False
            else:
                logger.info('No running process with old pid %s', old_pid)
        else:
            logger.info('Didn\'t read a number ("%s") out of %s', content, pid_fp)
    else:
        logger.info('Not a file %s', pid_fp)


    dp = os.path.dirname(pid_fp)
    if not os.path.exists(dp):
        os.mkdir(dp)
    with open(pid_fp, 'wb') as f:
        f.write(str(os.getpid()).encode())
    atexit.register(pidfile_cleanup)
    return True


def go(args):
    logger.warn('go')
    if not handle_concurrent_process():
        logger.warn('/go aborting because of concurrent running process')
        return
    i3 = i3ipc.Connection()
    load()
    i3.on('window', on_window)
    i3.on('workspace', on_workspace)
    i3.on('binding', on_binding)
    i3.main()
    logger.warn('/go')


if __name__ == '__main__':

    logging_conf(use='stdout syslog')
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

