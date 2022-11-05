https://docs.ansible.com/ansible/latest/user_guide/playbooks_debugger.html#examples-of-using-the-debugger-keyword

# keyword at playbook or task level
debugger: on_failed
always         Always invoke the debugger, regardless of the outcome
never          Never invoke the debugger, regardless of the outcome
on_failed      Only invoke the debugger if a task fails
on_unreachable Only invoke the debugger if a host is unreachable
on_skipped     Only invoke the debugger if the task is skipped

# ansible.cfg
[defaults]
enable_task_debugger = True

# environment variable
ANSIBLE_ENABLE_TASK_DEBUGGER=True ansible-playbook -i hosts site.yml

Enabling the debugger as a strategy
If you are running legacy playbooks or roles, you may see the debugger enabled as a strategy. You can do this at the play level, in ansible.cfg, or with the environment variable ANSIBLE_STRATEGY=debug. For example:

- hosts: test
  strategy: debug
  tasks:
  ...
Or in ansible.cfg:

[defaults]
strategy = debug

This backwards-compatible method, which matches Ansible versions before 2.5, may be removed in a future release.

# debug amend redo
p host
p result._result
p task.args
task.args['data'] = '{{ var1 }}'
task.args['name'] = 'bash'
task_vars['pkg_name'] = 'bash'
update_task
redo

Command                   Shortcut      Action
print                     p             Print information about the task
task.args[key] = value    no shortcut   Update module arguments
task_vars[key] = value    no shortcut   Update task variables (you must update_task next)
update_task               u             Recreate a task with updated task variables
redo                      r             Run the task again
continue                  c             Continue executing within the debugger, starting with the next task
quit                      q             Quit the debugger


p task       # print task name
p task.args  # print task arguments
p task_vars  # print all variables available. Don't do that at it will spike 100% CPU for quite a while
{u'ansible_all_ipv4_addresses': [u'192.0.2.10'],
 u'ansible_architecture': u'x86_64',
 ...
}
