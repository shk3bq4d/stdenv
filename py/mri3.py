#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */
#
# https://github.com/acrisci/i3ipc-python

import socket
import os
import math
import sys
import re
import copy
import argparse
import json
import unittest
import logging
import logging.config
import i3ipc

from pprint import pprint

logger = logging.getLogger(__name__)

class Mri3Test(unittest.TestCase):
    #def __init__(self, methodName='runTest'): pass
    def tearDown(self): pass
    def tearUp(self): pass

    @classmethod
    def setUpClass(cls): pass

    @classmethod
    def tearDownClass(cls): pass

    def test_workspace_name_index(self):
        for i in [
            ("0   $   ", 0),
            (0, 0),
            ("$", 0),
            ("1   &amp;   ", 1),
            ("1   &amp   ", 1),
            (1, 1),
            ("&amp;", 1),
            ("2   7   ", 2),
            (2, 2),
            ("7", 2),
            ("3   5   ", 3),
            (3, 3),
            ("5", 3),
            ("4   3   ",4),
            (4,4),
            ("3",4),
            ("5   1   ",5),
            (5,5),
            ("1",5),
            ("6   9   ",6),
            (6,6),
            ("9",6),
            ("7   0   ",7),
            (7,7),
            ("0",7),
            ("8   2   ",8),
            (8,8),
            ("2",8),
            ("9   4   ",9),
            (9,9),
            ("4",9),
            ("10   6   ",10),
            (10,10),
            ("6",10),
            ("11   8   ",11),
            (11,11),
            ("8",11),
            ("0   $ bip", 0),
            ("1   &amp; ampersand",1),
            ("4   3 three habon he",4),
            ("9   4 bip",9),
            ]:
            self.assertEqual(i[1], workspace_name_index(i[0]))#, msg="workspace_name_to_letter('{}') is supposed

    def test_workspace_name_to_letter(self):
        for i in [
            ("0   $   ", '$'),
            (0, '$'),
            ("$", '$'),
            ("1   &amp;   ", "&amp;"),
            ("1   &amp   ", "&amp;"),
            (1, "&amp;"),
            ("&amp;", "&amp;"),
            ("2   7   ", "7"),
            (2, "7"),
            ("7", "7"),
            ("3   5   ", "5"),
            (3, "5"),
            ("5", "5"),
            ("4   3   ", "3"),
            (4, "3"),
            ("3", "3"),
            ("5   1   ", "1"),
            (5, "1"),
            ("1", "1"),
            ("6   9   ", "9"),
            (6, "9"),
            ("9", "9"),
            ("7   0   ", "0"),
            (7, "0"),
            ("0", "0"),
            ("8   2   ", "2"),
            (8, "2"),
            ("2", "2"),
            ("9   4   ", "4"),
            (9, "4"),
            ("4", "4"),
            ("10   6   ", "6"),
            (10, "6"),
            ("6", "6"),
            ("11   8   ", "8"),
            (11, "8"),
            ("8", "8"),
            ("0   $ bip", "$"),
            ("1   &amp; ampersand", "&amp;"),
            ("4   3 three habon he", "3"),
            ("9   4 bip", "4"),
            (12, '#'),
            (13, None),
            (14, None),
            (-1, None),
            ]:
            self.assertEqual(i[1], workspace_name_to_letter(i[0]))#, msg="workspace_name_to_letter('{}') is supposed

    def test_queue_summary_alter(self):
        self.assertIn(   'a', 'abcde', msg='a is supposed to be in abcde')
        self.assertNotIn('z', 'abcde', msg='z is not supposed to be in abcde')
        # assertAlmostEqual assertAlmostEquals assertDictContainsSubset assertDictEqual
        # assertEqual assertEquals assertFalse assertGreater assertGreaterEqual
        # assertIn assertIs assertIsInstance assertIsNone assertIsNot assertIsNotNone
        # assertItemsEqual assertLess assertLessEqual assertListEqual assertMultiLineEqual
        # assertNotAlmostEqual assertNotAlmostEquals assertNotEqual assertNotEquals
        # assertNotIn assertNotIsInstance assertNotRegexpMatches assertRaises
        # assertRaisesRegexp assertRegexpMatches assertSequenceEqual assertSetEqual
        # assertTrue assertTupleEqual assert_ countTestCases debug defaultTestResult
        # doCleanups fail failIf failIfAlmostEqual failIfEqual failUnless failUnlessAlmostEqual
        # failUnlessEqual failUnlessRaises failureException id longMessage maxDiff
        # run setUp setUpClass shortDescription skipTest tearDown tearDownClass

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

