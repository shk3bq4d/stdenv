# /* ex: set filetype=md fenc=utf-8 expandtab ts=2 sw=2 : */
* https://docs.ansible.com/ansible/latest/modules/template_module.html
* https://docs.ansible.com/ansible/latest/modules/include_vars_module.html
* https://docs.ansible.com/ansible/latest/modules/get_url_module.html
* https://docs.ansible.com/ansible/latest/modules/user_module.html
* https://docs.ansible.com/ansible/latest/reference_appendices/playbooks_keywords.html
*    https://docs.ansible.com/ansible/2.6/modules/user_module.html
* https://stackoverflow.com/questions/35654286/how-check-a-file-exists-in-ansible

```yaml
- name: mongo_dev_fs_id
  set_fact: fs_id='fs-d3ad0faa'
  when: hostvars[inventory_hostname]['ec2_tag_Environment'] == 'dev'
  tags:
    - efs
- name: mongo_dev_fs_id
  set_fact:
    mr_hehe: "{{hihi[hostvars[inventory_hostname]['ec2_tag_Environment']]}}"
  tags:
    - mrdebug
- name: include_inline_efs_role
  import_role:
    name: efs
  vars:
    mount_point: "{{ mongo_backup_path }}"
    fs_id: "{{ fs_id }}"
  tags:
    - efg
- name: include vars
  include_vars: environment_vars_dev.yml
  when: hostvars[inventory_hostname]['ec2_tag_Environment'] == 'dev'
  tags:
    - efse
- name: myshell
  shell: "echo 'test'"
  register: foo
  tags:
    - mrdebug
  vars:
    work_dir: "{{ ('~' + ansible_env.SUDO_USER) | expanduser }}/.tmp/ansible"
  args:
    warn: false
creates: /tmp/hehe

- name: environment variable access
  debug: var=ansible_env.SUDO_USER
- name: myfoo
  debug:
      #msg: "the echo was {{ foo.stdout }}"
    msg: "the echo was hihi {{ mr_hehe }}"
  tags:
- name: Show all possible accessible hosts
  debug:
    var: hostvars[inventory_hostname]
  tags:
    - mrdebug
  # from https://gryzli.info/2017/12/21/ansible-debug-print-variables/
- name: "local_action with no sudo root"
  vars:
    ansible_become: false
  local_action:
    module: ec2
    group: ['mygroup']
    id: hostvars[inventory_hostname]['ec2_id']
```

ansible-galaxy install -r requirements.yml
https://galaxy.ansible.com/search?deprecated=false&order_by=-relevance&keywords=

ansible-playbook -h                                                                                        27' 41"
Usage: ansible-playbook playbook.yml
Options:
  --ask-vault-pass      ask for vault password
  -C, --check           don't make any changes; instead, try to predict some
                        of the changes that may occur
  -D, --diff            when changing (small) files and templates, show the
                        differences in those files; works great with --check
  -e EXTRA_VARS, --extra-vars=EXTRA_VARS
                        set additional variables as key=value or YAML/JSON
  --flush-cache         clear the fact cache
  --force-handlers      run handlers even if a task fails
  -f FORKS, --forks=FORKS
                        specify number of parallel processes to use
                        (default=5)
  -h, --help            show this help message and exit
  -i INVENTORY, --inventory-file=INVENTORY
                        specify inventory host path
                        (default=/etc/ansible/hosts) or comma separated host
                        list.
  -l SUBSET, --limit=SUBSET
                        further limit selected hosts to an additional pattern
  --list-hosts          outputs a list of matching hosts; does not execute
                        anything else
  --list-tags           list all available tags
  --list-tasks          list all tasks that would be executed
  -M MODULE_PATH, --module-path=MODULE_PATH
                        specify path(s) to module library (default=None)
  --new-vault-password-file=NEW_VAULT_PASSWORD_FILE
                        new vault password file for rekey
  --output=OUTPUT_FILE  output file name for encrypt or decrypt; use - for
                        stdout
  --skip-tags=SKIP_TAGS
                        only run plays and tasks whose tags do not match these
                        values
  --start-at-task=START_AT_TASK
                        start the playbook at the task matching this name
  --step                one-step-at-a-time: confirm each task before running
  --syntax-check        perform a syntax check on the playbook, but do not
                        execute it
  -t TAGS, --tags=TAGS  only run plays and tasks tagged with these values
  --vault-password-file=VAULT_PASSWORD_FILE
                        vault password file
  -v, --verbose         verbose mode (-vvv for more, -vvvv to enable
                        connection debugging)
  --version             show program's version number and exit
  Connection Options:
    control as whom and how to connect to hosts
    -k, --ask-pass      ask for connection password
    --private-key=PRIVATE_KEY_FILE, --key-file=PRIVATE_KEY_FILE
                        use this file to authenticate the connection
    -u REMOTE_USER, --user=REMOTE_USER
                        connect as this user (default=None)
    -c CONNECTION, --connection=CONNECTION
                        connection type to use (default=smart)
    -T TIMEOUT, --timeout=TIMEOUT
                        override the connection timeout in seconds
                        (default=10)
    --ssh-common-args=SSH_COMMON_ARGS
                        specify common arguments to pass to sftp/scp/ssh (e.g.
                        ProxyCommand)
    --sftp-extra-args=SFTP_EXTRA_ARGS
                        specify extra arguments to pass to sftp only (e.g. -f,
                        -l)
    --scp-extra-args=SCP_EXTRA_ARGS
                        specify extra arguments to pass to scp only (e.g. -l)
    --ssh-extra-args=SSH_EXTRA_ARGS
                        specify extra arguments to pass to ssh only (e.g. -R)
  Privilege Escalation Options:
    control how and which user you become as on target hosts
    -s, --sudo          run operations with sudo (nopasswd) (deprecated, use
                        become)
    -U SUDO_USER, --sudo-user=SUDO_USER
                        desired sudo user (default=root) (deprecated, use
                        become)
    -S, --su            run operations with su (deprecated, use become)
    -R SU_USER, --su-user=SU_USER
                        run operations with su as this user (default=root)
                        (deprecated, use become)
    -b, --become        run operations with become (does not imply password
                        prompting)
    --become-method=BECOME_METHOD
                        privilege escalation method to use (default=sudo),
                        valid choices: [ sudo | su | pbrun | pfexec | runas |
                        doas | dzdo ]
    --become-user=BECOME_USER
                        run operations as this user (default=root)
    --ask-sudo-pass     ask for sudo password (deprecated, use become)
    --ask-su-pass       ask for su password (deprecated, use become)
    -K, --ask-become-pass
                        ask for privilege escalation password

{% for host in hosts|sort(attribute='name') %}

shell, command no change when exit code is 0 change_when: false -> # http://www.middlewareinventory.com/blog/ansible-changed_when-and-failed_when-examples/

"{{ 'ternary operator jinja' if expose_service == 'true' else 'ClusterIP' }}"

# https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html
"{{ ('~' + ansible_env.SUDO_USER) | expanduser }}"
To add quotes for shell usage: ```yaml - shell: echo {{ string_value | quote }}```
To use one value on true and another on false (new in version 1.9): ```yaml {{ (name == "John") | ternary('Mr','Ms') }}```
To concatenate a list into a string: ```yaml {{ list | join(" ") }}```
To get the last name of a file path, like ‘foo.txt’ out of ‘/etc/asdf/foo.txt’: ```yaml {{ path | basename }}```
To get the last name of a windows style file path (new in version 2.0): ```yaml {{ path | win_basename }}```
To separate the windows drive letter from the rest of a file path (new in version 2.0): ```yaml {{ path | win_splitdrive }}```
To get only the windows drive letter: ```yaml {{ path | win_splitdrive | first }}```
To get the rest of the path without the drive letter: ```yaml {{ path | win_splitdrive | last }}```
To get the directory from a path: ```yaml {{ path | dirname }}```
To get the directory from a windows path (new version 2.0): ```yaml {{ path | win_dirname }}```
To expand a path containing a tilde (~) character (new in version 1.5): ```yaml {{ path | expanduser }}```
To expand a path containing environment variables: ```yaml {{ path | expandvars }}```
To get the real path of a link (new in version 1.8): ```yaml {{ path | realpath }}```
To get the relative path of a link, from a start point (new in version 1.7): ```yaml {{ path | relpath('/etc') }}```

 To get the root and extension of a path or filename (new in version 2.0): ```yaml {{ path | splitext }}```
To work with Base64 encoded strings: ```yaml {{ encoded | b64decode }}```
To work with Base64 encoded strings: ```yaml {{ encoded | b64encode }}```
To work with Base64 encoded strings: ```yaml {{ encoded | b64decode(encoding='utf-16-le') }}```
To work with Base64 encoded strings: ```yaml {{ encoded | b64encode(encoding='utf-16-le') }}```
To create a UUID from a string (new in version 1.9): ```yaml {{ hostname | to_uuid }}```
{{ 'foobar' | regex_search('(foo)') }} # search for "foo" in "foobar"
{{ 'ansible' | regex_search('(foobar)') }} # will return empty if it cannot find a match
{{ 'foo\nBAR' | regex_search("^bar", multiline=True, ignorecase=True) }} # case insensitive search in multiline mode

