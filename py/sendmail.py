#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import os
import sys
import re
import argparse
import logging

from pprint import pprint, pformat

logger = logging.getLogger(__name__)


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

def sendmail(to, subject, body, fr=None, cc=[], bcc=[], attachments=[], html=None, smtp_host=None, smtp_port=587, smtp_password=None, smtp_login=None, smtp_mode='tls'):

    if fr is None:
        fr = smtp_login
    sender=(fr,fr)
    logger.info('sender: %s', sender)

    text_content=body
    if isinstance(to, list):
        recipients = to
    else:
        recipients = to.split(',')
    if cc is None:
        cc = ''
    else:
        if isinstance(cc, list):
            cc = cc
        else:
            cc = cc.split(',')
    if bcc is None:
        bcc = ''
    else:
        if isinstance(bcc, list):
            bcc = bcc
        else:
            bcc = bcc.split(',')

    prefered_encoding='utf-8'
    text_encoding='utf-8'

    def attach2pyzmail(i):
        mime = magic.Magic(mime=True)
        directory, filename = os.path.split(i)
        with open(i, 'rb') as f:
            data = f.read()
        t = mime.from_file(i)
        charset = ''
        if t is None or '/' not in t:
            maintype = 'application'
            subtype = 'octet-stream'
        else:
            maintype, subtype = t.split('/', 1)

        return (data, maintype, subtype, filename, charset)

    attachments = map(attach2pyzmail, attachments)
    payload, mail_from, rcpt_to, msg_id=pyzmail.compose_mail(
        sender,
        recipients,
        subject,
        prefered_encoding,
        (text_content, text_encoding),
        html=None if html is None else (html, text_encoding),
        attachments=attachments,
        bcc=bcc,
        cc=cc
        )

    logger.info('mail_from: %s', mail_from)

    ret=pyzmail.send_mail(payload, mail_from, rcpt_to, smtp_host, \
            smtp_port=smtp_port, smtp_mode=smtp_mode, \
            smtp_login=smtp_login, smtp_password=smtp_password)

    if isinstance(ret, dict):
        if ret:
            logger.info('failed recipients:' + ', '.join(ret.keys()))
        else:
            logger.info('success')
    else:
        logger.info('error:' + ret)
    return ret

def go(args):
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMF6' in os.environ and False: args = ['HEHE', '-i']
    parser = argparse.ArgumentParser(description="This is the description of what I do")
    parser.add_argument("-t", "--to")
    parser.add_argument("-s", "--subject")
    parser.add_argument("-f", "--from")
    parser.add_argument("-c", "--cc")
    parser.add_argument("-b", "--bcc")
    parser.add_argument("-a", "--attachments", type=list)
    parser.add_argument("-r", "--html", action="store_true")
    parser.add_argument("-o", "--stmp-host", action="store_true")
    parser.add_argument("-p", "--stmp-port", type=int)
    parser.add_argument("-l", "--smtp-login")
    parser.add_argument("-w", "--smtp-password")
    parser.add_argument("-m", "--smtp-mode", default='tls')
    ar = parser.parse_args(args)
    body = "\n".join(map(str.rstrip, fileinput.input(files=None)))
    sendmail(ar.to, ar.subject, body, fr=ar.from, cc=ar.cc, bcc=ar.bcc, attachments=ar.attachments, html=ar.html, smtp_host=ar.smtp_host, smtp_port=ar.smtp_port, smtp_password=ar.smtp_password, smtp_login=ar.smtp_login, smtp_mode=ar.smtp_mode)



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