def gethostname():
    return socket.gethostname()

def go(args):
    i3 = i3ipc.Connection()
    if 0: set_border_all()
    if 0:
        for i in traverse_all_elem(only_visible=True):
            debug(i, recursive=False, _print=True)
        return
    if 0:
        #help(i3)
        #help(i3.get_tree())
        #pprint(vars(i3.get_tree().nodes[0]))

        #debug(i3.get_tree(), _print=True)
        for w in get_root().workspaces():
            debug(w, _print=True)
    if 0:
        #remove_single_child_containers(i3.get_tree().find_focused().workspace())
        #remove_single_child_containers(i3.get_tree().find_focused())
        remove_single_child_containers(None)

    if 0:
        grid_layout()
    if 1: pprint(list(map(lambda x: x.name, workspaces())))
    if 0:
        #debug(i3.get_tree())
        for w in workspaces():
            if is_workspace_focused_within_output(w):
                print(w.name)
        #pprint(output_names())
        #pprint(workspace_names())
        #pprint(output_names())
        #pprint(vars(outputs()[0]))
        #pprint(outputs()[0])
        return
    if 0:
        #for i in traverse_all_elem(only_visible=True):
        pass

def debug(e, recursive=True, indent='', _rA=None, _print=True):
    #pprint(vars(e.props))
    pprint(vars(e))
    return

def python_object_id(i):
    # trying to extract 0x7f73b5787130 from <i3ipc.con.Con object at 0x7f73b5787130>
    i = str(i)
    m = re.search(' at (0x[0-9a-f]+)>', i)
    if m:
        return m.group(1)
    return None

def legacy_debug(e, recursive=True, indent='', _rA=None, _print=True, nb_recursion=0):
    if type(recursive) == int:
        if nb_recursion + 1 > recursive:
            return
        recursive_bool = True
    else:
        recursive_bool = recursive
    if _rA is None:
        _rA = []
    if e is not None:
        if type(e) == list:
            if nb_recursion != 0:
                raise BaseException("That wasn't expected'")
            for e2 in e:
                legacy_debug(e2, recursive=recursive, indent=indent, _rA=[], _print=_print, nb_recursion=nb_recursion)
            return
        #if e.focused: _rA.append('focused:')
        if len(e.marks) == 0:
            mmarks = ''
        else:
            mmarks = ' m:' + ','.join(e.marks)
        python_id = " {}".format(python_object_id(e))
    nb_recursion = nb_recursion + 1
    if e is None:
        _rA.append(u'{indent}Python None'.format(indent=indent))
    elif is_window(e):
        _rA.append(u'{indent}w:{window_class} "{name}" {id}{mmarks}{pyid}'.format(mmarks=mmarks, pyid=python_id, indent=indent, **vars(e)))
    elif e.type in ['workspace', 'root', 'output'] or True:
        extra = ''
        if e.type in ['workspace', 'con'] and e.layout is not None: extra = '{} {}'.format(extra, e.layout)
        if e.type in ['workspace', 'con'] and e.orientation is not None: extra = '{} {}'.format(extra, e.orientation)
        if e.name is not None and e.name.lower() != 'none': extra = '{} "{}"'.format(extra, e.name)
        extra = extra.strip()
        _rA.append(u'{indent}o:{type}: {extra} {id}{mmarks}{pyid}'.format(mmarks=mmarks, pyid=python_id, extra=extra, indent=indent, **vars(e)))
        if recursive_bool:
            for n in e.nodes:
                legacy_debug(n, recursive=recursive, indent=indent + ' ', _rA=_rA, _print=False, nb_recursion=nb_recursion)
    else:
        rA.append(u'{indent}container: {layout} {orientation}'.format(indent=indent, **vars(e)))
        if recursive_bool:
            for n in e.nodes:
                legacy_debug(n, recursive=recursive, indent=indent + ' ', _rA=_rA, _print=False, nb_recursion=nb_recursion)
    r = '\n'.join(_rA)
    if _print:
        print(r)
        return
    return r

def is_window(w):
    return w.window is not None

def is_append_layout_window(w):
    return is_window(w) and w.window_role is None and w.window_class is None

def is_container(n):
    return n.type == 'con' and not is_window(n)