```json
- include: ....
    when: optional_file|exists # deprecated
    when: not optional_file|exists # deprecated
- include_vars:                  # implicit exists for include
    depth: 1                     # implicit exists for include
    dir: vars                    # implicit exists for include
    files_matching: "{{ item }}" # implicit exists for include
  with_items:                    # implicit exists for include
    - myname.yml                 # implicit exists for include

localhost | SUCCESS => {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "172.17.0.1",
            "10.19.29.81"
        ],
        "ansible_all_ipv6_addresses": [
            "fe80::42:afff:fe33:ec52",
            "fe80::9eb6:d0ff:fef2:f0b5",
            "fe80::4c26:bcff:fe90:4f25"
        ],
        "ansible_apparmor": {
            "status": "enabled"
        },
        "ansible_architecture": "x86_64",
        "ansible_bios_date": "10/03/2017",
        "ansible_bios_version": "2.3.1",
        "ansible_cmdline": {
            "BOOT_IMAGE": "/boot/vmlinuz-4.15.0-43-generic",
            "quiet": true,
            "ro": true,
            "root": "/dev/mapper/ubuntu--vg-root",
            "splash": true,
            "vt.handoff": "1"
        },
        "ansible_date_time": {
            "date": "2019-01-19",
            "day": "19",
            "epoch": "1547896430",
            "hour": "12",
            "iso8601": "2019-01-19T11:13:50Z",
            "iso8601_basic": "20190119T121350734697",
            "iso8601_basic_short": "20190119T121350",
            "iso8601_micro": "2019-01-19T11:13:50.734777Z",
            "minute": "13",
            "month": "01",
            "second": "50",
            "time": "12:13:50",
            "tz": "CET",
            "tz_offset": "+0100",
            "weekday": "Saturday",
            "weekday_number": "6",
            "weeknumber": "02",
            "year": "2019"
        },
        "ansible_default_ipv4": {
            "address": "10.19.29.81",
            "alias": "wlp58s0",
            "broadcast": "10.255.255.255",
            "gateway": "10.19.29.1",
            "interface": "wlp58s0",
            "macaddress": "9c:b6:d0:f2:f0:b5",
            "mtu": 1500,
            "netmask": "255.0.0.0",
            "network": "10.0.0.0",
            "type": "ether"
        },
        "ansible_default_ipv6": {},
        "ansible_device_links": {
            "ids": {
                "dm-0": [
                    "dm-name-ubuntu--vg-root",
                    "dm-uuid-LVM-egHdbsL01K2yIZkmheu2Pq204ZLknnmAGFl7nTvWknkZzWsXhlTtTItprki1MiaD"
                ],
                "dm-1": [
                    "dm-name-ubuntu--vg-swap_1",
                    "dm-uuid-LVM-egHdbsL01K2yIZkmheu2Pq204ZLknnmALIfHcJPOzE4GfQTTAh1tk3s9WviicFYt"
                ],
                "dm-2": [
                    "dm-name-cryptswap1",
                    "dm-uuid-CRYPT-PLAIN-cryptswap1"
                ],
                "nvme0n1": [
                    "nvme-KXG50ZNV256G_NVMe_TOSHIBA_256GB_Y7AF21DSFQAS",
                    "nvme-eui.000000000000001000080d05000210bb"
                ],
                "nvme0n1p1": [
                    "nvme-KXG50ZNV256G_NVMe_TOSHIBA_256GB_Y7AF21DSFQAS-part1",
                    "nvme-eui.000000000000001000080d05000210bb-part1"
                ],
                "nvme0n1p2": [
                    "lvm-pv-uuid-GUmUhH-auv4-deFe-6YXo-417J-FR99-mFuV9O",
                    "nvme-KXG50ZNV256G_NVMe_TOSHIBA_256GB_Y7AF21DSFQAS-part2",
                    "nvme-eui.000000000000001000080d05000210bb-part2"
                ]
            },
            "labels": {},
            "masters": {
                "dm-1": [
                    "dm-2"
                ],
                "nvme0n1p2": [
                    "dm-0",
                    "dm-1"
                ]
            },
            "uuids": {
                "dm-0": [
                    "c5f36677-8d03-456d-8c44-81c825e8da66"
                ],
                "dm-1": [
                    "93320f60-9d6e-4691-a934-014d51fcb14a"
                ],
                "dm-2": [
                    "5636ffe5-a437-4aaa-8e2c-50d3833777cc"
                ],
                "nvme0n1p1": [
                    "B952-EDD1"
                ]
            }
        },
        "ansible_devices": {
            "dm-0": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [
                        "dm-name-ubuntu--vg-root",
                        "dm-uuid-LVM-egHdbsL01K2yIZkmheu2Pq204ZLknnmAGFl7nTvWknkZzWsXhlTtTItprki1MiaD"
                    ],
                    "labels": [],
                    "masters": [],
                    "uuids": [
                        "c5f36677-8d03-456d-8c44-81c825e8da66"
                    ]
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "0",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "",
                "sectors": "482484224",
                "sectorsize": "512",
                "size": "230.07 GB",
                "support_discard": "512",
                "vendor": null,
                "virtual": 1
            },
            "dm-1": {
                "holders": [
                    "cryptswap1"
                ],
                "host": "",
                "links": {
                    "ids": [
                        "dm-name-ubuntu--vg-swap_1",
                        "dm-uuid-LVM-egHdbsL01K2yIZkmheu2Pq204ZLknnmALIfHcJPOzE4GfQTTAh1tk3s9WviicFYt"
                    ],
                    "labels": [],
                    "masters": [
                        "dm-2"
                    ],
                    "uuids": [
                        "93320f60-9d6e-4691-a934-014d51fcb14a"
                    ]
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "0",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "",
                "sectors": "16531456",
                "sectorsize": "512",
                "size": "7.88 GB",
                "support_discard": "512",
                "vendor": null,
                "virtual": 1
            },
            "dm-2": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [
                        "dm-name-cryptswap1",
                        "dm-uuid-CRYPT-PLAIN-cryptswap1"
                    ],
                    "labels": [],
                    "masters": [],
                    "uuids": [
                        "5636ffe5-a437-4aaa-8e2c-50d3833777cc"
                    ]
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "0",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "",
                "sectors": "16530432",
                "sectorsize": "512",
                "size": "7.88 GB",
                "support_discard": "0",
                "vendor": null,
                "virtual": 1
            },
            "loop0": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "183272",
                "sectorsize": "512",
                "size": "89.49 MB",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "loop1": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "288080",
                "sectorsize": "512",
                "size": "140.66 MB",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "loop2": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "70736",
                "sectorsize": "512",
                "size": "34.54 MB",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "loop3": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "26600",
                "sectorsize": "512",
                "size": "12.99 MB",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "loop4": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "4600",
                "sectorsize": "512",
                "size": "2.25 MB",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "loop5": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "29704",
                "sectorsize": "512",
                "size": "14.50 MB",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "loop6": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "7576",
                "sectorsize": "512",
                "size": "3.70 MB",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "loop7": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {},
                "removable": "0",
                "rotational": "1",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "0",
                "sectorsize": "512",
                "size": "0.00 Bytes",
                "support_discard": "4096",
                "vendor": null,
                "virtual": 1
            },
            "nvme0n1": {
                "holders": [],
                "host": "Non-Volatile memory controller: Toshiba America Info Systems Device 0116",
                "links": {
                    "ids": [
                        "nvme-KXG50ZNV256G_NVMe_TOSHIBA_256GB_Y7AF21DSFQAS",
                        "nvme-eui.000000000000001000080d05000210bb"
                    ],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": "KXG50ZNV256G NVMe TOSHIBA 256GB",
                "partitions": {
                    "nvme0n1p1": {
                        "holders": [],
                        "links": {
                            "ids": [
                                "nvme-KXG50ZNV256G_NVMe_TOSHIBA_256GB_Y7AF21DSFQAS-part1",
                                "nvme-eui.000000000000001000080d05000210bb-part1"
                            ],
                            "labels": [],
                            "masters": [],
                            "uuids": [
                                "B952-EDD1"
                            ]
                        },
                        "sectors": "1048576",
                        "sectorsize": 512,
                        "size": "512.00 MB",
                        "start": "2048",
                        "uuid": "B952-EDD1"
                    },
                    "nvme0n1p2": {
                        "holders": [
                            "ubuntu--vg-swap_1",
                            "ubuntu--vg-root"
                        ],
                        "links": {
                            "ids": [
                                "lvm-pv-uuid-GUmUhH-auv4-deFe-6YXo-417J-FR99-mFuV9O",
                                "nvme-KXG50ZNV256G_NVMe_TOSHIBA_256GB_Y7AF21DSFQAS-part2",
                                "nvme-eui.000000000000001000080d05000210bb-part2"
                            ],
                            "labels": [],
                            "masters": [
                                "dm-0",
                                "dm-1"
                            ],
                            "uuids": []
                        },
                        "sectors": "499066880",
                        "sectorsize": 512,
                        "size": "237.97 GB",
                        "start": "1050624",
                        "uuid": null
                    }
                },
                "removable": "0",
                "rotational": "0",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "none",
                "sectors": "500118192",
                "sectorsize": "512",
                "size": "238.47 GB",
                "support_discard": "512",
                "vendor": null,
                "virtual": 1
            }
        },
        "ansible_distribution": "Ubuntu",
        "ansible_distribution_file_parsed": true,
        "ansible_distribution_file_path": "/etc/os-release",
        "ansible_distribution_file_variety": "Debian",
        "ansible_distribution_major_version": "18",
        "ansible_distribution_release": "bionic",
        "ansible_distribution_version": "18.04",
        "ansible_dns": {
            "nameservers": [
                "127.0.0.53"
            ],
            "search": [
                "ly.lan"
            ]
        },
        "ansible_docker0": {
            "active": true,
            "device": "docker0",
            "id": "8000.0242af33ec52",
            "interfaces": [
                "vethd62b54d"
            ],
            "ipv4": {
                "address": "172.17.0.1",
                "broadcast": "172.17.255.255",
                "netmask": "255.255.0.0",
                "network": "172.17.0.0"
            },
            "ipv6": [
                {
                    "address": "fe80::42:afff:fe33:ec52",
                    "prefix": "64",
                    "scope": "link"
                }
            ],
            "macaddress": "02:42:af:33:ec:52",
            "mtu": 1500,
            "promisc": false,
            "stp": false,
            "type": "bridge"
        },
        "ansible_domain": "ly.lan",
        "ansible_effective_group_id": 1000,
        "ansible_effective_user_id": 1000,
        "ansible_env": {
            "CDPATH": ":/home/user/.cdpath",
            "COLORFGBG": "default;default;8",
            "COLORTERM": "rxvt-xpm",
            "DBUS_SESSION_BUS_ADDRESS": "unix:path=/run/user/1000/bus",
            "DEFAULTS_PATH": "/usr/share/gconf/i3-with-shmlog.default.path",
            "DESKTOP_SESSION": "i3-with-shmlog",
            "DESKTOP_STARTUP_ID": "i3/~|bin|mrurxvt/2085-107-dec17_TIME7886764",
            "DISPLAY": ":0",
            "EDITOR": "vim",
            "GDMSESSION": "i3-with-shmlog",
            "GOPATH": "/home/user/go",
            "GPG_AGENT_INFO": "/run/user/1000/gnupg/S.gpg-agent:0:1",
            "GTK_MODULES": "gail:atk-bridge",
            "HOME": "/home/user",
            "HOSTNAME": "dec17",
            "HOSTNAMEF": "dec17.ly.lan",
            "LANG": "en_US.UTF-8",
            "LANGUAGE": "",
            "LC_ADDRESS": "en_US.UTF-8",
            "LC_ALL": "en_US.UTF-8",
            "LC_COLLATE": "en_US.UTF-8",
            "LC_CTYPE": "en_US.UTF-8",
            "LC_IDENTIFICATION": "en_US.UTF-8",
            "LC_MEASUREMENT": "en_US.UTF-8",
            "LC_MESSAGES": "en_US.UTF-8",
            "LC_MONETARY": "en_US.UTF-8",
            "LC_NAME": "en_US.UTF-8",
            "LC_NUMERIC": "en_US.UTF-8",
            "LC_PAPER": "en_US.UTF-8",
            "LC_TELEPHONE": "en_US.UTF-8",
            "LC_TIME": "en_DK.utf8",
            "LESS": "-R",
            "LESSCLOSE": "/usr/bin/lesspipe %s %s",
            "LESSOPEN": "| /usr/bin/lesspipe %s",
            "LOGNAME": "user",
            "LSCOLORS": "Gxfxcxdxbxegedabagacad",
            "LS_COLORS": "no=00:fi=00:di=36:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.hpp=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.cl=32:*.sh=32:*.bash=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.go=32:*.sql=32:*.csv=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.PNG=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.opus=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.odt=31:*.dot=31:*.dotx=31:*.ott=31:*.xls=31:*.xlsx=31:*.ods=31:*.ots=31:*.ppt=31:*.pptx=31:*.odp=31:*.otp=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;34:*~=01;34:*#=01;34:*.bak=01;36:*.BAK=01;36:*.old=01;36:*.OLD=01;36:*.org_archive=01;36:*.off=01;36:*.OFF=01;36:*.dist=01;36:*.DIST=01;36:*.orig=01;36:*.ORIG=01;36:*.swp=01;36:*.swo=01;36:*,v=01;36:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:",
            "MANDATORY_PATH": "/usr/share/gconf/i3-with-shmlog.mandatory.path",
            "MANPAGER": "less -sR",
            "MRCOLOR": "18-d0a6ee",
            "MR_PREV_COMMAND": "ansible -m setup localhost",
            "MR_RUNNING_COMMAND": "ansible -m setup localhost >> ~/doc/ansible.md",
            "MR_TERM": "urxvt",
            "OLDPWD": "/home/user/stdansible",
            "PAGER": "less",
            "PATH": "/home/user/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/user/go/bin",
            "PERL_MB_OPT": "--install_base \"/home/user/perl5\"",
            "PERL_MM_OPT": "INSTALL_BASE=/home/user/perl5",
            "PWD": "/home/user/stdansible",
            "PYTHONDONTWRITEBYTECODE": "True",
            "PYTHONIOENCODING": "UTF-8",
            "PYTHONPATH": ":/home/user/py:/home/user/py/fpedialog:/home/user/py/selenium:/home/user/py/plotly:/home/user/py/fpeconsole:/home/user/py/fpenpyscreen:/home/user/py/__pycache__",
            "PYTHONSTARTUP": "/home/user/.pythonrc",
            "QT_ACCESSIBILITY": "1",
            "RCD": "/home/user",
            "RPROMPT": "%F{blue}12:13:36 %F{cyan} 1\"335%{\u001b[00m%}",
            "SHELL": "/usr/bin/zsh",
            "SHLVL": "2",
            "SSH_AGENT_PID": "2682",
            "SSH_AUTH_SOCK": "/tmp/ssh-vgp7BRUFYLJX/agent.2680",
            "STDHOME_DIRNAME": "/home/user/git/user/stdhome",
            "S_COLORS": "auto",
            "TERM": "rxvt-unicode-256color",
            "TERMINAL": "mrurxvt",
            "UNAME": "linux",
            "USER": "user",
            "USERNAME": "user",
            "VAGRANT_SERVER_URL": "https://app.vagrantup.com",
            "VAULT_ADDR": "https://vault.bip.net",
            "VAULT_CLIENT_CERT": "/home/user/vault/user.crt",
            "VAULT_CLIENT_KEY": "/home/user/vault/user.key",
            "VAULT_SKIP_VERIFY": "1",
            "VIRTUALENVWRAPPER_SCRIPT": "/usr/share/virtualenvwrapper/virtualenvwrapper.sh",
            "WINDOWID": "41943049",
            "WINDOWPATH": "2",
            "WORKON_HOME": "/home/user/.virtualenvs",
            "WORK_PC1": "user-pc",
            "WORK_PC1F": "user-pc.bip.local",
            "WORK_PC2": "hehehaha",
            "WORK_PC2F": "hehehah.hg.g.local",
            "WORK_PC3": "ubuntu-corp",
            "WORK_PC3F": "ubuntu-corp.usercorp.local",
            "XAUTHORITY": "/run/user/1000/gdm/Xauthority",
            "XDG_CONFIG_DIRS": "/etc/xdg/xdg-i3-with-shmlog:/etc/xdg",
            "XDG_DATA_DIRS": "/usr/share/i3-with-shmlog:/usr/local/share:/usr/share:/var/lib/snapd/desktop",
            "XDG_RUNTIME_DIR": "/run/user/1000",
            "XDG_SEAT": "seat0",
            "XDG_SESSION_DESKTOP": "i3-with-shmlog",
            "XDG_SESSION_ID": "2",
            "XDG_SESSION_TYPE": "x11",
            "XDG_VTNR": "2",
            "ZSH": "/home/user/.oh-my-zsh",
            "_": "/home/user/bin/ansible",
            "_MRCOLOR": "d0a6ee",
            "_VIRTUALENVWRAPPER_API": " mkvirtualenv rmvirtualenv lsvirtualenv showvirtualenv workon add2virtualenv cdsitepackages cdvirtualenv lssitepackages toggleglobalsitepackages cpvirtualenv setvirtualenvproject mkproject cdproject mktmpenv",
            "endtime": "",
            "timer": "1547896429587"
        },
        "ansible_fips": false,
        "ansible_form_factor": "Laptop",
        "ansible_fqdn": "dec17.ly.lan",
        "ansible_hostname": "dec17",
        "ansible_interfaces": [
            "lo",
            "wlp58s0",
            "docker0",
            "vethd62b54d"
        ],
        "ansible_is_chroot": false,
        "ansible_iscsi_iqn": "",
        "ansible_kernel": "4.15.0-43-generic",
        "ansible_lo": {
            "active": true,
            "device": "lo",
            "ipv4": {
                "address": "127.0.0.1",
                "broadcast": "host",
                "netmask": "255.0.0.0",
                "network": "127.0.0.0"
            },
            "ipv6": [
                {
                    "address": "::1",
                    "prefix": "128",
                    "scope": "host"
                }
            ],
            "mtu": 65536,
            "promisc": false,
            "type": "loopback"
        },
        "ansible_local": {},
        "ansible_lsb": {
            "codename": "bionic",
            "description": "Ubuntu 18.04.1 LTS",
            "id": "Ubuntu",
            "major_release": "18",
            "release": "18.04"
        },
        "ansible_machine": "x86_64",
        "ansible_machine_id": "4eb532d733224ff5a23be7bfe54a3d46",
        "ansible_memfree_mb": 251,
        "ansible_memory_mb": {
            "nocache": {
                "free": 4763,
                "used": 3097
            },
            "real": {
                "free": 251,
                "total": 7860,
                "used": 7609
            },
            "swap": {
                "cached": 0,
                "free": 8071,
                "total": 8071,
                "used": 0
            }
        },
        "ansible_memtotal_mb": 7860,
        "ansible_mounts": [
            {
                "block_available": 32203145,
                "block_size": 4096,
                "block_total": 59101660,
                "block_used": 26898515,
                "device": "/dev/mapper/ubuntu--vg-root",
                "fstype": "ext4",
                "inode_available": 13873098,
                "inode_total": 15081472,
                "inode_used": 1208374,
                "mount": "/",
                "options": "rw,relatime,errors=remount-ro,data=ordered",
                "size_available": 131904081920,
                "size_total": 242080399360,
                "uuid": "c5f36677-8d03-456d-8c44-81c825e8da66"
            },
            {
                "block_available": 0,
                "block_size": 131072,
                "block_total": 716,
                "block_used": 716,
                "device": "/dev/loop0",
                "fstype": "squashfs",
                "inode_available": 0,
                "inode_total": 12810,
                "inode_used": 12810,
                "mount": "/snap/core/6130",
                "options": "ro,nodev,relatime",
                "size_available": 0,
                "size_total": 93847552,
                "uuid": "N/A"
            },
            {
                "block_available": 0,
                "block_size": 131072,
                "block_total": 277,
                "block_used": 277,
                "device": "/dev/loop2",
                "fstype": "squashfs",
                "inode_available": 0,
                "inode_total": 27345,
                "inode_used": 27345,
                "mount": "/snap/gtk-common-themes/818",
                "options": "ro,nodev,relatime",
                "size_available": 0,
                "size_total": 36306944,
                "uuid": "N/A"
            },
            {
                "block_available": 0,
                "block_size": 131072,
                "block_total": 1126,
                "block_used": 1126,
                "device": "/dev/loop1",
                "fstype": "squashfs",
                "inode_available": 0,
                "inode_total": 27631,
                "inode_used": 27631,
                "mount": "/snap/gnome-3-26-1604/74",
                "options": "ro,nodev,relatime",
                "size_available": 0,
                "size_total": 147587072,
                "uuid": "N/A"
            },
            {
                "block_available": 0,
                "block_size": 131072,
                "block_total": 104,
                "block_used": 104,
                "device": "/dev/loop3",
                "fstype": "squashfs",
                "inode_available": 0,
                "inode_total": 1598,
                "inode_used": 1598,
                "mount": "/snap/gnome-characters/139",
                "options": "ro,nodev,relatime",
                "size_available": 0,
                "size_total": 13631488,
                "uuid": "N/A"
            },
            {
                "block_available": 0,
                "block_size": 131072,
                "block_total": 18,
                "block_used": 18,
                "device": "/dev/loop4",
                "fstype": "squashfs",
                "inode_available": 0,
                "inode_total": 1269,
                "inode_used": 1269,
                "mount": "/snap/gnome-calculator/260",
                "options": "ro,nodev,relatime",
                "size_available": 0,
                "size_total": 2359296,
                "uuid": "N/A"
            },
            {
                "block_available": 0,
                "block_size": 131072,
                "block_total": 30,
                "block_used": 30,
                "device": "/dev/loop6",
                "fstype": "squashfs",
                "inode_available": 0,
                "inode_total": 747,
                "inode_used": 747,
                "mount": "/snap/gnome-system-monitor/57",
                "options": "ro,nodev,relatime",
                "size_available": 0,
                "size_total": 3932160,
                "uuid": "N/A"
            },
            {
                "block_available": 0,
                "block_size": 131072,
                "block_total": 117,
                "block_used": 117,
                "device": "/dev/loop5",
                "fstype": "squashfs",
                "inode_available": 0,
                "inode_total": 1720,
                "inode_used": 1720,
                "mount": "/snap/gnome-logs/45",
                "options": "ro,nodev,relatime",
                "size_available": 0,
                "size_total": 15335424,
                "uuid": "N/A"
            },
            {
                "block_available": 129252,
                "block_size": 4096,
                "block_total": 130812,
                "block_used": 1560,
                "device": "/dev/nvme0n1p1",
                "fstype": "vfat",
                "inode_available": 0,
                "inode_total": 0,
                "inode_used": 0,
                "mount": "/boot/efi",
                "options": "rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro",
                "size_available": 529416192,
                "size_total": 535805952,
                "uuid": "B952-EDD1"
            },
            {
                "block_available": 32203145,
                "block_size": 4096,
                "block_total": 59101660,
                "block_used": 26898515,
                "device": "/home/user/.Private",
                "fstype": "ecryptfs",
                "inode_available": 13873098,
                "inode_total": 15081472,
                "inode_used": 1208374,
                "mount": "/home/user",
                "options": "rw,nosuid,nodev,relatime,ecryptfs_fnek_sig=0cfb894c43f8ac40,ecryptfs_sig=f8208685ec29ccf4,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_unlink_sigs",
                "size_available": 131904081920,
                "size_total": 242080399360,
                "uuid": "N/A"
            }
        ],
        "ansible_nodename": "dec17",
        "ansible_os_family": "Debian",
        "ansible_pkg_mgr": "apt",
        "ansible_processor": [
            "0",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz",
            "1",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz",
            "2",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz",
            "3",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz",
            "4",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz",
            "5",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz",
            "6",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz",
            "7",
            "GenuineIntel",
            "Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz"
        ],
        "ansible_processor_cores": 4,
        "ansible_processor_count": 1,
        "ansible_processor_threads_per_core": 2,
        "ansible_processor_vcpus": 8,
        "ansible_product_name": "XPS 13 9360",
        "ansible_product_serial": "NA",
        "ansible_product_uuid": "NA",
        "ansible_product_version": "NA",
        "ansible_python": {
            "executable": "/usr/bin/python",
            "has_sslcontext": true,
            "type": "CPython",
            "version": {
                "major": 2,
                "micro": 15,
                "minor": 7,
                "releaselevel": "candidate",
                "serial": 1
            },
            "version_info": [
                2,
                7,
                15,
                "candidate",
                1
            ]
        },
        "ansible_python_version": "2.7.15rc1",
        "ansible_real_group_id": 1000,
        "ansible_real_user_id": 1000,
        "ansible_selinux": {
            "status": "Missing selinux Python library"
        },
        "ansible_selinux_python_present": false,
        "ansible_service_mgr": "systemd",
        "ansible_ssh_host_key_ecdsa_public": "AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGFgFhc4BTeT65mLs0sef3Yuu7+xG2IlEnZqKMjCwjM37B1wFS6oyrx41rbCS+AW30CcQA4RyEUPz//GovQXCpg=",
        "ansible_ssh_host_key_ed25519_public": "AAAAC3NzaC1lZDI1NTE5AAAAIKJHooweZ9nSq6lh+uH4p+tExgo4g8s1VyBSCrpfwhcs",
        "ansible_ssh_host_key_rsa_public": "AAAAB3NzaC1yc2EAAAADAQABAAABAQDzIhzZi76pTuYQzl3hWcwjMmCwuxnk9BCCX0/ZzSCTZo1YVS3W2ZHGpv8DOz+PjTgF5RlqSQHLW52bM8RrmZ2MFBmKvx9VbNhro0VsI+kAQ34WVfP/lfuqsgOjT0IzAR4Qj1cHzDY+T0r7ITIfpE6zkRWQ8Yjk1kFszAAlhEH6gJ5ZpANkcORy7tqtP/2wpx9B3tKtMv6tHr0YmxzQESr5Ipovc45rRaIba868Z4l6ouPhEoD6zRNosAnuZ6+k6hYHOxZAWZopLwLrv9LAuUBLhcBdmBVeU4MvIQmzYC4eG5t6v2NE+HyZHo6XEqMzmhm8LH9o45EbMDIiWylKtC67",
        "ansible_swapfree_mb": 8071,
        "ansible_swaptotal_mb": 8071,
        "ansible_system": "Linux",
        "ansible_system_capabilities": [
            ""
        ],
        "ansible_system_capabilities_enforced": "True",
        "ansible_system_vendor": "Dell Inc.",
        "ansible_uptime_seconds": 76969,
        "ansible_user_dir": "/home/user",
        "ansible_user_gecos": "user,,,",
        "ansible_user_gid": 1000,
        "ansible_user_id": "user",
        "ansible_user_shell": "/usr/bin/zsh",
        "ansible_user_uid": 1000,
        "ansible_userspace_architecture": "x86_64",
        "ansible_userspace_bits": "64",
        "ansible_vethd62b54d": {
            "active": true,
            "device": "vethd62b54d",
            "ipv6": [
                {
                    "address": "fe80::4c26:bcff:fe90:4f25",
                    "prefix": "64",
                    "scope": "link"
                }
            ],
            "macaddress": "4e:26:bc:90:4f:25",
            "mtu": 1500,
            "promisc": true,
            "speed": 10000,
            "type": "ether"
        },
        "ansible_virtualization_role": "host",
        "ansible_virtualization_type": "kvm",
        "ansible_wlp58s0": {
            "active": true,
            "device": "wlp58s0",
            "ipv4": {
                "address": "10.19.29.81",
                "broadcast": "10.255.255.255",
                "netmask": "255.0.0.0",
                "network": "10.0.0.0"
            },
            "ipv6": [
                {
                    "address": "fe80::9eb6:d0ff:fef2:f0b5",
                    "prefix": "64",
                    "scope": "link"
                }
            ],
            "macaddress": "9c:b6:d0:f2:f0:b5",
            "module": "ath10k_pci",
            "mtu": 1500,
            "pciid": "0000:3a:00.0",
            "promisc": false,
            "type": "ether"
        },
        "gather_subset": [
            "all"
        ],
        "module_setup": true
    },
    "changed": false
}
```

