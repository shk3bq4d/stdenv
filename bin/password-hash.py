#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import unittest
import argparse
import logging
import passlib
import passlib.hash
#import passlib.hash

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

class PasswordHashTest(unittest.TestCase):
    #def __init__(self, methodName='runTest'): pass
    def tearDown(self): pass
    def setUp(self): pass

    @classmethod
    def setUpClass(cls): pass

    @classmethod
    def tearDownClass(cls): pass

    def test_queue_summary_alter(self):
        self.assertIn(   'a', 'abcde', msg='a is supposed to be in abcde')
        self.assertNotIn('z', 'abcde', msg='z is not supposed to be in abcde')
        self.assertNotEqual('expected', 'actual', msg='expected is first argument')
        # assertAlmostEqual assertAlmostEquals assertDictContainsSubset assertDictEqual
        # assertEqual assertEquals assertFalse assertGreater assertGreaterEqual
        # assertIn assertIs assertIsInstance assertIsNone assertIsNot assertIsNotNone
        # assertItemsEqual assertLess assertLessEqual assertListEqual assertMultiLineEqual
        # assertNotAlmostEqual assertNotAlmostEquals assertNotEqual assertNotEquals
        # assertNotIn assertNotIsInstance assertNotRegexpMatches assertRaises
        # assertRaisesRegexp assertRegexpMatches assertSequenceEqual assertSetEqual
        # assertTrue assertTupleEqual assert_ countTestCases debug defaultTestResult
        # doCleanups fail failIf failIfAlmostEqual failIfEqual failUnless failUnlessAlmostEqual
        # failUnlessEqual failUnlessRaises failureException id longMessage maxDiff
        # run setUp setUpClass shortDescription skipTest tearDown tearDownClass

def logging_conf(
        level='INFO', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    script_directory, script_name = os.path.split(__file__)
    # logging.getLogger('sh.command').setLevel(logging.WARN)
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           #'graylogf':{"format":"%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s"},
           },
       'handlers':{
           'stdout':   {'level':level,'formatter': 'standard','class':'logging.StreamHandler',         'stream': 'ext://sys.stdout'},
           'file':     {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))}, #
           'syslog':   {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
           #'graylog': {'level':level,'formatter': 'graylogf','class':'pygelf.GelfTcpHandler',         'host': 'log.mydomain.local', 'port': 12201, 'include_extra_fields': True, 'debug': True, '_ide_script_name':script_name},
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})
    try: logging.getLogger('sh.command').setLevel(logging.WARN)
    except: pass

