#!/usr/bin/env bash

ansible-playbook std*.yml --ask-sudo-pass --diff -l 127.0.0.1
