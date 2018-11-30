#!/usr/bin/env bash

ansible-playbook *.yml --ask-become-pass --diff -l 127.0.0.1