# adhoc
ansible localhost --playbook-dir ~/stdansible -m include_role -a name=citrix-client-run -e file=$PWD/bip # execute single role
ansible all -m yum -a "name=httpd state=present"
ansible all -m apt -a "name=httpd state=present"
ansible web -m service -a "name=httpd state=started"
ansible web -m service -a "name=httpd state=restarted"
ansible all -m file -a "path=/project/devops state=directory"
ansible web -m copy -a "src=/etc/hosts dest=/tmp/hosts"
ansible all -m file -a "path=/project/devops/abcd.txt  state=touch"
ansible all -m user -a "name=ansible group=devops password=ansible123"
ansible all -m setup
ansible web -m group -a "name=devops state=present"
ansible web -m command -a "free -m"
ansible zabbix_proxy -c local -i inventory.yml -m shell -a "sh -c 'printf \"GREP %s: %s\n\" {{inventory_hostname}} \"\$(dig +short {{ inventory_hostname }})\"'"
sudo ansible localhost user -a "name=mysql-backup home=/data/mysql-backup"
sudo ansible localhost -m user -a "name=mysql-backup state=absent"
sudo ansible localhost -m authorized_key -a "user=mysql-backup key_options='no-port-forwarding,from="10.0.1.1"' key='ssh-rsa '"

