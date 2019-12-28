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
- debug: var=hostvars[inventory_hostname]
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
tasks:
    - debug:
        msg: "matched pattern 1"
      when: url is match("http://example.com/users/.*/resources/.*") # regexp

    - debug:
        msg: "matched pattern 2"
      when: url is search("/users/.*/resources/.*") # regexp
 # regexp
    - debug:
        msg: "matched pattern 3"
      when: url is search("/users/") # regexp

    - debug:
        msg: "matched pattern 4"
      when: url is regex("example.com/\w+/foo") # regexp

      when: url is match("http://example.com/users/.*/resources/.*") # regex
      when: url is search("/users/.*/resources/.*") # regex

```yaml
- include: ....
    when: optional_file|exists # deprecated
    when: not optional_file|exists # deprecated
- include_vars:                  # implicit exists for include
    depth: 1                     # implicit exists for include
    dir: vars                    # implicit exists for include
    files_matching: "{{ item }}" # implicit exists for include
  with_items:                    # implicit exists for include
    - myname.yml                 # implicit exists for include

# -------------------------------# exists                               
- stat:                          # exists
    path: /var/log/secure        # exists
  register: stat_secure          # exists
- debug:                         # exists
    msg: file exists             # exists
  when: stat_secure.stat.exists  # exists
# -------------------------------# exists                               
```


