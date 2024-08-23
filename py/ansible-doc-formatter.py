#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import mrpycolors as c
import yaml
import json
import os
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

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

false = False
true = True
null = None
git_doc =  \
{
    "git": {
        "doc": {
            "attributes": {
                "check_mode": {
                    "description": "Can run in check_mode and return changed status prediction without modifying target",
                    "support": "full"
                },
                "diff_mode": {
                    "description": "Will return details on what has changed (or possibly needs changing in check_mode), when in diff mode",
                    "support": "full"
                },
                "platform": {
                    "description": "Target OS/families that can be operated against",
                    "platforms": "posix",
                    "support": "N/A"
                }
            },
            "author": [
                "Ansible Core Team",
                "Michael DeHaan"
            ],
            "collection": "ansible.builtin",
            "description": [
                "Manage I(git) checkouts of repositories to deploy files or software."
            ],
            "filename": "/home/burp/.virtualenvs/ansible/lib/python3.10/site-packages/ansible/modules/git.py",
            "has_action": false,
            "module": "git",
            "notes": [
                "If the task seems to be hanging, first verify remote host is in C(known_hosts). SSH will prompt user to authorize the first contact with a remote host.  To avoid this prompt, one solution is to use the option accept_hostkey. Another solution is to add the remote host public key in C(/etc/ssh/ssh_known_hosts) before calling the git module, with the following command: ssh-keyscan -H remote_host.com >> /etc/ssh/ssh_known_hosts."
            ],
            "options": {
                "accept_hostkey": {
                    "default": "no",
                    "description": [
                        "Will ensure or not that \"-o StrictHostKeyChecking=no\" is present as an ssh option.",
                        "Be aware that this disables a protection against MITM attacks.",
                        "Those using OpenSSH >= 7.5 might want to set I(ssh_opt) to 'StrictHostKeyChecking=accept-new' instead, it does not remove the MITM issue but it does restrict it to the first attempt."
                    ],
                    "type": "bool",
                    "version_added": "1.5",
                    "version_added_collection": "ansible.builtin"
                },
                "accept_newhostkey": {
                    "default": "no",
                    "description": [
                        "As of OpenSSH 7.5, \"-o StrictHostKeyChecking=accept-new\" can be used which is safer and will only accepts host keys which are not present or are the same. if C(yes), ensure that \"-o StrictHostKeyChecking=accept-new\" is present as an ssh option."
                    ],
                    "type": "bool",
                    "version_added": "2.12",
                    "version_added_collection": "ansible.builtin"
                },
                "archive": {
                    "description": [
                        "Specify archive file path with extension. If specified, creates an archive file of the specified format containing the tree structure for the source tree. Allowed archive formats [\"zip\", \"tar.gz\", \"tar\", \"tgz\"].",
                        "This will clone and perform git archive from local directory as not all git servers support git archive."
                    ],
                    "type": "path",
                    "version_added": "2.4",
                    "version_added_collection": "ansible.builtin"
                },
                "archive_prefix": {
                    "description": [
                        "Specify a prefix to add to each file path in archive. Requires I(archive) to be specified."
                    ],
                    "type": "str",
                    "version_added": "2.10",
                    "version_added_collection": "ansible.builtin"
                },
                "bare": {
                    "default": "no",
                    "description": [
                        "If C(yes), repository will be created as a bare repo, otherwise it will be a standard repo with a workspace."
                    ],
                    "type": "bool",
                    "version_added": "1.4",
                    "version_added_collection": "ansible.builtin"
                },
                "clone": {
                    "default": "yes",
                    "description": [
                        "If C(no), do not clone the repository even if it does not exist locally."
                    ],
                    "type": "bool",
                    "version_added": "1.9",
                    "version_added_collection": "ansible.builtin"
                },
                "depth": {
                    "description": [
                        "Create a shallow clone with a history truncated to the specified number or revisions. The minimum possible value is C(1), otherwise ignored. Needs I(git>=1.9.1) to work correctly."
                    ],
                    "type": "int",
                    "version_added": "1.2",
                    "version_added_collection": "ansible.builtin"
                },
                "dest": {
                    "description": [
                        "The path of where the repository should be checked out. This is equivalent to C(git clone [repo_url] [directory]). The repository named in I(repo) is not appended to this path and the destination directory must be empty. This parameter is required, unless I(clone) is set to C(no)."
                    ],
                    "required": true,
                    "type": "path"
                },
                "executable": {
                    "description": [
                        "Path to git executable to use. If not supplied, the normal mechanism for resolving binary paths will be used."
                    ],
                    "type": "path",
                    "version_added": "1.4",
                    "version_added_collection": "ansible.builtin"
                },
                "force": {
                    "default": "no",
                    "description": [
                        "If C(yes), any modified files in the working repository will be discarded.  Prior to 0.7, this was always C(yes) and could not be disabled.  Prior to 1.9, the default was C(yes)."
                    ],
                    "type": "bool",
                    "version_added": "0.7",
                    "version_added_collection": "ansible.builtin"
                },
                "gpg_whitelist": {
                    "default": [],
                    "description": [
                        "A list of trusted GPG fingerprints to compare to the fingerprint of the GPG-signed commit.",
                        "Only used when I(verify_commit=yes).",
                        "Use of this feature requires Git 2.6+ due to its reliance on git's C(--raw) flag to C(verify-commit) and C(verify-tag)."
                    ],
                    "elements": "str",
                    "type": "list",
                    "version_added": "2.9",
                    "version_added_collection": "ansible.builtin"
                },
                "key_file": {
                    "description": [
                        "Specify an optional private key file path, on the target host, to use for the checkout.",
                        "This ensures 'IdentitiesOnly=yes' is present in ssh_opts."
                    ],
                    "type": "path",
                    "version_added": "1.5",
                    "version_added_collection": "ansible.builtin"
                },
                "recursive": {
                    "default": "yes",
                    "description": [
                        "If C(no), repository will be cloned without the --recursive option, skipping sub-modules."
                    ],
                    "type": "bool",
                    "version_added": "1.6",
                    "version_added_collection": "ansible.builtin"
                },
                "reference": {
                    "description": [
                        "Reference repository (see \"git clone --reference ...\")."
                    ],
                    "version_added": "1.4",
                    "version_added_collection": "ansible.builtin"
                },
                "refspec": {
                    "description": [
                        "Add an additional refspec to be fetched. If version is set to a I(SHA-1) not reachable from any branch or tag, this option may be necessary to specify the ref containing the I(SHA-1). Uses the same syntax as the C(git fetch) command. An example value could be \"refs/meta/config\"."
                    ],
                    "type": "str",
                    "version_added": "1.9",
                    "version_added_collection": "ansible.builtin"
                },
                "remote": {
                    "default": "origin",
                    "description": [
                        "Name of the remote."
                    ],
                    "type": "str"
                },
                "repo": {
                    "aliases": [
                        "name"
                    ],
                    "description": [
                        "git, SSH, or HTTP(S) protocol address of the git repository."
                    ],
                    "required": true,
                    "type": "str"
                },
                "separate_git_dir": {
                    "description": [
                        "The path to place the cloned repository. If specified, Git repository can be separated from working tree."
                    ],
                    "type": "path",
                    "version_added": "2.7",
                    "version_added_collection": "ansible.builtin"
                },
                "single_branch": {
                    "default": "no",
                    "description": [
                        "Clone only the history leading to the tip of the specified revision."
                    ],
                    "type": "bool",
                    "version_added": "2.11",
                    "version_added_collection": "ansible.builtin"
                },
                "ssh_opts": {
                    "description": [
                        "Options git will pass to ssh when used as protocol, it works via C(git)'s GIT_SSH/GIT_SSH_COMMAND environment variables.",
                        "For older versions it appends GIT_SSH_OPTS (specific to this module) to the variables above or via a wrapper script.",
                        "Other options can add to this list, like I(key_file) and I(accept_hostkey).",
                        "An example value could be \"-o StrictHostKeyChecking=no\" (although this particular option is better set by I(accept_hostkey)).",
                        "The module ensures that 'BatchMode=yes' is always present to avoid prompts."
                    ],
                    "type": "str",
                    "version_added": "1.5",
                    "version_added_collection": "ansible.builtin"
                },
                "track_submodules": {
                    "default": "no",
                    "description": [
                        "If C(yes), submodules will track the latest commit on their master branch (or other branch specified in .gitmodules).  If C(no), submodules will be kept at the revision specified by the main project. This is equivalent to specifying the --remote flag to git submodule update."
                    ],
                    "type": "bool",
                    "version_added": "1.8",
                    "version_added_collection": "ansible.builtin"
                },
                "umask": {
                    "description": [
                        "The umask to set before doing any checkouts, or any other repository maintenance."
                    ],
                    "type": "raw",
                    "version_added": "2.2",
                    "version_added_collection": "ansible.builtin"
                },
                "update": {
                    "default": "yes",
                    "description": [
                        "If C(no), do not retrieve new revisions from the origin repository.",
                        "Operations like archive will work on the existing (old) repository and might not respond to changes to the options version or remote."
                    ],
                    "type": "bool",
                    "version_added": "1.2",
                    "version_added_collection": "ansible.builtin"
                },
                "verify_commit": {
                    "default": "no",
                    "description": [
                        "If C(yes), when cloning or checking out a I(version) verify the signature of a GPG signed commit. This requires git version>=2.1.0 to be installed. The commit MUST be signed and the public key MUST be present in the GPG keyring."
                    ],
                    "type": "bool",
                    "version_added": "2.0",
                    "version_added_collection": "ansible.builtin"
                },
                "version": {
                    "default": "HEAD",
                    "description": [
                        "What version of the repository to check out. This can be the literal string C(HEAD), a branch name, a tag name. It can also be a I(SHA-1) hash, in which case I(refspec) needs to be specified if the given revision is not already available."
                    ],
                    "type": "str"
                }
            },
            "requirements": [
                "git>=1.7.1 (the command line tool)"
            ],
            "short_description": "Deploy software (or files) from git checkouts",
            "version_added": "0.0.1",
            "version_added_collection": "ansible.builtin"
        },
        "examples": "\n- name: Git checkout\n  ansible.builtin.git:\n    repo: 'https://foosball.example.org/path/to/repo.git'\n    dest: /srv/checkout\n    version: release-0.22\n\n- name: Read-write git checkout from github\n  ansible.builtin.git:\n    repo: git@github.com:mylogin/hello.git\n    dest: /home/mylogin/hello\n\n- name: Just ensuring the repo checkout exists\n  ansible.builtin.git:\n    repo: 'https://foosball.example.org/path/to/repo.git'\n    dest: /srv/checkout\n    update: no\n\n- name: Just get information about the repository whether or not it has already been cloned locally\n  ansible.builtin.git:\n    repo: 'https://foosball.example.org/path/to/repo.git'\n    dest: /srv/checkout\n    clone: no\n    update: no\n\n- name: Checkout a github repo and use refspec to fetch all pull requests\n  ansible.builtin.git:\n    repo: https://github.com/ansible/ansible-examples.git\n    dest: /src/ansible-examples\n    refspec: '+refs/pull/*:refs/heads/*'\n\n- name: Create git archive from repo\n  ansible.builtin.git:\n    repo: https://github.com/ansible/ansible-examples.git\n    dest: /src/ansible-examples\n    archive: /tmp/ansible-examples.zip\n\n- name: Clone a repo with separate git directory\n  ansible.builtin.git:\n    repo: https://github.com/ansible/ansible-examples.git\n    dest: /src/ansible-examples\n    separate_git_dir: /src/ansible-examples.git\n\n- name: Example clone of a single branch\n  ansible.builtin.git:\n    repo: https://github.com/ansible/ansible-examples.git\n    dest: /src/ansible-examples\n    single_branch: yes\n    version: master\n\n- name: Avoid hanging when http(s) password is missing\n  ansible.builtin.git:\n    repo: https://github.com/ansible/could-be-a-private-repo\n    dest: /src/from-private-repo\n  environment:\n    GIT_TERMINAL_PROMPT: 0 # reports \"terminal prompts disabled\" on missing password\n    # or GIT_ASKPASS: /bin/true # for git before version 2.3.0, reports \"Authentication failed\" on missing password\n",
        "metadata": null,
        "return": {
            "after": {
                "description": "Last commit revision of the repository retrieved during the update.",
                "returned": "success",
                "sample": "4c020102a9cd6fe908c9a4a326a38f972f63a903",
                "type": "str"
            },
            "before": {
                "description": "Commit revision before the repository was updated, \"null\" for new repository.",
                "returned": "success",
                "sample": "67c04ebe40a003bda0efb34eacfb93b0cafdf628",
                "type": "str"
            },
            "git_dir_before": {
                "description": "Contains the original path of .git directory if it is changed.",
                "returned": "success",
                "sample": "/path/to/old/git/dir",
                "type": "str"
            },
            "git_dir_now": {
                "description": "Contains the new path of .git directory if it is changed.",
                "returned": "success",
                "sample": "/path/to/new/git/dir",
                "type": "str"
            },
            "remote_url_changed": {
                "description": "Contains True or False whether or not the remote URL was changed.",
                "returned": "success",
                "sample": true,
                "type": "bool"
            },
            "warnings": {
                "description": "List of warnings if requested features were not available due to a too old git version.",
                "returned": "error",
                "sample": "git version is too old to fully support the depth argument. Falling back to full checkouts.",
                "type": "str"
            }
        }
    }
}