when: ansible_distribution == 'CentOS' or ansible_distribution == 'Red Hat Enterprise Linux'
when: ansible_distribution == 'Debian' or ansible_distribution == 'Ubuntu'

# conversions
boolean: off,false => false

https://docs.ansible.com/ansible/latest/modules/terraform_module.html
https://github.com/ansible/ansible/blob/devel/lib/ansible/modules/cloud/misc/terraform.py
https://alex.dzyoba.com/blog/terraform-ansible/

https://docs.ansible.com/ansible/latest/modules/add_host_module.html
```yaml
https://docs.ansible.com/ansible/latest/modules/meta_module.html
meta: flush_handlers
meta: refresh_inventory
meta: noop
meta: clear_facts
meta: clear_host_errors
meta: end_play
meta: reset_connection
```

# loop
with_list
with_items
with_indexed_items
with_flattened
with_together
with_dict
with_sequence
with_subelements
with_nested/with_cartesian
with_random_choice
with_first_found # doesn't actually loop, but takes first existing file exists
```yaml
# until loop

- include: "{{ prerequisites_file }}"
  with_first_found:
    - files:
        - "prerequisites-{{ ansible_distribution }}.yml"
        - "prerequisites-{{ ansible_os_family }}.yml"
      skip: true
  loop_control:
    loop_var: prerequisites_file

- shell: /usr/bin/foo
  chdir: /tmp
  register: result
  until: result.stdout.find("all systems go") != -1
  retries: 5
  delay: 10

- shell: "/bin/true"
  chdir: /tmp
  register: myvar
  until: myvar.rc != 0 or myvar.attempts == 3
  retries: 20
  delay: 1
# templates
# Example from Ansible Playbooks
- template:
    src: /mytemplates/foo.j2
    dest: /etc/file.conf
    owner: bin
    group: wheel
    mode: 0644

# The same example, but using symbolic modes equivalent to 0644
- template:
    src: /mytemplates/foo.j2
    dest: /etc/file.conf
    owner: bin
    group: wheel
    mode: "u=rw,g=r,o=r"

# Create a DOS-style text file from a template
- template:
    src: config.ini.j2
    dest: /share/windows/config.ini
    newline_sequence: '\r\n'

# Copy a new "sudoers" file into place, after passing validation with visudo
- template:
    src: /mine/sudoers
    dest: /etc/sudoers
    validate: '/usr/sbin/visudo -cf %s'

# Update sshd configuration safely, avoid locking yourself out
- template:
    src: etc/ssh/sshd_config.j2
    dest: /etc/ssh/sshd_config
    owner: root
    group: root
    mode: '0600'
    validate: /usr/sbin/sshd -t -f %s
    backup: yes

- tasks:
   - name: Install Apache
     # https://docs.ansible.com/ansible/latest/user_guide/playbooks_blocks.html
     block:
       - yum:
           name: "{{ item }}"
           state: installed
         with_items:
           - httpd
           - memcached
       - template:
           src: templates/src.j2
           dest: /etc/foo.conf
       - service:
           name: bar
           state: started
           enabled: True
     when: ansible_facts['distribution'] == 'CentOS'
     become: true
     become_user: root
- name: Attempt and graceful roll back demo
  block: # try catch trycatch
    - debug:
        msg: 'I execute normally'
    - name: i force a failure
      command: /bin/false
    - debug:
        msg: 'I never execute, due to the above task failing, :-('
  rescue: # try catch trycatch
    - debug:
        msg: 'I caught an error'
    - name: i force a failure in middle of recovery! >:-)
      command: /bin/false
    - debug:
        msg: 'I also never execute :-('
  always: # try catch trycatch
    - debug:
        msg: "This always executes"
```