```json
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
ansible localhost -m setup -a "gather_subset=all"      | grep -E ""
ansible localhost -m setup -a "gather_subset=min"      | grep -E ""
ansible localhost -m setup -a "gather_subset=hardware" | grep -E ""
ansible localhost -m setup -a "gather_subset=network"  | grep -E ""
ansible localhost -m setup -a "gather_subset=virtual"  | grep -E ""
ansible localhost -m setup -a "gather_subset=oha"      | grep -E ""
for i in min hardware network virtual oha all; do ansible localhost -m setup -a "gather_subset=$i" | sed -n -r -e "s/(ansible.*)/$i: \\1/"; done
gather_subset options allowed: all, all_ipv4_addresses, all_ipv6_addresses, apparmor, architecture, caps, chroot, cmdline, date_time, default_ipv4, default_ipv6, devices, distribution, distribution_major_version, distribution_release, distribution_version, dns, effective_group_ids, effective_user_id, env, facter, fibre_channel_wwn, fips, hardware, interfaces, is_chroot, iscsi, kernel, kernel_version, local, lsb, machine, machine_id, mounts, network, nvme, ohai, os_family, pkg_mgr, platform, processor, processor_cores, processor_count, python, python_version, real_user_id, selinux, service_mgr, ssh_host_key_dsa_public, ssh_host_key_ecdsa_public, ssh_host_key_ed25519_public, ssh_host_key_rsa_public, ssh_host_pub_keys, ssh_pub_keys, system, system_capabilities, system_capabilities_enforced, user, user_dir, user_gecos, user_gid, user_id, user_shell, user_uid, virtual, virtualization_role, virtualization_type

ansible all -m yum -a "name=httpd state=present"
ansible all -m apt -a "name=httpd state=present"
ansible web -m service -a "name=httpd state=started"
ansible web -m service -a "name=httpd state=restarted"
ansible all -m file -a "path=/project/devops state=directory"
ansible web -m copy -a "src=/etc/hosts dest=/tmp/hosts"
ansible all -m file -a "path=/project/devops/abcd.txt  state=touch"
ansible all -m user -a "name=ansible group=devops password=ansible123"
ansible all -m setup
ansible -m reboot -i inventory.yml -b
ansible web -m group -a "name=devops state=present"
ansible web -m command -a "free -m"
ansible zabbix_proxy -c local -i inventory.yml -m shell -a "sh -c 'printf \"GREP %s: %s\n\" {{inventory_hostname}} \"\$(dig +short {{ inventory_hostname }})\"'"
sudo ansible localhost user -a "name=mysql-backup home=/data/mysql-backup"
sudo ansible localhost -m user -a "name=mysql-backup state=absent"
sudo ansible localhost -m authorized_key -a "user=mysql-backup key_options='no-port-forwarding,from="10.0.1.1"' key='ssh-rsa '"
ansible -i inventory.yml HOSTNAME -m authorized_key -a "user=ansible exclusive=no comment=id_rsa_ansible key='$(cat ~/.ssh/id_rsa_ansible.pub)'"
ansible -i inventory.yml "green:&linux" -m shell -a "cat /proc/loadavg" # cpu usage
ansible -i inventory.yml "green:&linux" -m shell -a "netstat -tn | wc -l" # network connections number

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
https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg
[defaults]
roles_path    = ../common/ansible/roles/
action_warnings                          True                           By default Ansible will issue a warning when received from a task action (module or action plugin) These warnings can be silenced by adjusting this setting to False.
agnostic_become_prompt                   True                           Display an agnostic become prompt instead of displaying a prompt containing the command line supplied become method
allow_world_readable_tmpfiles            False                          This makes the temporary files created on the machine to be world readable and will issue a warning instead of failing the task. It is useful when becoming an unprivileged user.
ansible_connection_path                  None                           Specify where to look for the ansible-connection script. This location will be checked before searching $PATH. If null, ansible will start with the same directory as the ansible script.
ansible_cow_path                         None                           Specify a custom cowsay path or swap in your cowsay implementation of choice
ansible_cow_selection                    default                        This allows you to chose a specific cowsay stencil for the banners or use ‘random’ to cycle through them.
ansible_cow_whitelist                    [‘bud-frogs’,              ‘bunny’, ‘cheese’, ‘daemon’, ‘default’, ‘dragon’, ‘elephant-in-snake’, ‘elephant’, ‘eyes’, ‘hellokitty’, ‘kitty’, ‘luke-koala’, ‘meow’, ‘milk’, ‘moofasa’, ‘moose’, ‘ren’, ‘sheep’, ‘small’, ‘stegosaurus’, ‘stimpy’, ‘supermilker’, ‘three-eyes’, ‘turkey’, ‘turtle’, ‘tux’, ‘udder’, ‘vader-koala’, ‘vader’, ‘www’] White list of cowsay templates that are ‘safe’ to use, set to empty list if you want to enable all installed templates.
ansible_force_color                      False                          This options forces color mode even when running without a TTY or the “nocolor” setting is True.
ansible_nocolor                          False                          This setting allows suppressing colorizing output, which is used to give a better indication of failure and status information.
ansible_nocows                           False                          If you have cowsay installed but want to avoid the ‘cows’ (why????), use this.
ansible_pipelining                       False                          Pipelining, if supported by the connection plugin, reduces the number of network operations required to execute a module on the remote server, by executing many Ansible modules without actual file transfer. This can result in a very significant performance improvement when enabled. However this conflicts with privilege escalation (become). For example, when using ‘sudo:’ operations you must first disable ‘requiretty’ in /etc/sudoers on all managed hosts, which is why it is disabled by default. This options is disabled if ANSIBLE_KEEP_REMOTE_FILES is enabled.
ansible_ssh_args                         -C                             -o ControlMaster=auto -o ControlPersist=60s If set, this will override the Ansible default ssh arguments. In particular, users may wish to raise the ControlPersist time to encourage performance. A value of 30 minutes may be appropriate. Be aware that if -o ControlPath is set in ssh_args, the control path setting is not used.
ansible_ssh_control_path                 None                           This is the location to save ssh’s ControlPath sockets, it uses ssh’s variable substitution. Since 2.3, if null, ansible will generate a unique hash. Use %(directory)s to indicate where to use the control dir path setting. Before 2.3 it defaulted to control_path=%(directory)s/ansible-ssh-%%h-%%p-%%r. Be aware that this setting is ignored if -o ControlPath is set in ssh args.
ansible_ssh_control_path_dir             ~/.ansible/cp                  This sets the directory to use for ssh control path if the control path setting is null. Also, provides the %(directory)s variable for the control path setting.
ansible_ssh_executable                   ssh                            This defines the location of the ssh binary. It defaults to ssh which will use the first ssh binary available in $PATH. This option is usually not required, it might be useful when access to system ssh is restricted, or when using ssh wrappers to connect to remote hosts.
ansible_ssh_retries                      0                              Number of attempts to establish a connection before we give up and report the host as ‘UNREACHABLE’
any_errors_fatal                         False                          Sets the default value for the any_errors_fatal keyword, if True, Task failures will be considered fatal errors.
become_allow_same_user                   False                          This setting controls if become is skipped when remote user and become user are the same. I.E root sudo to root.
become_plugin_path                       ~/.ansible/plugins/become:/usr/share/ansible/plugins/become Colon separated paths in which Ansible will search for Become Plugins.
cache_plugin                             memory                         Chooses which cache plugin to use, the default ‘memory’ is ephimeral.
cache_plugin_connection                  None                           Defines connection or path information for the cache plugin
cache_plugin_prefix                      ansible_facts                  Prefix to use for cache plugin files/tables
cache_plugin_timeout                     86400                          Expiration timeout for the cache plugin data
collections_paths                        ~/.ansible/collections:/usr/share/ansible/collections Defines the color to use on ‘Changed’ task status
color_changed                            yellow                         Defines the default color to use for ansible-console
color_console_prompt                     white                          Defines the color to use when emitting debug messages
color_debug                              dark                           gray Defines the color to use when emitting deprecation messages
color_deprecate                          purple                         Defines the color to use when showing added lines in diffs
color_diff_add                           green                          Defines the color to use when showing diffs
color_diff_lines                         cyan                           Defines the color to use when showing removed lines in diffs
color_diff_remove                        red                            Defines the color to use when emitting error messages
color_error                              red                            Defines the color to use for highlighting
color_highlight                          white                          Defines the color to use when showing ‘OK’ task status
color_ok                                 green                          Defines the color to use when showing ‘Skipped’ task status
color_skip                               cyan                           Defines the color to use on ‘Unreachable’ status
color_unreachable                        bright                         red Defines the color to use when emitting verbose messages. i.e those that show with ‘-v’s.
color_verbose                            blue                           Defines the color to use when emitting warning messages
color_warn                               bright                         purple By default Ansible will issue a warning when the shell or command module is used and the command appears to be similar to an existing Ansible module. These warnings can be silenced by adjusting this setting to False. You can also control this at the task level with the module option warn.
command_warnings                         True                           With this setting on (True), running conditional evaluation ‘var’ is treated differently than ‘var.subkey’ as the first is evaluated directly while the second goes through the Jinja2 parser. But ‘false’ strings in ‘var’ get evaluated as booleans. With this setting off they both evaluate the same but in cases in which ‘var’ was ‘false’ (a string) it won’t get evaluated as a boolean anymore. Currently this setting defaults to ‘True’ but will soon change to ‘False’ and the setting itself will be removed in the future. Expect the default to change in version 2.10 and that this setting eventually will be deprecated after 2.12
conditional_bare_vars                    True                           Which modules to run during a play’s fact gathering stage based on connection
connection_facts_modules                 {‘junos’:                  ‘junos_facts’, ‘eos’: ‘eos_facts’, ‘frr’: ‘frr_facts’, ‘iosxr’: ‘iosxr_facts’, ‘nxos’: ‘nxos_facts’, ‘ios’: ‘ios_facts’, ‘vyos’: ‘vyos_facts’} Colon separated paths in which Ansible will search for Action Plugins.
default_action_plugin_path               ~/.ansible/plugins/action:/usr/share/ansible/plugins/action When enabled, this option allows lookup plugins (whether used in variables as {{lookup('foo')}} or as a loop as with_foo) to return data that is not marked ‘unsafe’. By default, such data is marked as unsafe to prevent the templating engine from evaluating any jinja2 templating language, as this could represent a security risk. This option is provided to allow for backwards-compatibility, however users should first consider adding allow_unsafe=True to any lookups which may be expected to contain data which may be run through the templating engine late
default_allow_unsafe_lookups             False                          This controls whether an Ansible playbook should prompt for a login password. If using SSH keys for authentication, you probably do not needed to change this setting.
default_ask_pass                         False                          This controls whether an Ansible playbook should prompt for a su password.
default_ask_su_pass                      False                          This controls whether an Ansible playbook should prompt for a sudo password.
default_ask_sudo_pass                    False                          This controls whether an Ansible playbook should prompt for a vault password.
default_ask_vault_pass                   False                          Toggles the use of privilege escalation, allowing you to ‘become’ another user after login.
default_become                           False                          Toggle to prompt for privilege escalation password.
default_become_ask_pass                  False                          executable to use for privilege escalation, otherwise Ansible will depend on PATH
default_become_exe                       None                           Flags to pass to the privilege escalation executable.
default_become_flags                     Description:                   escalation method to use when become is enabled.
default_become_method                    sudo                           The user your login/remote user ‘becomes’ when using privilege escalation, most systems will use ‘root’ when no user is specified.
default_become_user                      root                           Colon separated paths in which Ansible will search for Cache Plugins.
default_cache_plugin_path                ~/.ansible/plugins/cache:/usr/share/ansible/plugins/cache Whitelist of callable methods to be made available to template evaluation
default_callable_whitelist               []                             Colon separated paths in which Ansible will search for Callback Plugins.
default_callback_plugin_path             ~/.ansible/plugins/callback:/usr/share/ansible/plugins/callback List of whitelisted callbacks, not all callbacks need whitelisting, but many of those shipped with Ansible do as we don’t want them activated by default.
default_callback_whitelist               []                             Colon separated paths in which Ansible will search for Cliconf Plugins.
default_cliconf_plugin_path              ~/.ansible/plugins/cliconf:/usr/share/ansible/plugins/cliconf Colon separated paths in which Ansible will search for Connection Plugins.
default_connection_plugin_path           ~/.ansible/plugins/connection:/usr/share/ansible/plugins/connection Toggles debug output in Ansible. This is very verbose and can hinder multiprocessing. Debug output can also include secret information despite no_log settings being enabled, which means debug mode should not be used in production.
default_debug                            False                          This indicates the command to use to spawn a shell under for Ansible’s execution needs on a target. Users may need to change this in rare instances when shell usage is constrained, but in most cases it may be left as is.
default_executable                       /bin/sh                        This option allows you to globally configure a custom path for ‘local_facts’ for the implied M(setup) task when using fact gathering. If not set, it will fallback to the default from the M(setup) module: /etc/ansible/facts.d. This does not affect user defined tasks that use the M(setup) module.
default_fact_path                        None                           Colon separated paths in which Ansible will search for Jinja2 Filter Plugins.
default_filter_plugin_path               ~/.ansible/plugins/filter:/usr/share/ansible/plugins/filter This option controls if notified handlers run on a host even if a failure occurs on that host. When false, the handlers will not run if a failure has occurred on a host. This can also be set per play or on the command line. See Handlers and Failure for more details.
default_force_handlers                   False                          Maximum number of forks Ansible will use to execute tasks on target hosts.
default_forks                            5                              Set the gather_subset option for the M(setup) task in the implicit fact gathering. See the module documentation for specifics. It does not apply to user defined M(setup) tasks.
default_gather_subset                    [‘all’]                    Set the timeout in seconds for the implicit fact gathering. It does not apply to user defined M(setup) tasks.
default_gather_timeout                   10                             This setting controls the default policy of fact gathering (facts discovered about remote systems). When ‘implicit’ (the default), the cache plugin will be ignored and facts will be gathered per play unless ‘gather_facts: False’ is set. When ‘explicit’ the inverse is true, facts will not be gathered unless directly requested in the play. The ‘smart’ value means each new host that has no facts discovered will be scanned, but if the same host is addressed in multiple plays it will not be contacted again in the playbook run. This option can be useful for those wishing to save fact gathering time. Both ‘smart’ and ‘explicit’ will use the cache plugin.
default_gathering                        implicit                       Since 2.0 M(include) can be ‘dynamic’, this setting (if True) forces that if the include appears in a handlers section to be ‘static’.
default_handler_includes_static          False                          This setting controls how variables merge in Ansible. By default Ansible will override variables in specific precedence orders, as described in Variables. When a variable of higher precedence wins, it will replace the other value. Some users prefer that variables that are hashes (aka ‘dictionaries’ in Python terms) are merged. This setting is called ‘merge’. This is not the default behavior and it does not affect variables whose values are scalars (integers, strings) or arrays. We generally recommend not using this setting unless you think you have an absolute need for it, and playbooks in the official examples repos do not use this setting In version 2.0 a combine filter was added to allow doing this for a particular variable (described in Filters).
default_hash_behaviour                   replace                        Comma separated list of Ansible inventory sources
default_host_list                        /etc/ansible/hosts             Colon separated paths in which Ansible will search for HttpApi Plugins.
default_httpapi_plugin_path              ~/.ansible/plugins/httpapi:/usr/share/ansible/plugins/httpapi This sets the interval (in seconds) of Ansible internal processes polling each other. Lower values improve performance with large playbooks at the expense of extra CPU load. Higher values are more suitable for Ansible usage in automation scenarios, when UI responsiveness is not required but CPU usage might be a concern. The default corresponds to the value hardcoded in Ansible <= 2.1
default_internal_poll_interval           0.001                          Colon separated paths in which Ansible will search for Inventory Plugins.
default_inventory_plugin_path            ~/.ansible/plugins/inventory:/usr/share/ansible/plugins/inventory This is a developer-specific feature that allows enabling additional Jinja2 extensions. See the Jinja2 documentation for details. If you do not know what these do, you probably don’t need to change this setting :)
default_jinja2_extensions                []                             This option preserves variable types during template operations. This requires Jinja2 >= 2.10.
default_jinja2_native                    False                          Enables/disables the cleaning up of the temporary files Ansible used to execute the tasks on the remote. If this option is enabled it will disable ANSIBLE_PIPELINING.
default_keep_remote_files                False                          This setting causes libvirt to connect to lxc containers by passing –noseclabel to virsh. This is necessary when running on systems which do not have SELinux.
default_libvirt_lxc_noseclabel           False                          Controls whether callback plugins are loaded when running /usr/bin/ansible. This may be used to log activity from the command line, send notifications, and so on. Callback plugins are always loaded for ansible-playbook.
default_load_callback_plugins            False                          Temporary directory for Ansible to use on the controller.
default_local_tmp                        ~/.ansible/tmp                 List of logger names to filter out of the log file
default_log_filter                       []                             File to which Ansible will log on the controller. When empty logging is disabled.
default_log_path                         None                           Colon separated paths in which Ansible will search for Lookup Plugins.
default_lookup_plugin_path               ~/.ansible/plugins/lookup:/usr/share/ansible/plugins/lookup Sets the macro for the ‘ansible_managed’ variable available for M(template) and M(win_template) modules. This is only relevant for those two modules.
default_managed_str                      Ansible                        managed This sets the default arguments to pass to the ansible adhoc binary if no -a is specified.
default_module_args                      Description:                   scheme to use when transferring Python modules to the target.
default_module_compression               ZIP_DEFLATED                   Language locale setting to use for modules when they execute on the target. If empty it tries to set itself to the LANG environment variable on the controller. This is only used if DEFAULT_MODULE_SET_LOCALE is set to true
default_module_lang                      {{                             CONTROLLER_LANG }} Module to use with the ansible AdHoc command, if none is specified via -m.
default_module_name                      command                        Colon separated paths in which Ansible will search for Modules.
default_module_path                      ~/.ansible/plugins/modules:/usr/share/ansible/plugins/modules Controls if we set locale for modules when executing on the target.
default_module_set_locale                False                          Colon separated paths in which Ansible will search for Module utils files, which are shared by modules.
default_module_utils_path                ~/.ansible/plugins/module_utils:/usr/share/ansible/plugins/module_utils Colon separated paths in which Ansible will search for Netconf Plugins.
default_netconf_plugin_path              ~/.ansible/plugins/netconf:/usr/share/ansible/plugins/netconf Toggle Ansible’s display and logging of task details, mainly used to avoid security disclosures.
default_no_log                           False                          Toggle Ansible logging to syslog on the target when it executes tasks.
default_no_target_syslog                 False                          What templating should return as a ‘null’ value. When not set it will let Jinja2 decide.
default_null_representation              None                           For asynchronous tasks in Ansible (covered in Asynchronous Actions and Polling), this is how often to check back on the status of those tasks when an explicit poll interval is not supplied. The default is a reasonably moderate 15 seconds which is a tradeoff between checking in frequently and providing a quick turnaround when something may have completed.
default_poll_interval                    15                             Option for connections using a certificate or key file to authenticate, rather than an agent or passwords, you can set the default value here to avoid re-specifying –private-key with every invocation.
default_private_key_file                 None                           Makes role variables inaccessible from other roles. This was introduced as a way to reset role variables to default values if a role is used more than once in a playbook.
default_private_role_vars                False                          Port to use in remote connections, when blank it will use the connection plugin default.
default_remote_port                      None                           Sets the login user for the target machines When blank it uses the connection plugin’s default, normally the user currently executing Ansible.
default_remote_user                      None                           Colon separated paths in which Ansible will search for Roles.
default_roles_path                       ~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles Preferred method to use when transferring files over ssh. When set to smart, Ansible will try them until one succeeds or they all fail. If set to True, it will force ‘scp’, if False it will use ‘sftp’.
default_scp_if_ssh                       smart                          Some filesystems do not support safe operations and/or return inconsistent errors, this setting makes Ansible ‘tolerate’ those in the list w/o causing fatal errors. Data corruption may occur and writes are not always verified when a filesystem is in the list.
default_selinux_special_fs               fuse,                          nfs, vboxsf, ramfs, 9p Ansible can optimise actions that call modules that support list parameters when using with_ looping. Instead of calling the module once for each item, the module is called once with the full list. The default value for this setting is only for certain package managers, but it can be used for any module. Currently, this is only supported for modules that have a name or pkg parameter, and only when the item is the only thing being passed to the parameter.
default_sftp_batch_mode                  True                           unused?
default_squash_actions                   apk,                           apt, dnf, homebrew, openbsd_pkg, pacman, pip, pkgng, yum, zypper Set the main callback used to display Ansible output, you can only have one at a time. You can have many other callbacks, but just one can be in charge of stdout.
default_ssh_transfer_method              None                           Set the default strategy used for plays.
default_stdout_callback                  default                        Colon separated paths in which Ansible will search for Strategy Plugins.
default_strategy                         linear                         Toggle the use of “su” for tasks.
default_strategy_plugin_path             ~/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy specify an “su” executable, otherwise it relies on PATH.
default_su                               False                          Flags to pass to su
default_su_exe                           su                             User you become when using “su”, leaving it blank will use the default configured on the target (normally root)
default_su_flags                         Description:                   facility to use when Ansible logs to the remote target
default_su_user                          None                           The include tasks can be static or dynamic, this toggles the default expected behaviour if autodetection fails and it is not explicitly set in task.
default_syslog_facility                  LOG_USER                       Colon separated paths in which Ansible will search for Terminal Plugins.
default_task_includes_static             False                          Colon separated paths in which Ansible will search for Jinja2 Test Plugins.
default_terminal_plugin_path             ~/.ansible/plugins/terminal:/usr/share/ansible/plugins/terminal This is the default timeout for connection plugins to use.
default_test_plugin_path                 ~/.ansible/plugins/test:/usr/share/ansible/plugins/test Default connection plugin to use, the ‘smart’ option will toggle between ‘ssh’ and ‘paramiko’ depending on controller OS and ssh versions
default_timeout                          10                             When True, this causes ansible templating to fail steps that reference variable names that are likely typoed. Otherwise, any ‘{{ template_expression }}’ that contains undefined variables will be rendered in a template or ansible action line exactly as written.
default_transport                        smart                          Colon separated paths in which Ansible will search for Vars Plugins.
default_undefined_var_behavior           True                           The vault_id to use for encrypting by default. If multiple vault_ids are provided, this specifies which to use for encryption. The –encrypt-vault-id cli option overrides the configured value.
default_vars_plugin_path                 ~/.ansible/plugins/vars:/usr/share/ansible/plugins/vars If true, decrypting vaults with a vault id will only try the password from the matching vault-id
default_vault_encrypt_identity           None                           The label to use for the default vault id label in cases where a vault id label is not provided
default_vault_id_match                   False                          A list of vault-ids to use by default. Equivalent to multiple –vault-id args. Vault-ids are tried in order.
default_vault_identity                   default                        The vault password file to use. Equivalent to –vault-password-file or –vault-id
default_vault_identity_list              []                             Sets the default verbosity, equivalent to the number of -v passed in the command line.
default_vault_password_file              None                           Toggle to control the showing of deprecation warnings
default_verbosity                        0                              Configuration toggle to tell modules to show differences when in ‘changed’ status, equivalent to --diff.
deprecation_warnings                     True                           How many lines of context to show when displaying the differences between files.
diff_always                              False                          Normally ansible-playbook will print a header for each task that is run. These headers will contain the name: field from the task if you specified one. If you didn’t then ansible-playbook uses the task’s action to help you tell which task is presently running. Sometimes you run many of the same action and so you want more information about the task to differentiate it from others of the same action. If you set this variable to True in the config then ansible-playbook will also include the task’s arguments in the header. This setting defaults to False because there is a chance that you have sensitive values in your parameters and you do not want those to be printed. If you set this to True you should be sure that you have secured your environment’s stdout (no one can shoulder surf your screen and you aren’t saving stdout to an insecure file) or made sure that all of your playbooks explicitly added the no_log: True parameter to tasks which have sensitive values See How do I keep secret data in my playbook? for more information.
diff_context                             3                              Toggle to control displaying skipped task/host entries in a task in the default callback
display_args_to_stdout                   False                          Colon separated paths in which Ansible will search for Documentation Fragments Plugins.
display_skipped_hosts                    True                           Root docsite URL used to generate docs URLs in warning/error text; must be an absolute URL with valid scheme and trailing slash.
doc_fragment_plugin_path                 ~/.ansible/plugins/doc_fragments:/usr/share/ansible/plugins/doc_fragments Whether or not to enable the task debugger, this previously was done as a strategy plugin. Now all strategy plugins can inherit this behavior. The debugger defaults to activating when a task is failed on unreachable. Use the debugger keyword for more flexibility.
docsite_root_url                         https://docs.ansible.com/ansible/ Toggle to allow missing handlers to become a warning instead of an error when notifying.
enable_task_debugger                     False                          Which modules to run during a play’s fact gathering stage, using the default of ‘smart’ will try to figure it out based on connection type.
error_on_missing_handler                 True                           If set to yes, ansible-galaxy will not validate TLS certificates. This can be useful for testing against a server with a self-signed certificate.
facts_modules                            [‘smart’]                  Role skeleton directory to use as a template for the init action in ansible-galaxy, same as --role-skeleton.
galaxy_ignore_certs                      False                          patterns of files to ignore inside a galaxy role skeleton directory
galaxy_role_skeleton                     None                           URL to prepend when roles don’t specify the full URI, assume they are referencing this server as the source.
galaxy_role_skeleton_ignore              [‘^.git$’,                 ‘^.*/.git_keep$’] GitHub personal access token
galaxy_server                            https://galaxy.ansible.com     Set this to “False” if you want to avoid host key checking by the underlying tools Ansible uses to connect to the host
galaxy_token                             None                           This setting changes the behaviour of mismatched host patterns, it allows you to force a fatal error, a warning or just ignore it
host_key_checking                        True                           Facts are available inside the ansible_facts variable, this setting also pushes them as their own vars in the main namespace. Unlike inside the ansible_facts dictionary, these will have an ansible_ prefix.
host_pattern_mismatch                    warning                        Path to the Python interpreter to be used for module execution on remote targets, or an automatic discovery mode. Supported discovery modes are auto, auto_silent, and auto_legacy (the default). All discovery modes employ a lookup table to use the included system Python (on distributions known to include one), falling back to a fixed ordered list of well-known Python interpreter locations if a platform-specific default is not available. The fallback behavior will issue a warning that the interpreter should be set explicitly (since interpreters installed later may change which one is used). This warning behavior can be disabled by setting auto_silent. The default value of auto_legacy provides all the same behavior, but for backwards-compatibility with older Ansible releases that always defaulted to /usr/bin/python, will use that interpreter if present (and issue a warning that the default behavior will change to that of auto in a future Ansible release.
inject_facts_as_vars                     True                           If ‘false’, invalid attributes for a task will result in warnings instead of errors
interpreter_python                       auto_legacy                    If ‘true’, it is a fatal error when any given inventory source cannot be successfully parsed by any available inventory plugin; otherwise, this situation only attracts a warning.
interpreter_python_distro_map            {‘centos’:                 {‘8’: ‘/usr/libexec/platform-python’, ‘6’: ‘/usr/bin/python’}, ‘rhel’: {‘8’: ‘/usr/libexec/platform-python’, ‘6’: ‘/usr/bin/python’}, ‘fedora’: {‘23’: ‘/usr/bin/python3’}, ‘redhat’: {‘8’: ‘/usr/libexec/platform-python’, ‘6’: ‘/usr/bin/python’}, ‘ubuntu’: {‘14’: ‘/usr/bin/python’, ‘16’: ‘/usr/bin/python3’}} Toggle to turn on inventory caching
interpreter_python_fallback              [‘/usr/bin/python’,        ‘python3.7’, ‘python3.6’, ‘python3.5’, ‘python2.7’, ‘python2.6’, ‘/usr/libexec/platform-python’, ‘/usr/bin/python3’, ‘python’] The plugin for caching inventory. If INVENTORY_CACHE_PLUGIN is not provided CACHE_PLUGIN can be used instead.
invalid_task_attribute_failed            True                           The inventory cache connection. If INVENTORY_CACHE_PLUGIN_CONNECTION is not provided CACHE_PLUGIN_CONNECTION can be used instead.
inventory_any_unparsed_is_failed         False                          The table prefix for the cache plugin. If INVENTORY_CACHE_PLUGIN_PREFIX is not provided CACHE_PLUGIN_PREFIX can be used instead.
inventory_cache_enabled                  False                          Expiration timeout for the inventory cache plugin data. If INVENTORY_CACHE_TIMEOUT is not provided CACHE_TIMEOUT can be used instead.
inventory_cache_plugin                   Description:                   of enabled inventory plugins, it also determines the order in which they are used.
inventory_cache_plugin_connection        Description:                   if ansible-inventory will accurately reflect Ansible’s view into inventory or its optimized for exporting.
inventory_cache_plugin_prefix            ansible_facts                  List of extensions to ignore when using a directory as an inventory source
inventory_cache_timeout                  3600                           List of patterns to ignore when using a directory as an inventory source
inventory_enabled                        [‘host_list’,              ‘script’, ‘auto’, ‘yaml’, ‘ini’, ‘toml’] If ‘true’ it is a fatal error if every single potential inventory source fails to parse, otherwise this situation will only attract a warning.
inventory_export                         False                          By default Ansible will issue a warning when there are no hosts in the inventory. These warnings can be silenced by adjusting this setting to False.
inventory_ignore_exts                    {{(BLACKLIST_EXTS              + ( ‘.orig’, ‘.ini’, ‘.cfg’, ‘.retry’))}} Maximum size of files to be considered for diff display
inventory_ignore_patterns                []                             This variable is used to enable bastion/jump host with netconf connection. If set to True the bastion/jump host ssh settings should be present in ~/.ssh/config file, alternatively it can be set to custom ssh configuration file path to read the bastion/jump host settings.
inventory_unparsed_is_failed             False                          Previouslly Ansible would only clear some of the plugin loading caches when loading new roles, this led to some behaviours in which a plugin loaded in prevoius plays would be unexpectedly ‘sticky’. This setting allows to return to that behaviour.
localhost_warning                        True                           This controls the amount of time to wait for response from remote device before timing out presistent connection.
max_file_size_for_diff                   104448                         This controls the retry timeout for presistent connection to connect to the local domain socket.
netconf_ssh_config                       None                           This controls how long the persistent connection will remain idle before it is destroyed.
network_group_modules                    [‘eos’,                    ‘nxos’, ‘ios’, ‘iosxr’, ‘junos’, ‘enos’, ‘ce’, ‘vyos’, ‘sros’, ‘dellos9’, ‘dellos10’, ‘dellos6’, ‘asa’, ‘aruba’, ‘aireos’, ‘bigip’, ‘ironware’, ‘onyx’, ‘netconf’] Path to socket to be used by the connection persistence system.
old_plugin_cache_clearing                False                          This sets which playbook dirs will be used as a root to process vars plugins, which includes finding host_vars/group_vars The top option follows the traditional behaviour of using the top playbook in the chain to find the root directory. The bottom option follows the 2.4.0 behaviour of using the current playbook to find the root directory. The all option examines from the first parent to the current playbook.
paramiko_host_key_auto_add               False                          A path to configuration for filtering which plugins installed on the system are allowed to be used. See Plugin Filter Configuration for details of the filter file’s format. The default is /etc/ansible/plugin_filters.yml
paramiko_look_for_keys                   True                           Attempts to set RLIMIT_NOFILE soft limit to the specified value when executing Python modules (can speed up subprocess usage on Python 2.x. See https://bugs.python.org/issue11284). The value will be limited by the existing hard limit. Default value of 0 does not attempt to adjust existing system-defined limits.
persistent_command_timeout               30                             This controls whether a failed Ansible playbook should create a .retry file.
persistent_connect_retry_timeout         15                             This sets the path in which Ansible will save .retry files when a playbook fails and retry files are enabled.
persistent_connect_timeout               30                             This adds the custom stats set via the set_stats plugin to the default output
persistent_control_path_dir              ~/.ansible/pc                  Action to take when a module parameter value is converted to a string (this does not affect variables). For string parameters, values such as ‘1.00’, “[‘a’, ‘b’,]”, and ‘yes’, ‘y’, etc. will be converted by the YAML parser unless fully quoted. Valid options are ‘error’, ‘warn’, and ‘ignore’. Since 2.8, this option defaults to ‘warn’ but will change to ‘error’ in 2.12.
playbook_vars_root                       top                            This list of filters avoids ‘type conversion’ when templating variables Useful when you want to avoid conversion into lists or dictionaries for JSON strings, for example.
plugin_filters_cfg                       None                           Allows disabling of warnings related to potential issues on the system running ansible itself (not on the managed hosts) These may include warnings about 3rd party packages or other conditions that should be resolved if possible.
python_module_rlimit_nofile              0                              default list of tags to run in your plays, Skip Tags has precedence.
retry_files_enabled                      False                          default list of tags to skip in your plays, has precedence over Run Tags
retry_files_save_path                    None                           This option defines whether the task debugger will be invoked on a failed task when ignore_errors=True is specified. True specifies that the debugger will honor ignore_errors, False will not honor ignore_errors.
show_custom_stats                        False                          Make ansible transform invalid characters in group names supplied by inventory sources. If ‘never’ it will allow for the group name but warn about the issue. When ‘always’ it will replace any invalid charachters with ‘_’ (underscore) and warn the user When ‘silently’, it does the same as ‘always’ sans the warnings.
string_conversion_action                 warn                           Toggles the use of persistence for connections.
string_type_filters [‘string’, ‘to_json’, ‘to_nice_json’, ‘to_yaml’, ‘ppretty’, ‘json’] Allows to change the group variable precedence merge order.
system_warnings True Force ‘verbose’ option to use stderr instead of stdout
tags_run [] Check all of these extensions when looking for ‘variable’ files which should be YAML or JSON or vaulted versions of these. This affects vars_files, include_vars, inventory and vars plugins among others.
tags_skip []

task_debugger_ignore_errors               boolean
transform_invalid_group_chars             string
use_persistent_connections                boolean
variable_precedence                       list
verbose_to_stderr                         bool
yaml_filename_extensions                  list
ansible_config                            the default ansible config file
ansible_connection_path                   where to look for the ansible-connection script. This location will be checked before searching $PATH.If null, ansible will start with the same directory as the ansible script.
ansible_gather_subset                     the gather_subset option for the M(setup) task in the implicit fact gathering. See the module documentation for specifics.It does not apply to user defined M(setup) tasks.
ansible_inventory_cache_timeout           timeout for the inventory cache plugin data. If INVENTORY_CACHE_TIMEOUT is not provided CACHE_TIMEOUT can be used instead.
display_skipped_hosts                     to control displaying skipped task/host entries in a task in the default callback
ansible_display_skipped_hosts             to control displaying skipped task/host entries in a task in the default callback
ansible_persistent_connect_retry_timeout  controls the retry timeout for presistent connection to connect to the local domain socket.
ansible_diff_context                      many lines of context to show when displaying the differences between files.
ansible_cow_path                          a custom cowsay path or swap in your cowsay implementation of choice
ansible_test_plugins                      separated paths in which Ansible will search for Jinja2 Test Plugins.
ansible_inventory_enabled                 of enabled inventory plugins, it also determines the order in which they are used.
ansible_galaxy_role_skeleton_ignore       of files to ignore inside a galaxy role skeleton directory
ansible_pipelining                        if supported by the connection plugin, reduces the number of network operations required to execute a module on the remote server, by executing many Ansible modules without actual file transfer.This can result in a very significant performance improvement when enabled.However this conflicts with privilege escalation (become). For example, when using ‘sudo:’ operations you must first disable ‘requiretty’ in /etc/sudoers on all managed hosts, which is why it is disabled by default.This options is disabled if ANSIBLE_KEEP_REMOTE_FILES is enabled.
ansible_ssh_pipelining                    if supported by the connection plugin, reduces the number of network operations required to execute a module on the remote server, by executing many Ansible modules without actual file transfer.This can result in a very significant performance improvement when enabled.However this conflicts with privilege escalation (become). For example, when using ‘sudo:’ operations you must first disable ‘requiretty’ in /etc/sudoers on all managed hosts, which is why it is disabled by default.This options is disabled if ANSIBLE_KEEP_REMOTE_FILES is enabled.
ansible_become_method                     escalation method to use when become is enabled.
ansible_host_key_checking                 this to “False” if you want to avoid host key checking by the underlying tools Ansible uses to connect to the host
ansible_ask_su_pass                       controls whether an Ansible playbook should prompt for a su password.
ansible_su_user                           you become when using “su”, leaving it blank will use the default configured on the target (normally root)
ansible_callable_whitelist                of callable methods to be made available to template evaluation
ansible_color_verbose                     the color to use when emitting verbose messages. i.e those that show with ‘-v’s.
ansible_gathering                         setting controls the default policy of fact gathering (facts discovered about remote systems).When ‘implicit’ (the default), the cache plugin will be ignored and facts will be gathered per play unless ‘gather_facts: False’ is set.When ‘explicit’ the inverse is true, facts will not be gathered unless directly requested in the play.The ‘smart’ value means each new host that has no facts discovered will be scanned, but if the same host is addressed in multiple plays it will not be contacted again in the playbook run.This option can be useful for those wishing to save fact gathering time. Both ‘smart’ and ‘explicit’ will use the cache plugin.
ansible_connection_facts_modules          modules to run during a play’s fact gathering stage based on connection
ansible_timeout                           is the default timeout for connection plugins to use.
ansible_scp_if_ssh                        method to use when transferring files over ssh.When set to smart, Ansible will try them until one succeeds or they all fail.If set to True, it will force ‘scp’, if False it will use ‘sftp’.
ansible_nocows                            you have cowsay installed but want to avoid the ‘cows’ (why????), use this.
ansible_host_pattern_mismatch             setting changes the behaviour of mismatched host patterns, it allows you to force a fatal error, a warning or just ignore it
ansible_inventory_ignore_regex            of patterns to ignore when using a directory as an inventory source
ansible_no_log                            Ansible’s display and logging of task details, mainly used to avoid security disclosures.
ansible_max_diff_size                     size of files to be considered for diff display
ansible_handler_includes_static           2.0 M(include) can be ‘dynamic’, this setting (if True) forces that if the include appears in a handlers section to be ‘static’.
ansible_keep_remote_files                 the cleaning up of the temporary files Ansible used to execute the tasks on the remote.If this option is enabled it will disable ANSIBLE_PIPELINING.
ansible_python_interpreter                to the Python interpreter to be used for module execution on remote targets, or an automatic discovery mode. Supported discovery modes are auto, auto_silent, and auto_legacy (the default). All discovery modes employ a lookup table to use the included system Python (on distributions known to include one), falling back to a fixed ordered list of well-known Python interpreter locations if a platform-specific default is not available. The fallback behavior will issue a warning that the interpreter should be set explicitly (since interpreters installed later may change which one is used). This warning behavior can be disabled by setting auto_silent. The default value of auto_legacy provides all the same behavior, but for backwards-compatibility with older Ansible releases that always defaulted to /usr/bin/python, will use that interpreter if present (and issue a warning that the default behavior will change to that of auto in a future Ansible release.
ansible_poll_interval                     asynchronous tasks in Ansible (covered in Asynchronous Actions and Polling), this is how often to check back on the status of those tasks when an explicit poll interval is not supplied. The default is a reasonably moderate 15 seconds which is a tradeoff between checking in frequently and providing a quick turnaround when something may have completed.
ansible_cliconf_plugins                   separated paths in which Ansible will search for Cliconf Plugins.
ansible_become_allow_same_user            setting controls if become is skipped when remote user and become user are the same. I.E root sudo to root.
ansible_ssh_args                          set, this will override the Ansible default ssh arguments.In particular, users may wish to raise the ControlPersist time to encourage performance. A value of 30 minutes may be appropriate.Be aware that if -o ControlPath is set in ssh_args, the control path setting is not used.
ansible_action_plugins                    separated paths in which Ansible will search for Action Plugins.
ansible_remote_user                       the login user for the target machinesWhen blank it uses the connection plugin’s default, normally the user currently executing Ansible.
ansible_inventory_cache                   to turn on inventory caching
ansible_inventory_plugins                 separated paths in which Ansible will search for Inventory Plugins.
ansible_vault_password_file               vault password file to use. Equivalent to –vault-password-file or –vault-id
ansible_cache_plugins                     separated paths in which Ansible will search for Cache Plugins.
ansible_inventory_cache_plugin            plugin for caching inventory. If INVENTORY_CACHE_PLUGIN is not provided CACHE_PLUGIN can be used instead.
ansible_callback_plugins                  separated paths in which Ansible will search for Callback Plugins.
ansible_terminal_plugins                  separated paths in which Ansible will search for Terminal Plugins.
ansible_connection_plugins                separated paths in which Ansible will search for Connection Plugins.
ansible_jinja2_extensions                 is a developer-specific feature that allows enabling additional Jinja2 extensions.See the Jinja2 documentation for details. If you do not know what these do, you probably don’t need to change this setting :)
ansible_command_warnings                  default Ansible will issue a warning when the shell or command module is used and the command appears to be similar to an existing Ansible module.These warnings can be silenced by adjusting this setting to False. You can also control this at the task level with the module option warn.
ansible_color_ok                          the color to use when showing ‘OK’ task status
ansible_inject_fact_vars                  are available inside the ansible_facts variable, this setting also pushes them as their own vars in the main namespace.Unlike inside the ansible_facts dictionary, these will have an ansible_ prefix.
ansible_color_changed                     the color to use on ‘Changed’ task status
ansible_display_args_to_stdout            ansible-playbook will print a header for each task that is run. These headers will contain the name: field from the task if you specified one. If you didn’t then ansible-playbook uses the task’s action to help you tell which task is presently running. Sometimes you run many of the same action and so you want more information about the task to differentiate it from others of the same action. If you set this variable to True in the config then ansible-playbook will also include the task’s arguments in the header.This setting defaults to False because there is a chance that you have sensitive values in your parameters and you do not want those to be printed.If you set this to True you should be sure that you have secured your environment’s stdout (no one can shoulder surf your screen and you aren’t saving stdout to an insecure file) or made sure that all of your playbooks explicitly added the no_log: True parameter to tasks which have sensitive values See How do I keep secret data in my playbook? for more information.
ansible_collections_paths                 also COLLECTIONS_PATHS
ansible_local_temp                        directory for Ansible to use on the controller.
ansible_color_error                       the color to use when emitting error messages
ansible_vault_id_match                    true, decrypting vaults with a vault id will only try the password from the matching vault-id
ansible_error_on_missing_handler          to allow missing handlers to become a warning instead of an error when notifying.
ansible_string_conversion_action          to take when a module parameter value is converted to a string (this does not affect variables). For string parameters, values such as ‘1.00’, “[‘a’, ‘b’,]”, and ‘yes’, ‘y’, etc. will be converted by the YAML parser unless fully quoted.Valid options are ‘error’, ‘warn’, and ‘ignore’.Since 2.8, this option defaults to ‘warn’ but will change to ‘error’ in 2.12.
ansible_cache_plugin                      which cache plugin to use, the default ‘memory’ is ephimeral.
ansible_become                            the use of privilege escalation, allowing you to ‘become’ another user after login.
ansible_verbosity                         the default verbosity, equivalent to the number of -v passed in the command line.
ansible_facts_modules                     modules to run during a play’s fact gathering stage, using the default of ‘smart’ will try to figure it out based on connection type.
ansible_squash_actions                    can optimise actions that call modules that support list parameters when using with_ looping. Instead of calling the module once for each item, the module is called once with the full list.The default value for this setting is only for certain package managers, but it can be used for any module.Currently, this is only supported for modules that have a name or pkg parameter, and only when the item is the only thing being passed to the parameter.
ansible_vars_plugins                      separated paths in which Ansible will search for Vars Plugins.
ansible_filter_plugins                    separated paths in which Ansible will search for Jinja2 Filter Plugins.
ansible_galaxy_role_skeleton              skeleton directory to use as a template for the init action in ansible-galaxy, same as --role-skeleton.
ansible_persistent_connect_timeout        controls how long the persistent connection will remain idle before it is destroyed.
ansible_become_ask_pass                   to prompt for privilege escalation password.
ansible_invalid_task_attribute_failed     ‘false’, invalid attributes for a task will result in warnings instead of errors
ansible_persistent_command_timeout        controls the amount of time to wait for response from remote device before timing out presistent connection.
ansible_inventory                         separated list of Ansible inventory sources
ansible_gather_timeout                    the timeout in seconds for the implicit fact gathering.It does not apply to user defined M(setup) tasks.
ansible_library                           separated paths in which Ansible will search for Modules.
ansible_module_args                       sets the default arguments to pass to the ansible adhoc binary if no -a is specified.
ansible_localhost_warning                 default Ansible will issue a warning when there are no hosts in the inventory.These warnings can be silenced by adjusting this setting to False.
ansible_vault_identity_list               list of vault-ids to use by default. Equivalent to multiple –vault-id args. Vault-ids are tried in order.
ansible_color_diff_add                    the color to use when showing added lines in diffs
ansible_color_console_prompt              the default color to use for ansible-console
ansible_cow_whitelist                     list of cowsay templates that are ‘safe’ to use, set to empty list if you want to enable all installed templates.
ansible_sftp_batch_mode                   also DEFAULT_SFTP_BATCH_MODE
ansible_force_color                       options forces color mode even when running without a TTY or the “nocolor” setting is True.
ansible_inventory_export                  if ansible-inventory will accurately reflect Ansible’s view into inventory or its optimized for exporting.
ansible_transport                         connection plugin to use, the ‘smart’ option will toggle between ‘ssh’ and ‘paramiko’ depending on controller OS and ssh versions
ansible_verbose_to_stderr                 ‘verbose’ option to use stderr instead of stdout
ansible_color_diff_remove                 the color to use when showing removed lines in diffs
ansible_galaxy_server                     to prepend when roles don’t specify the full URI, assume they are referencing this server as the source.
ansible_doc_fragment_plugins              separated paths in which Ansible will search for Documentation Fragments Plugins.
ansible_force_handlers                    option controls if notified handlers run on a host even if a failure occurs on that host.When false, the handlers will not run if a failure has occurred on a host.This can also be set per play or on the command line. See Handlers and Failure for more details.
ansible_debug                             debug output in Ansible. This is very verbose and can hinder multiprocessing. Debug output can also include secret information despite no_log settings being enabled, which means debug mode should not be used in production.
ansible_stdout_callback                   the main callback used to display Ansible output, you can only have one at a time.You can have many other callbacks, but just one can be in charge of stdout.
ansible_color_diff_lines                  the color to use when showing diffs
ansible_transform_invalid_group_chars     ansible transform invalid characters in group names supplied by inventory sources.If ‘never’ it will allow for the group name but warn about the issue.When ‘always’ it will replace any invalid charachters with ‘_’ (underscore) and warn the userWhen ‘silently’, it does the same as ‘always’ sans the warnings.
ansible_task_includes_static              include tasks can be static or dynamic, this toggles the default expected behaviour if autodetection fails and it is not explicitly set in task.
ansible_become_flags                      to pass to the privilege escalation executable.
ansible_su_flags                          to pass to su
ansible_httpapi_plugins                   separated paths in which Ansible will search for HttpApi Plugins.
ansible_color_warn                        the color to use when emitting warning messages
ansible_color_unreachable                 the color to use on ‘Unreachable’ status
ansible_ask_sudo_pass                     controls whether an Ansible playbook should prompt for a sudo password.
ansible_module_lang                       locale setting to use for modules when they execute on the target.If empty it tries to set itself to the LANG environment variable on the controller.This is only used if DEFAULT_MODULE_SET_LOCALE is set to true
libvirt_lxc_noseclabel                    setting causes libvirt to connect to lxc containers by passing –noseclabel to virsh. This is necessary when running on systems which do not have SELinux.
ansible_libvirt_lxc_noseclabel            setting causes libvirt to connect to lxc containers by passing –noseclabel to virsh. This is necessary when running on systems which do not have SELinux.
ansible_null_representation               templating should return as a ‘null’ value. When not set it will let Jinja2 decide.
ansible_fact_path                         option allows you to globally configure a custom path for ‘local_facts’ for the implied M(setup) task when using fact gathering.If not set, it will fallback to the default from the M(setup) module: /etc/ansible/facts.d.This does not affect user defined tasks that use the M(setup) module.
ansible_inventory_any_unparsed_is_failed  ‘true’, it is a fatal error when any given inventory source cannot be successfully parsed by any available inventory plugin; otherwise, this situation only attracts a warning.
ansible_private_role_vars                 role variables inaccessible from other roles.This was introduced as a way to reset role variables to default values if a role is used more than once in a playbook.
ansible_enable_task_debugger              or not to enable the task debugger, this previously was done as a strategy plugin.Now all strategy plugins can inherit this behavior. The debugger defaults to activating whena task is failed on unreachable. Use the debugger keyword for more flexibility.
ansible_color_debug                       the color to use when emitting debug messages
ansible_load_callback_plugins             whether callback plugins are loaded when running /usr/bin/ansible. This may be used to log activity from the command line, send notifications, and so on. Callback plugins are always loaded for ansible-playbook.
ansible_syslog_facility                   facility to use when Ansible logs to the remote target
ansible_paramiko_host_key_auto_add        also PARAMIKO_HOST_KEY_AUTO_ADD
ansible_use_persistent_connections        the use of persistence for connections.
ansible_task_debugger_ignore_errors       option defines whether the task debugger will be invoked on a failed task when ignore_errors=True is specified.True specifies that the debugger will honor ignore_errors, False will not honor ignore_errors.
ansible_vault_identity                    label to use for the default vault id label in cases where a vault id label is not provided
ansible_yaml_filename_ext                 all of these extensions when looking for ‘variable’ files which should be YAML or JSON or vaulted versions of these.This affects vars_files, include_vars, inventory and vars plugins among others.
ansible_color_skip                        the color to use when showing ‘Skipped’ task status
ansible_string_type_filters               list of filters avoids ‘type conversion’ when templating variablesUseful when you want to avoid conversion into lists or dictionaries for JSON strings, for example.
ansible_remote_port                       to use in remote connections, when blank it will use the connection plugin default.
ansible_playbook_vars_root                sets which playbook dirs will be used as a root to process vars plugins, which includes finding host_vars/group_varsThe top option follows the traditional behaviour of using the top playbook in the chain to find the root directory.The bottom option follows the 2.4.0 behaviour of using the current playbook to find the root directory.The all option examines from the first parent to the current playbook.
ansible_ask_vault_pass                    controls whether an Ansible playbook should prompt for a vault password.
ansible_precedence                        to change the group variable precedence merge order.
ansible_python_module_rlimit_nofile       to set RLIMIT_NOFILE soft limit to the specified value when executing Python modules (can speed up subprocess usage on Python 2.x. See https://bugs.python.org/issue11284). The value will be limited by the existing hard limit. Default value of 0 does not attempt to adjust existing system-defined limits.
ansible_hash_behaviour                    setting controls how variables merge in Ansible. By default Ansible will override variables in specific precedence orders, as described in Variables. When a variable of higher precedence wins, it will replace the other value.Some users prefer that variables that are hashes (aka ‘dictionaries’ in Python terms) are merged. This setting is called ‘merge’. This is not the default behavior and it does not affect variables whose values are scalars (integers, strings) or arrays. We generally recommend not using this setting unless you think you have an absolute need for it, and playbooks in the official examples repos do not use this settingIn version 2.0 a combine filter was added to allow doing this for a particular variable (described in Filters).
ansible_become_user                       user your login/remote user ‘becomes’ when using privilege escalation, most systems will use ‘root’ when no user is specified.
ansible_error_on_undefined_vars           True, this causes ansible templating to fail steps that reference variable names that are likely typoed.Otherwise, any ‘{{ template_expression }}’ that contains undefined variables will be rendered in a template or ansible action line exactly as written.
ansible_cache_plugin_timeout              timeout for the cache plugin data
ansible_ssh_control_path                  is the location to save ssh’s ControlPath sockets, it uses ssh’s variable substitution.Since 2.3, if null, ansible will generate a unique hash. Use %(directory)s to indicate where to use the control dir path setting.Before 2.3 it defaulted to control_path=%(directory)s/ansible-ssh-%%h-%%p-%%r.Be aware that this setting is ignored if -o ControlPath is set in ssh args.
ansible_cache_plugin_prefix               to use for cache plugin files/tables
network_group_modules                     also NETWORK_GROUP_MODULES
ansible_network_group_modules             also NETWORK_GROUP_MODULES
ansible_log_path                          to which Ansible will log on the controller. When empty logging is disabled.
ansible_run_tags                          list of tags to run in your plays, Skip Tags has precedence.
ansible_skip_tags                         list of tags to skip in your plays, has precedence over Run Tags
ansible_strategy                          the default strategy used for plays.
ansible_diff_always                       toggle to tell modules to show differences when in ‘changed’ status, equivalent to --diff.
ansible_no_target_syslog                  Ansible logging to syslog on the target when it executes tasks.
ansible_module_set_locale                 if we set locale for modules when executing on the target.
ansible_lookup_plugins                    separated paths in which Ansible will search for Lookup Plugins.
ansible_ask_pass                          controls whether an Ansible playbook should prompt for a login password. If using SSH keys for authentication, you probably do not needed to change this setting.
ansible_inventory_unparsed_failed         ‘true’ it is a fatal error if every single potential inventory source fails to parse, otherwise this situation will only attract a warning.
ansible_callback_whitelist                of whitelisted callbacks, not all callbacks need whitelisting, but many of those shipped with Ansible do as we don’t want them activated by default.
ansible_private_key_file                  for connections using a certificate or key file to authenticate, rather than an agent or passwords, you can set the default value here to avoid re-specifying –private-key with every invocation.
ansible_inventory_cache_plugin_prefix     table prefix for the cache plugin. If INVENTORY_CACHE_PLUGIN_PREFIX is not provided CACHE_PLUGIN_PREFIX can be used instead.
ansible_persistent_control_path_dir       to socket to be used by the connection persistence system.
ansible_module_utils                      separated paths in which Ansible will search for Module utils files, which are shared by modules.
ansible_roles_path                        separated paths in which Ansible will search for Roles.
ansible_cache_plugin_connection           connection or path information for the cache plugin
ansible_become_exe                        to use for privilege escalation, otherwise Ansible will depend on PATH
ansible_ssh_retries                       of attempts to establish a connection before we give up and report the host as ‘UNREACHABLE’
ansible_color_deprecate                   the color to use when emitting deprecation messages
ansible_netconf_plugins                   separated paths in which Ansible will search for Netconf Plugins.
ansible_inventory_cache_connection        inventory cache connection. If INVENTORY_CACHE_PLUGIN_CONNECTION is not provided CACHE_PLUGIN_CONNECTION can be used instead.
ansible_executable                        indicates the command to use to spawn a shell under for Ansible’s execution needs on a target. Users may need to change this in rare instances when shell usage is constrained, but in most cases it may be left as is.
ansible_deprecation_warnings              to control the showing of deprecation warnings
ansible_nocolor                           setting allows suppressing colorizing output, which is used to give a better indication of failure and status information.
ansible_paramiko_look_for_keys            also PARAMIKO_LOOK_FOR_KEYS
ansible_retry_files_enabled               controls whether a failed Ansible playbook should create a .retry file.
ansible_strategy_plugins                  separated paths in which Ansible will search for Strategy Plugins.
ansible_ssh_control_path_dir              sets the directory to use for ssh control path if the control path setting is null.Also, provides the %(directory)s variable for the control path setting.
ansible_inventory_ignore                  of extensions to ignore when using a directory as an inventory source
ansible_galaxy_ignore                     set to yes, ansible-galaxy will not validate TLS certificates. This can be useful for testing against a server with a self-signed certificate.
ansible_retry_files_save_path             sets the path in which Ansible will save .retry files when a playbook fails and retry files are enabled.
ansible_show_custom_stats                 adds the custom stats set via the set_stats plugin to the default output
ansible_vault_encrypt_identity            vault_id to use for encrypting by default. If multiple vault_ids are provided, this specifies which to use for encryption. The –encrypt-vault-id cli option overrides the configured value.
ansible_cow_selection                     allows you to chose a specific cowsay stencil for the banners or use ‘random’ to cycle through them.
ansible_galaxy_token                      personal access token
ansible_forks                             number of forks Ansible will use to execute tasks on target hosts.
ansible_su                                the use of “su” for tasks.
ansible_become_plugins                    separated paths in which Ansible will search for Become Plugins.
ansible_color_highlight                   the color to use for highlighting
ansible_netconf_ssh_config                variable is used to enable bastion/jump host with netconf connection. If set to True the bastion/jump host ssh settings should be present in ~/.ssh/config file, alternatively it can be set to custom ssh configuration file path to read the bastion/jump host settings.
ansible_jinja2_native                     option preserves variable types during template operations. This requires Jinja2 >= 2.10.
ansible_agnostic_become_prompt            an agnostic become prompt instead of displaying a prompt containing the command line supplied become method
ansible_su_exe                            an “su” executable, otherwise it relies on PATH.
ansible_any_errors_fatal                  the default value for the any_errors_fatal keyword, if True, Task failures will be considered fatal errors.
ansible_system_warnings                   disabling of warnings related to potential issues on the system running ansible itself (not on the managed hosts)These may include warnings about 3rd party packages or other conditions that should be resolved if possible.
ansible_old_plugin_cache_clear            Ansible would only clear some of the plugin loading caches when loading new roles, this led to some behaviours in which a plugin loaded in prevoius plays would be unexpectedly ‘sticky’. This setting allows to return to that behaviour.
ansible_ssh_transfer_method
ansible_ssh_executable                    defines the location of the ssh binary. It defaults to ssh which will use the first ssh binary available in $PATH.This option is usually not required, it might be useful when access to system ssh is restricted, or when using ssh wrappers to connect to remote hosts.
ansible_action_warnings                   default Ansible will issue a warning when received from a task action (module or action plugin)These warnings can be silenced by adjusting this setting to False.
ansible_log_filter                        of logger names to filter out of the log file
ansible_conditional_bare_vars             this setting on (True), running conditional evaluation ‘var’ is treated differently than ‘var.subkey’ as the first is evaluated directly while the second goes through the Jinja2 parser. But ‘false’ strings in ‘var’ get evaluated as booleans.With this setting off they both evaluate the same but in cases in which ‘var’ was ‘false’ (a string) it won’t get evaluated as a boolean anymore.Currently this setting defaults to ‘True’ but will soon change to ‘False’ and the setting itself will be removed in the future.Expect the default to change in version 2.10 and that this setting eventually will be deprecated after 2.12

ansible_play_batch                        List of active hosts in the current play run limited by the serial, aka ‘batch’. Failed/Unreachable hosts are not considered ‘active’.
ansible_play_hosts                        The same as ansible_play_batch
ansible_play_hosts_all                     List of all the hosts that were targeted by the play


# facts
- gather_facts: no
  tasks:
    - setup: {}
      when: ansible_fqdn is not defined


# variables precedence priority order vars
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
# vault
yq r extra_vars/zabbix-credentials.yml zabbix.prod.login_password | ansible-vault decrypt  --vault-id prod@secrets/ansible-vault-prod --vault-id dev@secrets/ansible-vault-dev
echo -n "Bonjour123" | ansible-vault encrypt --encrypt-vault-id prod --vault-id prod@secrets/ansible-vault-prod --vault-id dev@secrets/ansible-vault-dev | sed -r -n -e '1 s/^/\n\nmypassword: vault |\n  / p' -e '2,$ s/^/  / p'
echo -n "Bonjour123" | ansible-vault encrypt --encrypt-vault-id stdprivate --vault-id stdprivate@/home/me/git/me/stdprivate/secrets/stdprivate.key

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
{{ 'passwordsaresecret' | string | password_hash('sha512') }}
{{ 'secretpassword' | string | password_hash('sha256', 'mysecretsalt') }}
{{ 'secretpassword' | string | password_hash('sha512', 65534 | random(seed=inventory_hostname) | string) }}
{{ 'secretpassword' | string | password_hash('sha256', 'mysecretsalt', rounds=10000) }}
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
| trim   # strip
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


name: "{{ item.split()[0] }}" # split first words

https://fossies.org/linux/ansible/lib/ansible/modules/monitoring/zabbix/zabbix_proxy.py

https://www.reddit.com/r/ansible/comments/9t0egv/ansible_python3_and_package_management_with/ yum centos7 ansible python3 python2


## vimf6_ansible_args: --step
## vimf6_ansible_args: --start-at-task startattask
## vimf6_ansible_args: --diff -e zabbix_env=uat -i inventory.yml --vault-id dev@secrets/ansible-vault-dev
## vimf6_ansible_args: --diff -e zabbix_env=none -i inventory.yml -t vimf6 --vault-id dev@secrets/ansible-vault-dev -v
## vimf6_ansible_args: --diff --check -vv
## vimf6_ansible_args: --diff -i ./.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
## vimf6_ansible_nolocalsudo: yes

https://docs.ansible.com/ansible/latest/scenario_guides/guide_azure.html


# data manipulation in python
- hosts: localhost
  connection: local
  gather_facts: no
  vars:
    salut:
      keya:
        - elema
        - elemb
        - elemc
      keyb:
        - elemd
        - eleme
        - elemf
  tasks:
    - copy:
        dest: /tmp/bip.py
        content:
          #```python
          import json
          import sys
          inH = json.load(sys.stdin)
          outH = []
          for k, v in inH.items():
            for elem in v:
              outH.append('{}-{}'.format(k, elem))
          print(json.dumps(outH))
          #```
    - shell: python3 /tmp/bip.py
      args:
        stdin: "{{ salut | to_json }}"
      register: out
    - set_fact:
        out_ansible: "{{out.stdout | from_json }}"
    - debug: var=out_ansible


when: - "Multiple conditions that all need to be true (a logical ‘and’) can also be specified as a list -> not or"

subject_alt_name: "{{ bH.cert_subject_alt_name | map('regex_replace', '(.*)', 'DNS:\\1') | join(',') | default('DNS:' + bH.cert_common_name, true)}}"

- debug: msg="{{ groups.keys() | list }}" # list all group in inventory

when: "'bip' in group_names"

```yml
- name: YQ JQ Change animals.birds.cardinals.feathers to "red".
  set_fact: # yq jq
    animals: "{{ animals|combine({'birds': {'cardinals': {'feathers': 'red'}}}, recursive=True) }}" # yq.jq
```
debug: msg="{{ lookup('dig', 'example.com.')}}" # dns name resolution