def go(args: List[str]) -> int:
    process_dict(json.load(sys.stdin))

def transform_dict(foH):
    doc = list(foH.values())[0]['doc']
    fqdn = '{}.{}'.format(doc['collection'], doc['module'])
    options = doc['options']


    rH = {}
    print(f'{c.bold}name{c.off}: {doc["short_description"]}')
    print(f'{c.bold}{fqdn}{c.off}:')
    mH = {}
    rH[fqdn] = mH
    max_key_len = 0
    all_keys = sorted(options.keys())
    for k in all_keys:
        if len(k) > max_key_len:
            max_key_len = len(k)

    for k in all_keys:
        v = options[k]
        if not v.get('required'): continue
        process_option(k, v, max_key_len)

    print('\n  # optionals')
    for k, v in doc['options'].items():
        if v.get('required'): continue
        process_option(k, v, max_key_len)

def process_option(k, v, max_key_len):
    indent = (1 + max_key_len - len(k)) * ' '
    description = '. '.join(v['description'])
    _type = v.get('type', '')
    #description = description.replace('C(no)',  f'{c.bold}no{c.off}')
    #description = description.replace('C(yes)', f'{c.bold}no{c.off}')
    description = re.sub(r'\bI\(([^)]+)\)', fr'{c.red}\1{c.off}', description)
    description = re.sub(r'\bC\(([^)]+)\)', fr'{c.blue}\1{c.off}', description)
    if _type: description = ' ' + description
    print(f'  {c.bold}{k}{c.off}:{indent}# {c.magenta}{_type}{c.off}{description}.')

def process_dict(foH):
    transform_dict(foH)


if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ:
        process_dict(git_doc)
    else:
        try:
            r = go(sys.argv[1:])
        except BaseException as e:
            logger.exception('oups for %s', sys.argv)
            sys.exit(1)
        sys.exit(r)