changed_when: "'already running' not in starthttpdout.stdout"
failed_when: "'already running' not in starthttpdout.stdout"

delegate_to: localhost


create ad_hoc group to avoid multiple when: https://docs.ansible.com/ansible/latest/modules/group_by_module.html#group-by-module



# directory layout
ansible galaxy init role-directory-layout
role-directory-layout/templates/
role-directory-layout/files/
role-directory-layout/meta/main.yml
role-directory-layout/tests/test.yml
role-directory-layout/tests/inventory
role-directory-layout/defaults/main.yml
role-directory-layout/README.md
role-directory-layout/handlers/main.yml
role-directory-layout/vars/main.yml
role-directory-layout/tasks/main.yml

# inventory
https://github.com/ansible/ansible/tree/devel/contrib/inventory
[all]
dnsmasq ansible_host=192.168.9.16 ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key ansible_user=vagrant ansible_ssh_common_args="-o StrictHostKeyChecking=no"
```yaml
all:
  hosts:
    dnsmasq.vbox.local:
      ansible_host: 192.168.9.16
  vars:
    ansible_ssh_private_key_file: ~/.vagrant.d/insecure_private_key
    ansible_user: vagrant
    ansible_ssh_common_args: "-o StrictHostKeyChecking=no"
    #ansible_ssh_extra_args: "-o StrictHostKeyChecking=no"
```

# ansible.cfg
[defaults]
roles_path    = ../common/ansible/roles/


# facts
- gather_facts: no
  tasks:
    - setup: {}
      when: ansible_fqdn is not defined


