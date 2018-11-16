* https://docs.ansible.com/ansible/latest/modules/template_module.html
* https://docs.ansible.com/ansible/latest/modules/include_vars_module.html
* https://docs.ansible.com/ansible/latest/modules/get_url_module.html
* https://docs.ansible.com/ansible/latest/modules/user_module.html
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
- name: myfoo
  debug:
	  #msg: "the echo was {{ foo.stdout }}"
	msg: "the echo was hihi {{ mr_hehe }}"
  tags:
- name: Show all possible accessible hasts
  debug:
    var: hostvars[inventory_hostname]
  tags:
    - mrdebug
  # from https://gryzli.info/2017/12/21/ansible-debug-print-variables/
```

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
