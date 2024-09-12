#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Dict, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

import bcrypt
import re

def detect_and_hash(password, hash_str):
    # Detect the hash algorithm (e.g., bcrypt starting with $2a$, $2b$, $2y$)
    match = re.match(r'^\$(2[abxy]?)\$(\d+)\$(.+)', hash_str)

    if match:
        algorithm = match.group(1)  # e.g., '2y'
        cost = int(match.group(2))  # e.g., 10 (cost factor)
        salt = match.group(3)[:22]  # first 22 chars (the salt)

        print(f"Algorithm: bcrypt ({algorithm})")
        print(f"Cost Factor: {cost}")
        print(f"Salt: {salt}")

        # Construct the full salt prefix for bcrypt
        full_salt = f"${algorithm}${cost}${salt}".encode()

        # Hash the password with the detected salt
        hashed = bcrypt.hashpw(password.encode(), full_salt)

        return hashed.decode()
    else:
        raise ValueError("Unsupported or unrecognized hash format.")

def star_password(i):
    len_i = len(i)
    if len_i < 6:  return '*' * len_i
    if len_i < 10: return i[:1] + '*' * (len_i - 2) + i[-1:]
    return                i[:2] + '*' * (len_i - 4) + i[-2:]

# Example usage
guess_password = "your_password"
known_hash_str = "$2y$10$abcdefghijklmnopqrstuvwx"

if 1:
    guess_password = 'incorrect password'
    guess_password = 'my password is rich'
    known_hash_str = '$2y$10$ODbODzErpQ1Hzn/GsxkAdO/EJ3lAOKl2HLHBZGnKDYL0.JvS4ic5m'

start_guess_password = star_password(guess_password)
hashed_guess_password = detect_and_hash(guess_password, known_hash_str)
if hashed_guess_password == known_hash_str:
    print(f"SUCCESS {start_guess_password} matches hash {known_hash_str}")
else:
    print(f"failure {start_guess_password} returns hash {hashed_guess_password} which differs from {known_hash_str}")