# variables
Variable precedence: Where should I put a variable?
* command line values (eg “-u user”)
* role defaults [1]
* inventory file or script group vars [2]
* inventory group_vars/all [3]
* playbook group_vars/all [3]
* inventory group_vars/* [3]
* playbook group_vars/* [3]
* inventory file or script host vars [2]
* inventory host_vars/* [3]
* playbook host_vars/* [3]
* host facts / cached set_facts [4]
* play vars
* play vars_prompt
* play vars_files
* role vars (defined in role/vars/main.yml)
* block vars (only for tasks in block)
* task vars (only for the task)
* include_vars
* set_facts / registered vars
* role (and include_role) params
* include params
* extra vars (always win precedence)

```yaml
- stat:
    path: /etc/foo.conf
  register: st
- fail:
    msg: "Whoops! file ownership has changed"
  when: st.stat.pw_name != 'root'

- debug: msg="Append list to list, or merge two lists"

- name: Setup two lists to be merged
  set_fact:
    list_one:
      - 1
      - 2
      - 3
    list_two:
      - 4
      - 5
      - 6

- name: Merge the two lists
  set_fact:
    lists_merged: "{{ list_one + list_two }}"

- name: Demonstrate merged lists
  debug: var=lists_merged

- name: Initialize an empty list for our strings
  set_fact:
    my_strings: []

- name: Setup a string variable
  set_fact:
    my_name: "Max"

- name: Append string to list
  set_fact:
    my_strings: "{{ my_strings + [ my_name ] }}"

- debug: var=my_strings

- name: Append another item to the list
  set_fact:
    my_strings: "{{ my_strings + [ 'Power' ] }}"

- debug: var=my_strings

- name: Ensure the JBoss memory settings are exactly as needed
  lineinfile:
    path: /opt/jboss-as/bin/standalone.conf
    regexp: '^(.*)Xms(\\d+)m(.*)$'
    line: '\1Xms${xms}m\3'
    backrefs: yes
 ```
# windows
https://github.com/jonashackt/ansible-windows-docker-springboot
https://chocolatey.org/packages/zabbix-agent
https://github.com/dohque/ansible-role-win-filebeat/blob/master/tasks/main.yml


# git-crypt
https://medium.com/faun/https-medium-com-mikhail-advani-secret-management-with-ansible-3bfdd92472ef
https://www.dewinter.com/gnupg_howto/english/GPGMiniHowto-3.html#ss3.1
gpg --import blabla.gpg
gpg --edit-key 4298F79FAE76FB11A2DF80B65803C1E207E1682B trust
5 I trust ultimately

```sh
# first user
git-crypt init
git-crypt add-gpg-user ONESELF # add oneself as a user
echo '*.key filter=git-crypt diff=git-crypt' > .gitattributes # setup which files should be encrypted
# first user allows second user
git-crypt add-gpg-user SECONDUSER # allow second user
# second user setup
git pull # there should be a second file appearing in git-crypt/keys/default/0/4298F79FAE76FB11A2DF80B65803C1E207E1682B.gpg
git-crypt unlock
```

# list of modules
https://docs.ansible.com/ansible/latest/modules/community_maintained.html


```
```markdown
#Play
any_errors_fatal               Force any un-handled task errors on any host to propagate to all hosts and end the play.
become                         Boolean that controls if privilege escalation is used or not on Task execution.
become_flags                   A string of flag(s) to pass to the privilege escalation program when become is True.
become_method                  Which method of privilege escalation to use (such as sudo or su).
become_user                    User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.
check_mode                     A boolean that controls if a task is executed in ‘check’ mode
collections                    UNDOCUMENTED!!
connection                     Allows you to change the connection plugin used for tasks to execute on the target.
debugger                       Enable debugging tasks based on state of the task result. See Playbook Debugger
diff                           Toggle to make tasks return ‘diff’ information or not.
environment                    A dictionary that gets converted into environment vars to be provided for the task upon execution. This cannot affect Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task.
fact_path                      Set the fact path option for the fact gathering plugin controlled by gather_facts.
force_handlers                 Will force notified handler execution for hosts even if they failed during the play. Will not trigger if the play itself fails.
gather_facts                   A boolean that controls if the play will automatically run the ‘setup’ task to gather facts for the hosts.
gather_subset                  Allows you to pass subset options to the fact gathering plugin controlled by gather_facts.
gather_timeout                 Allows you to set the timeout for the fact gathering plugin controlled by gather_facts.
handlers                       A section with tasks that are treated as handlers, these won’t get executed normally, only when notified after each section of tasks is complete. A handler’s listen field is not templatable.
hosts                          A list of groups, hosts or host pattern that translates into a list of hosts that are the play’s target.
ignore_errors                  Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.
ignore_unreachable             Boolean that allows you to ignore unreachable hosts and continue with play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.
max_fail_percentage            can be used to abort the run after a given percentage of hosts in the current batch has failed.
module_defaults                Specifies default parameter values for modules.
name                           Identifier. Can be used for documentation, in or tasks/handlers.
no_log                         Boolean that controls information disclosure.
order                          Controls the sorting of hosts as they are used for executing the play. Possible values are inventory (default), sorted, reverse_sorted, reverse_inventory and shuffle.
port                           Used to override the default port used in a connection.
post_tasks                     A list of tasks to execute after the tasks section.
pre_tasks                      A list of tasks to execute before roles.
remote_user                    User used to log into the target via the connection plugin.
roles                          List of roles to be imported into the play
run_once                       Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.
serial                         Explicitly define how Ansible batches the execution of the current play on the play’s target
strategy                       Allows you to choose the connection plugin to use for the play.
tags                           Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.
tasks                          Main list of tasks to execute in the play, they run after roles and before post_tasks.
vars                           Dictionary/map of variables
vars_files                     List of files that contain vars to include in the play.
vars_prompt                    list of variables to prompt for.

# Role
any_errors_fatal               Force any un-handled task errors on any host to propagate to all hosts and end the play.
become                         Boolean that controls if privilege escalation is used or not on Task execution.
become_flags                   A string of flag(s) to pass to the privilege escalation program when become is True.
become_method                  Which method of privilege escalation to use (such as sudo or su).
become_user                    User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.
check_mode                     A boolean that controls if a task is executed in ‘check’ mode
collections                    UNDOCUMENTED!!
connection                     Allows you to change the connection plugin used for tasks to execute on the target.
debugger                       Enable debugging tasks based on state of the task result. See Playbook Debugger
delegate_facts                 Boolean that allows you to apply facts to a delegated host instead of inventory_hostname.
delegate_to                    Host to execute task instead of the target (inventory_hostname). Connection vars from the delegated host will also be used for the task.
diff                           Toggle to make tasks return ‘diff’ information or not.
environment                    A dictionary that gets converted into environment vars to be provided for the task upon execution. This cannot affect Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task.
ignore_errors                  Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.
ignore_unreachable             Boolean that allows you to ignore unreachable hosts and continue with play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.
module_defaults                Specifies default parameter values for modules.
name                           Identifier. Can be used for documentation, in or tasks/handlers.
no_log                         Boolean that controls information disclosure.
port                           Used to override the default port used in a connection.
remote_user                    User used to log into the target via the connection plugin.
run_once                       Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.
tags                           Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.
vars                           Dictionary/map of variables
when                           Conditional expression, determines if an iteration of a task is run or not.

# Block
always                         List of tasks, in a block, that execute no matter if there is an error in the block or not.
any_errors_fatal               Force any un-handled task errors on any host to propagate to all hosts and end the play.
become                         Boolean that controls if privilege escalation is used or not on Task execution.
become_flags                   A string of flag(s) to pass to the privilege escalation program when become is True.
become_method                  Which method of privilege escalation to use (such as sudo or su).
become_user                    User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.
block                          List of tasks in a block.
check_mode                     A boolean that controls if a task is executed in ‘check’ mode
collections                    UNDOCUMENTED!!
connection                     Allows you to change the connection plugin used for tasks to execute on the target.
debugger                       Enable debugging tasks based on state of the task result. See Playbook Debugger
delegate_facts                 Boolean that allows you to apply facts to a delegated host instead of inventory_hostname.
delegate_to                    Host to execute task instead of the target (inventory_hostname). Connection vars from the delegated host will also be used for the task.
diff                           Toggle to make tasks return ‘diff’ information or not.
environment                    A dictionary that gets converted into environment vars to be provided for the task upon execution. This cannot affect Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task.
ignore_errors                  Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.
ignore_unreachable             Boolean that allows you to ignore unreachable hosts and continue with play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.
module_defaults                Specifies default parameter values for modules.
name                           Identifier. Can be used for documentation, in or tasks/handlers.
no_log                         Boolean that controls information disclosure.
port                           Used to override the default port used in a connection.
remote_user                    User used to log into the target via the connection plugin.
rescue                         List of tasks in a block that run if there is a task error in the main block list.
run_once                       Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.
tags                           Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.
vars                           Dictionary/map of variables
when                           Conditional expression, determines if an iteration of a task is run or not.

# Task
action                         The ‘action’ to execute for a task, it normally translates into a C(module) or action plugin.
any_errors_fatal               Force any un-handled task errors on any host to propagate to all hosts and end the play.
args                           A secondary way to add arguments into a task. Takes a dictionary in which keys map to options and values.
async                          Run a task asynchronously if the C(action) supports this; value is maximum runtime in seconds.
become                         Boolean that controls if privilege escalation is used or not on Task execution.
become_flags                   A string of flag(s) to pass to the privilege escalation program when become is True.
become_method                  Which method of privilege escalation to use (such as sudo or su).
become_user                    User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.
changed_when                   Conditional expression that overrides the task’s normal ‘changed’ status.
check_mode                     A boolean that controls if a task is executed in ‘check’ mode
collections                    UNDOCUMENTED!!
connection                     Allows you to change the connection plugin used for tasks to execute on the target.
debugger                       Enable debugging tasks based on state of the task result. See Playbook Debugger
delay                          Number of seconds to delay between retries. This setting is only used in combination with until.
delegate_facts                 Boolean that allows you to apply facts to a delegated host instead of inventory_hostname.
delegate_to                    Host to execute task instead of the target (inventory_hostname). Connection vars from the delegated host will also be used for the task.
diff                           Toggle to make tasks return ‘diff’ information or not.
environment                    A dictionary that gets converted into environment vars to be provided for the task upon execution. This cannot affect Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task.
failed_when                    Conditional expression that overrides the task’s normal ‘failed’ status.
ignore_errors                  Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.
ignore_unreachable             Boolean that allows you to ignore unreachable hosts and continue with play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.
local_action                   Same as action but also implies delegate_to: localhost
loop                           Takes a list for the task to iterate over, saving each list element into the item variable (configurable via loop_control)
loop_control                   Several keys here allow you to modify/set loop behaviour in a task.
module_defaults                Specifies default parameter values for modules.
name                           Identifier. Can be used for documentation, in or tasks/handlers.
no_log                         Boolean that controls information disclosure.
notify                         List of handlers to notify when the task returns a ‘changed=True’ status.
poll                           Sets the polling interval in seconds for async tasks (default 10s).
port                           Used to override the default port used in a connection.
register                       Name of variable that will contain task status and module return data.
remote_user                    User used to log into the target via the connection plugin.
retries                        Number of retries before giving up in a until loop. This setting is only used in combination with until.
run_once                       Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.
tags                           Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.
until                          This keyword implies a ‘retries loop’ that will go on until the condition supplied here is met or we hit the retries limit.
vars                           Dictionary/map of variables
when                           Conditional expression, determines if an iteration of a task is run or not.
with_<lookup_plugin>           The same as loop but magically adds the output of any lookup plugin to generate the item list.


webservers:dbservers   # OR group
webservers:!phoenix    # exclude group
webservers:&staging    # AND group
webservers:dbservers:&staging:!phoenix # The above configuration means “all machines in the groups ‘webservers’ and ‘dbservers’ are to be managed if they are in the group ‘staging’ also, but the machines are not to be managed if they are in the group ‘phoenix’ ... whew!
webservers:!{{excluded}}:&{{required}}

~(web|db).*\.example\.com # usually pattern is glob, but starting pattern with tilde ~ makes it a regex

# vault
yq r extra_vars/credentials.yml my.yaml.path.to.secret | ansible-vault decrypt  --vault-id prod@secrets/ansible-vault-prod --vault-id dev@secrets/ansible-vault-dev

# filters
{{ some_variable | to_json }}
{{ some_variable | to_yaml }}
{{ some_variable | to_nice_json }}
{{ some_variable | to_nice_yaml }}
{{ some_variable | to_nice_json(indent=2) }}
{{ some_variable | to_nice_yaml(indent=8) }}
{{ some_variable | to_yaml(indent=8, width=1337) }}
{{ some_variable | to_nice_yaml(indent=8, width=1337) }}
{{ some_variable | from_json }}
{{ some_variable | from_yaml }}
myvar: "{{ result.stdout | from_json }}"
loop: '{{ result.stdout | from_yaml_all | list }}'
{{ variable | mandatory }}
{{ some_variable | default(5) }}
{{ lookup('env', 'MY_USER') | default('admin', true) }}
file: dest={{ item.path }} state=touch mode={{ item.mode | default(omit) }}
{{ list1 | min }}
{{ [3, 4, 2] | max }}
{{ [3, [4, 2] ] | flatten }}
{{ [3, [4, [2]] ] | flatten(levels=1) }}
{{ list1 | unique }}
{{ list1 | union(list2) }}
{{ list1 | intersect(list2) }}
{{ list1 | difference(list2) }}
{{ list1 | symmetric_difference(list2) }}
{{ dict | dict2items }}
{{ files | dict2items(key_name='file', value_name='path') }}
{{ tags | items2dict }}
{{ tags | items2dict(key_name='key', value_name='value') }}
msg: "{{ [1,2,3,4,5] | zip(['a','b','c','d','e','f']) | list }}"
msg: "{{ [1,2,3] | zip(['a','b','c','d','e','f']) | list }}"
msg: "{{ [1,2,3] | zip_longest(['a','b','c','d','e','f'], [21, 22, 23], fillvalue='X') | list }}"
{{ dict(keys_list | zip(values_list)) }}
{{ users | subelements('groups', skip_missing=True) }}
key: "{{ lookup('file', item.1) }}"
loop: "{{ users | subelements('authorized') }}"
"{{ '52:54:00' | random_mac }}"
"{{ ['a','b','c'] | random }}"
"{{ 60 | random }} * * * * root /script/from/cron"
{{ 101 | random(step=10) }}
{{ 101 | random(1, 10) }}
{{ 101 | random(start=1, step=10) }}
"{{ 60 | random(seed=inventory_hostname) }} * * * * root /script/from/cron"
{{ ['a','b','c'] | shuffle }}
{{ ['a','b','c'] | shuffle }}
{{ ['a','b','c'] | shuffle(seed=inventory_hostname) }}
Get the logarithm (default is e):
{{ myvar | log }}
{{ myvar | log(10) }}
Give me the power of 2! (or 5):
{{ myvar | pow(2) }}
{{ myvar | pow(5) }}
{{ myvar | root }}
{{ myvar | root(5) }}
loop: "{{ domain_definition | json_query('domain.cluster[*].name') }}"
loop: "{{ domain_definition | json_query('domain.server[*].name') }}"
loop: "{{ domain_definition | json_query(server_name_cluster1_query) }}"
msg: "{{ domain_definition | json_query('domain.server[?cluster==`cluster1`].port') | join(', ') }}"
loop: "{{ domain_definition | json_query('domain.server[?cluster==''cluster1''].port') }}"
loop: "{{ domain_definition | json_query(server_name_cluster1_query) }}"
{{ myvar | ipaddr }}
{{ myvar | ipv4 }}
{{ myvar | ipv6 }}
{{ '192.0.2.1/24' | ipaddr('address') }}
{{ output | parse_cli('path/to/spec') }}
items: "^(?P<vlan_id>\\d+)\\s+(?P<name>\\w+)\\s+(?P<state>active|act/lshut|suspended)"
items: "^(?P<vlan_id>\\d+)\\s+(?P<name>\\w+)\\s+(?P<state>active|act/lshut|suspended)"
- "^(?P<name>Ethernet\\d\\/\\d*)"
- "admin state is (?P<state>.+),"
- "Port mode is (.+)"
{{ output.stdout[0] | parse_cli_textfsm('path/to/fsm') }}
{{ output | parse_xml('path/to/spec') }}
enabled: "{{ item.state.get('inactive') != 'inactive' }}"
state: "{% if item.state.get('inactive') == 'inactive'%} inactive {% else %} active {% endif %}"
enabled: "{{ item.state.get('inactive') != 'inactive' }}"
state: "{% if item.state.get('inactive') == 'inactive'%} inactive {% else %} active {% endif %}"
{{ 'test1' | hash('sha1') }}
{{ 'test1' | hash('md5') }}
{{ 'test2' | checksum }}
Other hashes (platform dependent):
{{ 'test2' | hash('blowfish') }}
To get a sha512 password hash (random salt):
{{ 'passwordsaresecret' | password_hash('sha512') }}
{{ 'secretpassword' | password_hash('sha256', 'mysecretsalt') }}
{{ 'secretpassword' | password_hash('sha512', 65534 | random(seed=inventory_hostname) | string) }}
{{ 'secretpassword' | password_hash('sha256', 'mysecretsalt', rounds=10000) }}
{{ {'a':1, 'b':2} | combine({'b':3}) }}
{{ {'a':{'foo':1, 'bar':2}, 'b':2} | combine({'a':{'bar':3, 'baz':4}}, recursive=True) }}
{{ a | combine(b, c, d) }}
{{ [0,2] | map('extract', ['x','y','z']) | list }}
{{ ['x','y'] | map('extract', {'x': 42, 'y': 31}) | list }}
{{ groups['x'] | map('extract', hostvars, 'ec2_ip_address') | list }}
{{ ['a'] | map('extract', b, ['x','y']) | list }}
{{ "Plain style (default)" | comment }}
# Plain style (default)
{{ "C style" | comment('c') }}
{{ "C block style" | comment('cblock') }}
{{ "Erlang style" | comment('erlang') }}
{{ "XML style" | comment('xml') }}
{{ "My Special Case" | comment(decoration="! ") }}
{{ "Custom style" | comment('plain', prefix='#######\n#', postfix='#\n#######\n   ###\n    #') }}
{{ ansible_managed | comment }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('hostname') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('netloc') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('username') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('password') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('path') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('port') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('scheme') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('query') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit('fragment') }}
{{ "http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment" | urlsplit }}
{{ 'foobar' | regex_search('(foo)') }}
{{ 'ansible' | regex_search('(foobar)') }}
{{ 'foo\nBAR' | regex_search("^bar", multiline=True, ignorecase=True) }}
{{ 'Some DNS servers are 8.8.8.8 and 8.8.4.4' | regex_findall('\\b(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\b') }}
{{ 'ansible' | regex_replace('^a.*i(.*)$', 'a\\1') }}
{{ 'foobar' | regex_replace('^f.*o(.*)$', '\\1') }}
{{ 'localhost:80' | regex_replace('^(?P<host>.+):(?P<port>\\d+)$', '\\g<host>, \\g<port>') }}
{{ 'localhost:80' | regex_replace(':80') }}
{{ hosts | map('regex_replace', '^(.*)$', 'https://\\1') | list }}
# convert '^f.*o(.*)$' to '\^f\.\*o\(\.\*\)\$'
{{ '^f.*o(.*)$' | regex_escape() }}
# convert '^f.*o(.*)$' to '\^f\.\*o(\.\*)\$'
{{ '^f.*o(.*)$' | regex_escape('posix_basic') }}
{{ configmap_resource_definition | k8s_config_resource_name }}
name: {{ my_secret | k8s_config_resource_name }}
- shell: echo {{ string_value | quote }}
{{ (name == "John") | ternary('Mr','Ms') }}
{{ enabled | ternary('no shutdown', 'shutdown', omit) }}
{{ list | join(" ") }}
{{ path | basename }}
{{ path | win_basename }}
{{ path | win_splitdrive }}
{{ path | win_splitdrive | first }}
{{ path | win_splitdrive | last }}
{{ path | dirname }}
{{ path | win_dirname }}
{{ path | expanduser }}
{{ path | expandvars }}
{{ path | realpath }}
{{ path | relpath('/etc') }}
{{ path | splitext }}
{{ encoded | b64decode }}
{{ decoded | b64encode }}
{{ encoded | b64decode(encoding='utf-16-le') }}
{{ decoded | b64encode(encoding='utf-16-le') }}
{{ hostname | to_uuid }}
when: some_string_value | bool
{{ ansible_mounts | map(attribute='mount') | join(',') }}
{{ (("2016-08-14 20:00:12" | to_datetime) - ("2015-12-25" | to_datetime('%Y-%m-%d'))).total_seconds()  }}
{{ (("2016-08-14 20:00:12" | to_datetime) - ("2016-08-14 18:00:00" | to_datetime)).seconds  }}
{{ (("2016-08-14 20:00:12" | to_datetime) - ("2015-12-25" | to_datetime('%Y-%m-%d'))).days  }}
{{ '%Y-%m-%d' | strftime }}
{{ '%H:%M:%S' | strftime }}
{{ '%Y-%m-%d %H:%M:%S' | strftime(ansible_date_time.epoch) }}
{{ '%Y-%m-%d' | strftime(0) }}          # => 1970-01-01
{{ '%Y-%m-%d' | strftime(1441357287) }} # => 2015-09-04
- name: give me largest permutations (order matters)
msg: "{{ [1,2,3,4,5] | permutations | list }}"
msg: "{{ [1,2,3,4,5] | permutations(3) | list }}"
msg: "{{ [1,2,3,4,5] | combinations(2) | list }}"
msg: "{{ ['foo', 'bar'] | product(['com']) | map('join', '.') | join(',') }}"
{{ myvar | type_debug }}
- '"1.00 Bytes" == 1|human_readable'
- '"1.00 bits" == 1|human_readable(isbits=True)'
- '"10.00 KB" == 10240|human_readable'
- '"97.66 MB" == 102400000|human_readable'
- '"0.10 GB" == 102400000|human_readable(unit="G")'
- '"0.10 Gb" == 102400000|human_readable(isbits=True, unit="G")'
- "{{'0'|human_to_bytes}}        == 0"
- "{{'0.1'|human_to_bytes}}      == 0"
- "{{'0.9'|human_to_bytes}}      == 1"
- "{{'1'|human_to_bytes}}        == 1"
- "{{'10.00 KB'|human_to_bytes}} == 10240"
- "{{   '11 MB'|human_to_bytes}} == 11534336"
- "{{  '1.1 GB'|human_to_bytes}} == 1181116006"
- "{{'10.00 Kb'|human_to_bytes(isbits=True)}} == 10240"
{% if loop.index is divisibleby(3) %}
# for href, caption in [('index.html', 'Index'),
('about.html', 'About')]:
{{ super() }}
<h1>{{ self.title() }}</h1>
{{ super() }}
{{ user.username|e }}
the template, with the |safe filter
<li>{{ user.username|e }}</li>
{% for key, value in my_dict.iteritems() %}
<dt>{{ key|e }}</dt>
<dd>{{ value|e }}</dd>
loop.index	The current iteration of the loop. (1 indexed)
loop.index0	The current iteration of the loop. (0 indexed)
loop.revindex	The number of iterations from the end of the loop (1 indexed)
loop.revindex0	The number of iterations from the end of the loop (0 indexed)
loop.changed(*val)	True if previously called with a different value (or not called at all).
<li class="{{ loop.cycle('odd', 'even') }}">{{ row }}</li>
<li>{{ user.username|e }}</li>
<li>{{ user.username|e }}</li>
<li><a href="{{ item.href|e }}">{{ item.title }}</a>
<ul class="submenu">{{ loop(item.children) }}</ul>
{% if loop.changed(entry.category) %}
<li>{{ user.username|e }}</li>
{% macro input(name, value='', type='text', size=20) -%}
value|e }}" size="{{ size }}">
<p>{{ input('username') }}</p>
<p>{{ input('password', type='password') }}</p>
This is true if the macro accepts extra positional arguments (i.e.: accesses the special varargs variable).
{% macro render_dialog(title, class='dialog') -%}
{{ caller() }}
{% call render_dialog('Hello World') %}
{% macro dump_users(users) -%}
<li><p>{{ user.username|e }}</p>{{ caller(user) }}</li>
{% call(user) dump_users(list_of_user) %}
<dd>{{ user.realname|e }}</dd>
{% set navigation = [('index.html', 'Index'), ('about.html', 'About')] %}
{% set key, value = call_something() %}
{% set ns = namespace(found=false) %}
{% if item.check_something() %}
{% set reply | wordwrap %}
{% macro input(name, value='', type='text') -%}
<input type="{{ type }}" value="{{ value|e }}" name="{{ name }}">
{%- macro textarea(name, value='', rows=10, cols=40) -%}
}}">{{ value|e }}</textarea>
<dd>{{ forms.input('username') }}</dd>
<dd>{{ forms.input('password', type='password') }}</dd>
<p>{{ forms.textarea('comment') }}</p>
<dd>{{ input_field('username') }}</dd>
<dd>{{ input_field('password', type='password') }}</dd>
<p>{{ textarea('comment') }}</p>
{% for href, caption in [('index.html', 'Index'), ('about.html', 'About'),
 ('downloads.html', 'Downloads')] %}
(‘tuple’, ‘of’, ‘values’):
negate a statement (see below).
(expr)
|
{{ "Hello " ~ name ~ "!" }} would return (assuming name is set to 'John') Hello John!.
()
{{ post.render(user, full=true) }}.
Get an attribute of an object. (See Variables)
abs(number)
attr(obj, name)
batch(value, linecount, fill_with=None)
{%- for row in items|batch(3, '&nbsp;') %}
capitalize(s)
center(value, width=80)
default(value, default_value=u'', boolean=False)
{{ my_variable|default('my_variable is not defined') }}
{{ ''|default('the string was empty', true) }}
dictsort(value, case_sensitive=False, by='key', reverse=False)
{% for item in mydict|dictsort %}
{% for item in mydict|dictsort(reverse=true) %}
{% for item in mydict|dictsort(true) %}
{% for item in mydict|dictsort(false, 'value') %}
escape(s)
filesizeformat(value, binary=False)
first(seq)
float(value, default=0.0)
forceescape(value)
format(value, *args, **kwargs)
{{ "%s - %s"|format("Hello?", "Foo!") }}
groupby(value, attribute)
{% for group in persons|groupby('gender') %}
{% for grouper, list in persons|groupby('gender') %}
indent(s, width=4, first=False, blank=False, indentfirst=None)
int(value, default=0, base=10)
join(value, d=u'', attribute=None)
{{ [1, 2, 3]|join('|') }}
-> 1|2|3
{{ [1, 2, 3]|join }}
{{ users|join(', ', attribute='username') }}
last(seq)
length(object)
list(value)
lower(s)
map()
Users on this page: {{ users|map(attribute='username')|join(', ') }}
Users on this page: {{ titles|map('lower')|join(', ') }}
max(value, case_sensitive=False, attribute=None)
{{ [1, 2, 3]|max }}
min(value, case_sensitive=False, attribute=None)
{{ [1, 2, 3]|min }}
pprint(value, verbose=False)
random(seq)
reject()
{{ numbers|reject("odd") }}
rejectattr()
{{ users|rejectattr("is_active") }}
{{ users|rejectattr("email", "none") }}
replace(s, old, new, count=None)
{{ "Hello World"|replace("Hello", "Goodbye") }}
{{ "aaaaargh"|replace("a", "d'oh, ", 2) }}
reverse(value)
round(value, precision=0, method='common')
{{ 42.55|round }}
{{ 42.55|round(1, 'floor') }}
{{ 42.55|round|int }}
safe(value)
select()
{{ numbers|select("odd") }}
{{ numbers|select("odd") }}
{{ numbers|select("divisibleby", 3) }}
{{ numbers|select("lessthan", 42) }}
{{ strings|select("equalto", "mystring") }}
selectattr()
{{ users|selectattr("is_active") }}
{{ users|selectattr("email", "none") }}
slice(value, slices, fill_with=None)
{%- for column in items|slice(3) %}
sort(value, reverse=False, case_sensitive=False, attribute=None)
{% for item in iterable|sort %}
{% for item in iterable|sort(attribute='date') %}
string(object)
striptags(value)
sum(iterable, attribute=None, start=0)
Total: {{ items|sum(attribute='price') }}
title(s)
tojson(value, indent=None)
trim(value) # strip
| trim() # strip
truncate(s, length=255, killwords=False, end='...', leeway=None)
{{ "foo bar baz qux"|truncate(9) }}
{{ "foo bar baz qux"|truncate(9, True) }}
{{ "foo bar baz qux"|truncate(11) }}
{{ "foo bar baz qux"|truncate(11, False, '...', 0) }}
unique(value, case_sensitive=False, attribute=None)
{{ ['foo', 'bar', 'foobar', 'FooBar']|unique }}
upper(s)
urlencode(value)
urlize(value, trim_url_limit=None, nofollow=False, target=None, rel=None)
{{ mytext|urlize(40, true) }}
{{ mytext|urlize(40, target='_blank') }}
wordcount(s)
wordwrap(s, width=79, break_long_words=True, wrapstring=None)
xmlattr(d, autospace=True)
'id': 'list-%d'|format(variable)}|xmlattr }}>
callable(object)
defined(value)
divisibleby(value, num)
eq(a, b)
escaped(value)
even(value)
ge(a, b)
gt(a, b)
in(value, seq)
iterable(value)
le(a, b)
lower(value)
lt(a, b)
mapping(value)
ne(a, b)
none(value)
number(value)
odd(value)
sameas(value, other)
sequence(value)
string(value)
undefined(value)
Like defined() but the other way round.
upper(value)
range([start, ]stop[, step])
{% for number in range(10 - users|count) %}
lipsum(n=5, html=True, min=20, max=100)
dict(**items)
class cycler(*items)
{% set row_class = cycler('odd', 'even') %}
<li class="folder {{ row_class.next() }}">{{ folder|e }}</li>
<li class="file {{ row_class.next() }}">{{ filename|e }}</li>
reset()
next()
class joiner(sep=', ')
{% set pipe = joiner("|") %}
{% if categories %} {{ pipe() }}
Categories: {{ categories|join(", ") }}
{% if author %} {{ pipe() }}
Author: {{ author() }}
{% if can_edit %} {{ pipe() }}
class namespace(...)
{% set ns = namespace() %}
{% set ns = namespace(found=false) %}
{% if item.check_something() %}
{% trans count=list|length %}
{% trans ..., user_count=users|length %}...
{{ _('Hello World!') }}
{{ _('Hello %(user)s!')|format(user=user.username) }}
{{ gettext('Hello World!') }}
{{ gettext('Hello %(name)s!', name='World') }}
{{ ngettext('%(num)d apple', '%(num)d apples', apples|count) }}
{% do navigation.append('a string') %}
Development (unstable)
Jinja 2.10.x (stable)