def is_workspace(n):
    return n.type == 'workspace'

def is_workspace_focused(n):
    return focused().workspace().num == n.num

def is_workspace_focused_within_output(n):
    if n.type != 'workspace':
        raise BaseException('not a workspace')
    return is_con_focused_within_parent(n)

def is_con_focused_within_parent(n):
    return n.parent.focus.index(n.id) == 0

def traverse_all_elem(start_from=None, only_visible=False):
    rA = []
    root = get_root()
    if start_from:
        rA.append(start_from)
    elif only_visible:
        rA.extend(root.workspaces())
    else:
        rA.append(root)
    k = 0
    while k < len(rA):
        yield rA[k]
        rA.extend(rA[k].nodes)
        k = k + 1

def set_border_all():
    for e in traverse_all_elem():
        if e.type == 'con':
            e.command('border normal')

def get_root():
    return i3ipc.Connection().get_tree()

def remove_border_all():
    for e in traverse_all_elem():
        if e.type == 'con':
            e.command('border none')

def focused():
    return get_root().find_focused()

def remove_single_child_containers(c=None):
    current = focused()
    k = -1
    for n in traverse_all_elem(start_from=c, only_visible=True):
        for i in copy.copy(n.marks):
            if i.startswith('to-') or i.startswith('del-') or i.startswith('from-'):
                n.command('unmark ' + i)
    done = True
    cont = True
    while done and cont:
        done = False
        cont = False
        for n in traverse_all_elem(start_from=c, only_visible=True):
            if is_container(n) and len(n.nodes) == 1 and is_window(n.nodes[0]):
                k = k + 1
                debug(n.nodes[0], recursive=False, _print=True)
                if is_workspace(n.parent):
                    i = n.parent.nodes.index(n)
                    if 0 and i == 0:
                        logger.info('from workspace i:first')
                        if n.parent.orientation == 'vertical':
                            direction = 'up'
                        else:
                            direction = 'left'
                    elif 0 and i == len(n.parent.nodes) - 1:
                        logger.info('from workspace i:last')
                        if n.parent.orientation == 'vertical':
                            direction = 'down'
                        else:
                            direction = 'right'
                    else:
                        if i > 0 and is_window(n.parent.nodes[i - 1]):
                            logger.info('from workspace prev window')
                            if n.parent.orientation == 'vertical':
                                direction = 'up'
                            else:
                                direction = 'left'
                        elif i < len(n.parent.nodes) - 1 and is_window(n.parent.nodes[i + 1]):
                            logger.info('from workspace next window')
                            if n.parent.orientation == 'vertical':
                                direction = 'down'
                            else:
                                direction = 'right'
                        else:
                            logger.info('from workspace no resolution')
                            cont = True
                            continue
                    cmd = 'move {}'.format(direction)
                    logger.info('sending cmd %s to %s', cmd, debug(n.nodes[0], recursive=False))
                    n.nodes[0].command(cmd)
                    done = True
                else:
                    logger.info('not workspace')
                    n.parent.command('mark --add to-{}'.format(k))
                    n.command('mark --add del-{}'.format(k))
                    n.nodes[0].command('mark --add from-{}'.format(k))
                    #cmd = 'move scratchpad'
                    #n.nodes[0].command(cmd)
                    n.nodes[0].command('move to mark to-{}'.format(k))
                    done = True
    logger.info('returns %s', not cont)
    return not cont

    #current.command('focus')
    #c.command('focus')

def mrinspect(foA, foO):
    foA.append(foO)
    if foO['focused']:
        return True
    for i in foO['nodes']:
        if mrinspect(foA, i):
            return True
    foA.pop()
    return False

