#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

import sys

import cryptography.x509
import cryptography.hazmat.backends
import cryptography.hazmat.primitives

DEFAULT_FINGERPRINT_HASH = cryptography.hazmat.primitives.hashes.SHA256


# https://stackoverflow.com/questions/20983217/how-to-display-the-subject-alternative-name-of-a-certificate
def _x509_san_dns_names(certificate):
    """ Return a list of strings containing san dns names
    """
    crt_san_data = certificate.extensions.get_extension_for_oid(
        cryptography.x509.oid.ExtensionOID.SUBJECT_ALTERNATIVE_NAME
    )

    dns_names = crt_san_data.value.get_values_for_type(
        cryptography.x509.DNSName
    )

    return dns_names


def _find_certificate_pem(stream):
    """ Yield hunks of pem certificates
    """
    certificate_pem = []
    begin_certificate = False
    for line in stream:
        if line == b'-----END CERTIFICATE-----\n':
            begin_certificate = False
            certificate_pem.append(line)
            yield b''.join(certificate_pem)
            certificate_pem = []

        if line == b'-----BEGIN CERTIFICATE-----\n':
            begin_certificate = True

        if begin_certificate:
            certificate_pem.append(line)


def _dump_stdincert_san_dnsnames():
    """ Print line-oriented certificate fingerprint and san dns name
    """
    for certificate_pem in _find_certificate_pem(sys.stdin.buffer):
        certificate = cryptography.x509.load_pem_x509_certificate(
            certificate_pem,
            cryptography.hazmat.backends.default_backend()
        )
        certificate_fingerprint = certificate.fingerprint(
            DEFAULT_FINGERPRINT_HASH(),
        )
        certificate_fingerprint_str = ':'.join(
            '{:02x}'.format(i) for i in certificate_fingerprint
        )
        try:
            for dns_name in _x509_san_dns_names(certificate):
                sys.stdout.write('{} {}\n'.format(certificate_fingerprint_str, dns_name))

        except cryptography.x509.extensions.ExtensionNotFound:
            sys.stderr.write('{} Certificate has no extension SubjectAlternativeName\n'.format(certificate_fingerprint_str))

def go(args) -> None:
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    print("WIIIP no working version")
    sys.exit(1)
    _dump_stdincert_san_dnsnames()
    return
    if 'VIMF6' in os.environ and False: args = ['HEHE', '-i']
    parser = argparse.ArgumentParser(description="This is the description of what I do")
    parser.add_argument("FILENAME", type=str, help="file to process")

    ar = parser.parse_args(args)
    with open(ar.FILENAME, 'r') as f:
        content = f.read()
    _find_certificate_pem(content.splitlines())
    # pprint(ar)

if __name__ == '__main__':
    if 'VIMF6' in os.environ and False:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logging.exception('oups for %s', sys.argv)
            sys.exit(1)