# https://passlib.readthedocs.io/en/stable/lib/passlib.hash.html#module-passlib.hash
_ = {
    'Active Unix Hashes': [
            [passlib.hash.bcrypt, 'BCrypt'],
            [passlib.hash.sha256_crypt, 'SHA-256 Crypt'],
            [passlib.hash.sha512_crypt, 'SHA-512 Crypt'],

            [passlib.hash.unix_disabled, 'Unix Disabled Account Helper Special'], #note should be made of the following fallback helper, which is not an actual hash scheme, but implements the “disabled account marker” found in many Linux & BSD password files:'],
        ],
    'Deprecated Unix Hashes': [ # The following schemes are supported by various Unix systems using the modular crypt format, but are no longer considered secure, and have been deprecated in favor of the Active Unix Hashes (above).
            [passlib.hash.bsd_nthash, 'FreeBSD’s MCF-compatible encoding of nthash digests'],
            [passlib.hash.md5_crypt, 'MD5 Crypt'],
            [passlib.hash.sha1_crypt, 'SHA-1 Crypt'],
            [passlib.hash.sun_md5_crypt, 'Sun MD5 Crypt'],
        ],
    'Archaic Unix Hashes': [ # The following schemes are supported by certain Unix systems, but are considered particularly archaic: Not only do they predate the modular crypt format, but they’re based on the outmoded DES block cipher, and are woefully insecure:
            [passlib.hash.des_crypt, 'DES Crypt'],
            [passlib.hash.bsdi_crypt, 'BSDi Crypt'],
            [passlib.hash.bigcrypt, 'BigCrypt'],
            [passlib.hash.crypt16, 'Crypt16'],
        ],
# Other “Modular Crypt” Hashes
# The modular crypt format is a loose standard for password hash strings which started life under the Unix operating system, and is used by many of the Unix hashes (above). However, it’s it’s basic $scheme$hash format has also been adopted by a number of application-specific hash algorithms:
    'Active Hashes': [ # While most of these schemes are generally application-specific, and are not natively supported by any Unix OS, they can be used compatibly along side other modular crypt format hashes:
            # [passlib.hash.argon2, 'Argon2'], pip install argon2_cffi
            [passlib.hash.bcrypt_sha256, 'BCrypt+SHA256'],
            [passlib.hash.phpass, 'PHPass’ Portable Hash'],
            #[passlib.hash.pbkdf2_digest, 'Generic PBKDF2 Hashes'],
            [passlib.hash.scram, 'SCRAM Hash'],
            [passlib.hash.scrypt, 'SCrypt'],
        ],
    'Deprecated Hashes': [ # The following are some additional application-specific hashes which are still occasionally seen, use the modular crypt format, but are rarely used or weak enough that they have been deprecated:
            [passlib.hash.apr_md5_crypt, 'Apache’s MD5-Crypt variant'],
            [passlib.hash.cta_pbkdf2_sha1, 'Cryptacular’s PBKDF2 hash'],
            [passlib.hash.dlitz_pbkdf2_sha1, 'Dwayne Litzenberger’s PBKDF2 hash'],
        ],
# 'LDAP / RFC2307 Hashes':
# All of the following hashes use a variant of the password hash format used by LDAPv2. Originally specified in RFC 2307 and used by OpenLDAP [1], the basic format {SCHEME}HASH has seen widespread adoption in a number of programs.
    'Standard LDAP Schemes': [ # The following schemes are explicitly defined by RFC 2307, and are supported by OpenLDAP.
            [passlib.hash.ldap_md5, 'MD5 digest'],
            [passlib.hash.ldap_sha1, 'SHA1 digest'],
            [passlib.hash.ldap_salted_md5, 'salted MD5 digest'],
            [passlib.hash.ldap_salted_sha1, 'salted SHA1 digest'],
            #[passlib.hash.ldap_crypt, 'LDAP crypt() Wrappers'],
            [passlib.hash.ldap_plaintext, 'LDAP-Aware Plaintext Handler'],
        ],
    'Non-Standard LDAP Schemes': [ # None of the following schemes are actually used by LDAP, but follow the LDAP format:
            [passlib.hash.ldap_hex_md5, 'Hex-encoded MD5 Digest'],
            [passlib.hash.ldap_hex_sha1, 'Hex-encoded SHA1 Digest'],
            #[passlib.hash.ldap_pbkdf2_digest, 'Generic PBKDF2 Hashes'],
            [passlib.hash.atlassian_pbkdf2_sha1, 'Atlassian’s PBKDF2-based Hash'],
            [passlib.hash.fshp, 'Fairly Secure Hashed Password'],
            [passlib.hash.roundup_plaintext, 'Roundup-specific LDAP Plaintext Handler'],
        ],
    'SQL Database Hashes': [ # The following schemes are used by various SQL databases to encode their own user accounts. These schemes have encoding and contextual requirements not seen outside those specific contexts:
            [passlib.hash.mssql2000, 'MS SQL 2000 password hash'],
            [passlib.hash.mssql2005, 'MS SQL 2005 password hash'],
            [passlib.hash.mysql323, 'MySQL 3.2.3 password hash'],
            [passlib.hash.mysql41, 'MySQL 4.1 password hash'],
            [passlib.hash.postgres_md5, 'PostgreSQL MD5 password hash', True], # TypeError: user must be unicode or bytes, not None
            [passlib.hash.oracle10, 'Oracle 10g password hash', True],
            [passlib.hash.oracle11, 'Oracle 11g password hash'],
        ],
    'MS Windows Hashes': [ # The following hashes are used in various places by Microsoft Windows. As they were designed for “internal” use, they generally contain no identifying markers, identifying them is pretty much context-dependant.
            [passlib.hash.lmhash, 'LanManager Hash'],
            [passlib.hash.nthash, 'Windows’ NT-HASH'],
            [passlib.hash.msdcc, 'Windows’ Domain Cached Credentials', True],
            [passlib.hash.msdcc2, 'Windows’ Domain Cached Credentials v2', True],
        ],
    'Cisco IOS': [ # The following hashes are used in various places on Cisco IOS, and are usually referred to by a Cisco-assigned “type” code:
            [passlib.hash.md5_crypt, '“Type 5”'], # hashes are actually just the standard Unix MD5-Crypt hash, the format is identical.'],
            [passlib.hash.cisco_type7, '“Type 7”'], # isn’t actually a hash, but a reversible encoding designed to obscure passwords from idle view.'],
            # “Type 8” hashes are based on PBKDF2-HMAC-SHA256; but not currently supported by passlib (issue 87).
            # “Type 9” hashes are based on scrypt; but not currently supported by passlib (issue 87).
        ],
    'Cisco PIX & ASA': [ # Separately from this, Cisco PIX & ASA firewalls have their own hash formats, generally identified by the “format” parameter in the username user password hash format config line they occur in. The following are known & handled by passlib:
            [passlib.hash.cisco_pix, 'PIX “encrypted”'], # hashes use a simple unsalted MD5-based algorithm.'],
            [passlib.hash.cisco_asa, 'ASA “encrypted” '], #hashes use a similar algorithm to PIX, with some minor improvements.'],
            # ASA “nt-encrypted” hashes are the same as passlib.hash.nthash, except that they use base64 encoding rather than hexadecimal.
            # ASA 9.5 added support for “pbkdf2” hashes (based on PBKDF2-HMAC-SHA512); which aren’t currently supported by passlib (issue 87).
        ],
    'Other Hashes': [  #The following schemes are used in various contexts, but have formats or uses which cannot be easily placed in one of the above categories:
            #[passlib.hash.django_digest, 'Django-specific Hashes'],
            [passlib.hash.grub_pbkdf2_sha512, 'Grub’s PBKDF2 Hash'],
            #[passlib.hash.hex_digest, 'Generic Hexadecimal Digests'],
            [passlib.hash.plaintext, 'Plaintext'],
        ]
}

def _iter():
    for category in _.values():
        for item in category:
            yield item


def go(args):
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    password = " ".join(args)
    username = ""
    for elem in _iter():
    #for elem in _iter():
        #pprint(elem)
        if len(elem) == 2:
            algo, algoname = elem
            user = False
        else:
            algo, algoname, user = elem
        #print(algoname)
        if user:
            h = algo.hash(password, user=username)
        else:
            h = algo.hash(password)
        print('{:<60s} {}'.format(algoname, h))


if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ and False:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logging.exception('oups for %s', sys.argv)
            #logging.error('oups for %s', sys.argv)
            #raise type(e), type(e)(e), sys.exc_info()[2]