def grid_layout(cols=None, rows=None):
    if cols == 0: cols = 1
    if rows == 0: rows = 1
    def _name(c, r):
        i = ord('A')
        return '{}{}'.format(
            chr(i + c),
            r
            )
    key = '_grid_layout-unique-'
    current_windows = []
    for w in traverse_all_elem(focused().workspace()):
        for m in w.marks:
            if m.startswith(key):
                w.command('unmark ' + m)
        if is_append_layout_window(w):
            w.command('kill window')
            continue
        if is_window(w):
            current_windows.append(w)
    current_windows = sorted(current_windows, key=lambda x: (x.name, x.window))
    orientation = 'h'
    s = len(current_windows)
    if cols is None and rows is None:
        if s <= 3: return
        elif s <= 4: cols, rows = 2, 2
        elif s <= 6: cols, rows = 2, 3
        elif s <= 8: cols, rows = 2, 4
        elif s <= 9: cols, rows = 3, 3
        elif s <= 12: cols, rows = 3, 4
        elif s <= 15: cols, rows = 3, 5
        elif s <= 16: cols, rows = 4, 4
        elif s <= 20: cols, rows = 4, 5
        elif s <= 24: cols, rows = 4, 6
        elif s <= 25: cols, rows = 5, 5
        elif s <= 30: cols, rows = 5, 6
        elif s <= 35: cols, rows = 5, 7
        elif s <= 36: cols, rows = 6, 6
        elif s <= 49: cols, rows = 7, 7
        else:         cols, rows = 8, 8
    elif cols is None:
        cols = math.ceil(s / rows)
    elif rows is None:
        rows = math.ceil(s / cols)
    else:
        while rows * cols < s:
            if rows < cols:
                cols = cols + 1
            else:
                rows = rows + 1
    tH = dict(
        type='con',
        layout='split' + orientation,
        #border='none',
        #floating='auto_off',
        #percent=None,
        nodes=[],
        )
    o = 'v' if orientation == 'h' else 'h'
    for c in range(cols):
        cH = dict(
            #border='none',
            #floating='auto_off',
            type='con',
            #percent=0.5,
            layout='split' + o,
            nodes=[]
            )
        tH['nodes'].append(cH)
        for r in range(rows):
            rH = dict(
                #border='none',
                #current_border_width=0,
                #floating='auto_off',
                type='con',
                #percent=0.5,
                swallows=[
                    {'class':"will-never-be-satisfied- " + _name(c, r)}
                    ],
                #geometry=dict( height=628, width=884, x=0, y=0),
                name = _name(c, r),
                marks = [key + _name(c, r)]
                )
            cH['nodes'].append(rH)

    fp = '/tmp/grid'
    with open(fp, 'w') as f:
        json.dump(tH, f)
    focused().workspace().command('append_layout ' + fp)
    k = 0
    for c in range(cols):
        for r in range(rows):
            key_instance = '{}{}'.format(key, _name(c, r))
            if k < len(current_windows):
                current_windows[k].command('swap with mark {}'.format(key_instance))
                k = k + 1
    for w in traverse_all_elem(focused().workspace()):
        if is_append_layout_window(w):
            w.command('kill window')

    return tH

WORKSPACES_LETTER = [
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
'#']

WORKSPACES_NAMES = [
    "0   $   ",
    '"1   &amp;   "',
    "2   7   ",
    "3   5   ",
    "4   3   ",
    "5   1   ",
    "6   9   ",
    "7   0   ",
    "8   2   ",
    "9   4   ",
    "10   6   ",
    "11   8   ",
    "12   #   "
    ]

def workspace_name_index(i):
    return WORKSPACES_LETTER.index(workspace_name_to_letter(i))

def workspace_name_to_letter(i):
    if isinstance(i, int):
        if i < 0 or i >= len(WORKSPACES_LETTER):
            return None
        return WORKSPACES_LETTER[i]
    iA = i.split(None, 2)
    r = iA[0] if len(iA) == 1 else iA[1]
    if r == '&amp': r = '&amp;'
    return r

def mrFocusedStack():
    """ returns a list of container in which the latest is the focused window """
    import json
    import subprocess
    rA = []
    bString = subprocess.check_output(["i3-msg", "-t", "get_tree"])
    cO = json.loads(bString)
    rA = []
    mrinspect(rA, cO)
    return rA

def current_workspace():
    return focused().workspace()

def current_output():
    i3 = i3ipc.Connection()
    current_workspace_rectH = vars(current_workspace().parent.parent.rect)
    logger.info('A %s', current_workspace_rectH)
    for oH in i3.get_outputs():
        logger.info('B2 %s', vars(oH.rect))
       # logger.info('B %s', oH.rect.rect)
        if vars(oH.rect) == current_workspace_rectH:
            logger.info("Returning something as current output")
            return oH
    logger.warn("Returning None as current output")
    return None

