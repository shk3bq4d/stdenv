#!/usr/bin/env python3

# This example shows how to implement a simple, but highly configurable window
# switcher (like a much improved "alt-tab") with iterative dmenu calls. This
# script works well for most use cases with no arguments.
#
# https://faq.i3wm.org/question/228/how-do-i-find-an-app-buried-in-some-workspace-by-its-title/

from argparse import ArgumentParser
from subprocess import check_output
from os.path import basename
import socket
import os
import re
import i3ipc

i3 = i3ipc.Connection()

parser = ArgumentParser(prog='i3-container-commander.py',
        description='''
        i3-container-commander.py is a simple but highly configurable
        dmenu-based script for creating dynamic context-based commands for
        controlling top-level windows. With no arguments, it is an efficient
        and ergonomical window switcher.
        ''',
        epilog='''
        Additional arguments found after "--" will be passed to dmenu.
        ''')

parser.add_argument('--group-by', metavar='PROPERTY',
        default='window_class',
        help='''A container property to initially group windows for selection or
        "none" to skip the grouping step. This works best for properties of
        type string. See <http://i3wm.org/docs/ipc.html#_tree_reply> for a list
        of properties. (default: "window_class")''')

parser.add_argument('--command', metavar='COMMAND',
        default='focus',
        help='''The command to execute on the container that you end up
        selecting. The command should be a single command or comma-separated
        list such as what is passed to i3-msg. The command will only affect the
        selected container (it will be selected by criteria). (default: "focus")''')

parser.add_argument('--item-format', metavar='FORMAT_STRING',
        #default='{workspace.name}: {container.name}',
        default='{container.name:<90s} ({workspace.name})',
        help='''A Python format string to use to display the menu items. The
        format string will have the container and workspace available as
        template variables. (default: '{workspace.name}: {container.name}')
        ''')


parser.add_argument('--menu',
        default='dmenu',
        help='The menu command to run (ex: --menu=rofi)')

(args, menu_args) = parser.parse_known_args()

if len(menu_args) and menu_args[0] == '--':
    menu_args = menu_args[1:]

small = socket.gethostname() in ['acer2011']
monitor1 = socket.gethostname() in ['ru'+'mo-pc']

# set default menu args for supported menus
if basename(args.menu) == 'dmenu':
    menu_args += ['-i', '-f', '-b', '-fn']
    if small:
        menu_args += ['DejaVuSansMono-11']
    else:
        menu_args += ['DejaVuSansMono-28']
    if monitor1:
        menu_args += ['-m', '1']


elif basename(args.menu) == 'rofi':
    menu_args += [ '-show', '-dmenu' ]


def find_group(container):
    return str(getattr(container, args.group_by)) if args.group_by != 'none' else ''

def show_menu(items, prompt):
    menu_input = bytes(str.join('\n', items), 'UTF-8')
    l = str(min(50, len(items)))
    menu_cmd = [ args.menu ] + ['-l', l] + menu_args
    menu_result = check_output(menu_cmd, input=menu_input)
    r = menu_result.decode('UTF-8').strip()
    print('show_menu r:{}'.format(r))
    return r

def show_container_menu(containers):
    #do_format = lambda c: args.item_format.format(workspace=c.workspace(), container=c)
    def do_format(c):
        if c.name is None:
            window = 'NONAME ERROR'
        else:
            window = c.name.strip()
        if window.endswith(' - Chromium'):
            window = 'Chromium - ' + window[:-10]
        windows = window.split('-', 1)
        from pprint import pprint
        pprint(windows)
        if len(windows) > 1 and len(window[0]) < 20:
            window = '{:<15s} {}'.format(*windows)
        workspace = c.workspace().name.strip()
        workspace = re.sub(r'^\d+\s+(.*)', r'\1', workspace)
        if small:
            f = '{:<100s} {}'
        else:
            f = '{:<120s} {}'
        return f.format(
            window,
            workspace
            )

    items = [do_format(c) for c in containers]
    items.sort()

    menu_result = show_menu(items, args.command)
    for c in containers:
        print('\n{}\n{}'.format(do_format(c), menu_result))
        if do_format(c).strip() == menu_result.strip():
            print('show_menu c:{}'.format(c))
            return c

containers = i3.get_tree().leaves()

if len(containers):
    chosen_container = show_container_menu(containers)

    if chosen_container:
        for cmd in args.command.split('&&'):
            chosen_container.command(cmd)