def current_output_workspaces():
    i3 = i3ipc.Connection()
    oH = i3.get_outputs()

    current_output_rect = vars(current_output().rect)

    rA = []
    #logger.info("cow1 %s", current_output_rect)
    #logger.info("cow1b %d", len(get_root().workspaces()))
    for workspace in get_root().workspaces():
        #logger.info("cow2 %s", vars(workspace.parent.parent.rect))
        if vars(workspace.parent.parent.rect) == current_output_rect:
            rA.append(workspace)
    return rA

def get_output(o):
    if o is None: return None
    logger.info(f"get_output type {o.type} {o.name}")
    if o.type == 'output': return o
    if o.type == 'workspace' and o.parent is None:
        output_str = vars(o).get('ipc_data', {}).get('output', None)
        pprint(vars(o))
        pprint(vars(o).get('ipc_data', {}))
        logger.info(f'output_str is {output_str}')
        if output_str is not None:
            logger.info('A')
            i3 = i3ipc.Connection()
            for output in i3.get_outputs():
                logger.info(f'iterating output over {output.name} and comparing with {output_str}')
                if output.name == output_str:
                    return output
            logger.info('B')
        logger.info(f"Can't find output for {o.name}")
        raise BaseException(f"Can't find output for {o.name}")
    return get_output(o.parent)

def get_output_name(o):
    if o is None: return None
    return get_output(o).name

def workspacereplies():
    oA = i3ipc.Connection().get_workspaces()
    #oA = filter(lambda x: x.active, oA)
    return list(oA)

def workspacereply_names():
    return list(map(lambda x: x.name, workspaces()))

VIRTUAL_OUTPUT_NAME = '__i3'
def outputs(skip_virtual=True):
    def _outputs_inner(elem):
        for n in elem.nodes:
            if n.type == 'output':
                if skip_virtual and n.name == VIRTUAL_OUTPUT_NAME:
                    continue
                yield n
                # prune search as I guess an output can't have another output as parent
                continue
            elif n.type in ['dockarea', 'workspace', 'con']:
                # prune search as I guess those types can't have an output as children
                continue
            yield from _outputs_inner(n)

    return [x for x in _outputs_inner(get_root())]

def output_names(skip_virtual=True):
    return list(map(lambda x: x.name, outputs(skip_virtual=skip_virtual)))

SCRATCH_WORKSPACE_NAME = '__i3_scratch'
def workspaces(skip_scratch=True):
    def _workspaces_inner(elem):
        for n in elem.nodes:
            if n.type == 'workspace':
                if skip_scratch and n.name == SCRATCH_WORKSPACE_NAME:
                    continue
                yield n
                # prune search as I guess a workspace can't have another workspace as parent
                continue
            if n.type == 'dockarea':
                # prune search as I guess those types can't have an container as children
                continue
            yield from _workspaces_inner(n)

    return [x for x in _workspaces_inner(get_root())]

def workspace_names(skip_scratch=True):
    return list(map(lambda x: x.name, workspaces(skip_scratch=skip_scratch)))

def outputreplies():
    oA = i3ipc.Connection().get_outputs()
    oA = filter(lambda x: x.active, oA)
    return list(oA)

def outputreply_names():
    return list(map(lambda x: x.name, outputs()))

def renumber_workspaces():
    all_workspaces = copy.copy(get_root().workspaces())

    # exclude citrix apr16 desktop
    for k, w in enumerate(copy.copy(all_workspaces)):
        if w.name == '0   $   ':
            all_workspaces.pop(k)

    used_numbers = []
    spaces = 3 * ' '
    i3 = i3ipc.Connection()
    for k, w in enumerate(all_workspaces):
        number, left_over = re.match(r'^(\d*)\s*(.*?)\s*$', w.name).groups()
        new_name = '{k}{spaces}{left_over}{spaces}'.format(**locals())
        if w.name == new_name:
            logger.info("Not renaming %s (noop)", new_name)
            continue
        command = 'rename workspace "{}" to "{}"'.format(w.name, new_name)
        logger.info('executing %s as old name was _%s_', command, w.name)
        result = i3.command(command)
        logger.info(result)

if __name__ == '__main__':
    #reload(sys)
    #sys.setdefaultencoding('utf-8')
    if 'VIMF6' in os.environ and False:
        #unittest.main()
        logging_conf()
        renumber_workspaces()
    else:
        logging_conf()
        try:
            go(sys.argv[1:])
        except BaseException as e:
            #logging.exception('oups for %s', sys.argv)
            logging.exception('oups for %s', sys.argv)
            #raise type(e), type(e)(e), sys.exc_info()[2]
