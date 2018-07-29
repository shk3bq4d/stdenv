#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import shutil
import os
import datetime
import sys
import re
import argparse
import logging
import json

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

def logging_conf(
        level='INFO', # DEBUG
        use='stdout' # "stdout syslog" "stdout syslog file"
        ):
    import logging.config
    script_directory, script_name = os.path.split(__file__)
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

FP = os.path.expanduser('~/.tmp/mrstack.txt')
HFP = os.path.expanduser('~/.tmp/mrstack.touch')
DT  = u'%Y.%m.%d %H:%M:%S'
OUT = u'{:<3d} {:%a %b%d %H:%M} {}'
OUT2 = '\n' + u' ' * 20 # multiline joiner
IN  = u'{:%Y.%m.%d %H:%M:%S} {}\n'
ONE_HOUR_IN_SECONDS = 3600

def reader():
    if not os.path.isfile(FP): return
    with open(FP, 'rb') as f:
        #for line in f.readline():
        #for idx, line in enumerate(f.readline()):
        for idx, line in enumerate(f):
            line = line.strip()
            if line == '': continue
            words = line.split(' ', 2)
            #print(idx)
            #print(line)
            #pprint(words)
            #idx = words[0]
            dt = ' '.join(words[0:2])
            try:
                dt = datetime.datetime.strptime(dt, DT)
            except:
                dt = datetime.datetime.now()
            txt = unescape(words[2])
            yield idx, dt, txt

def readertoday(d=datetime.date.today()):
    for i in readerdays([d]):
        yield i

def readerdays(dA):
    for line in reader():
        idx, dt, txt = line
        if dt.date() in dA:
            yield line

def readerbusinesstoday(d=datetime.date.today()):
    dates = sorted(list(set([i[1].date() for i in reader() if i[1].date() <= d])), reverse=True)
    to_pick = []
    n = 0
    if dates[0] == d:
        to_pick.append(d)
        dates.pop(0)
        n = n + 1
    for i in dates:
        to_pick.append(i)
        if i.isoweekday() in range(1, 4): break

    for i in readerdays(to_pick):
        yield i

    #if False: yield None
    raise StopIteration()

def escape(txt):
    r = txt
    r = r.strip()
    r = json.dumps(r)
    r = r[1:-1] # removes leading and trailing "
    return r

def unescape(txt):
    r = '"{}"'.format(txt)
    r = json.loads(r)
    return r

def write(txt, dt=datetime.datetime.now(), fp=FP):
    with open('/tmp/a', 'ab') as f2:
        f2.write('coucou')
    content = IN.format(
        dt,
        escape(txt)
        )
    logger.info(pformat(content))
    with open(fp, 'ab') as f:
        logger.info(f)
        try:
            f.write(content)
        except TypeError:
            f.write(content.encode())

def go_dump(myreader=reader):
    for line in myreader():
        idx, dt, txt = line
        #pprint(txt.splitlines())
        txt = OUT2.join(txt.splitlines())
        #pprint(txt)
        #print(txt)
        #sys.exit(0)
        print(OUT.format(idx, dt, txt))

def go_write(txtA):
    write(' '.join(txtA))

def go_hourly_print():
    # cases
    # - last touch is younger than one hour   => noop
    # - last touch is from yesterday or older => print yesterday_business
    # - we are before 12                      => print yesterday_business
    #                                         => print today

    now = datetime.datetime.now()
    today_noon = now.replace(hour=12, minute=0, second=0)
    dt = datetime.datetime.fromtimestamp(os.path.getmtime(HFP)) if os.path.isfile(HFP) else now

    if (now - dt).total_seconds() < ONE_HOUR_IN_SECONDS:
        pass
    elif now.date() != dt.date() or \
        now < today_noon:
        go_dump(readerbusinesstoday)
        touch(HFP)
    else:
        go_dump(readertoday)
        touch(HFP)

def touch(fname, times=None):
    fhandle = open(fname, 'a')
    try:
        os.utime(fname, times)
    finally:
        fhandle.close()

def go_auto_delete():
    txtA = []
    fp = FP + '.tmp'
    try:
        os.unlink(fp)
    except BaseException as e:
        pass
    for idx, dt, txt in reader():
        if txt in txtA: continue
        write(txt, dt=dt, fp=fp)
        txtA.append(txt)
    use_file(fp)

def go_delete(line_number):
    try:
        idx, dt, txt = next(i for i in reader() if i[0] == line_number)
    except StopIteration as e:
        print('No such line number {}'.format(line_number))
    txt_ref = txt
    response = raw_input("Are you sure you want do delete (y|N):\n{}\n".format(txt))
    if response.strip().lower() != 'y':
        print('OK, aborting')
        return
    fp = FP + '.tmp'
    try:
        os.unlink(fp)
    except BaseException as e:
        pass
    for idx, dt, txt in reader():
        if idx == line_number:
            if txt != txt_ref:
                print('FATAL: line content for line {} does not match'.format(line_number))
                return
            continue
        write(txt, dt=dt, fp=fp)
    use_file(fp)

def use_file(fp):
    fp_backup = FP + '.backup'
    shutil.move(FP, fp_backup)
    shutil.move(fp, FP)
    os.unlink(fp_backup)

def go(args):
    # https://docs.python.org/2/library/argparse.html
    #logger.info(__file__)
    #logger.debug(__file__)
    parser = argparse.ArgumentParser(description="This is the description of what I do")
    parser.add_argument("TEXT", type=str, nargs='*', help="text to add")
    parser.add_argument("-a", "--auto-delete-clones", action='store_true', help="delete clones")
    parser.add_argument("-H", "--hourly-print", action='store_true', help="print outputs on 'hourly' basis suitable for inclusiong in ~/.zshrc")
    parser.add_argument("-d", "--delete", type=int, help="delete line number")
    parser.add_argument("-t", "--today", action="store_true", help="only print stack from today")
    parser.add_argument("-b", "--business-yesterday", action="store_true", help="only print stack from today and last business day")
    #script_directory, script_name = os.path.split(__file__)
    #script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    #print(script_txt)
    ar = parser.parse_args(args)
    if False: pass
    elif ar.hourly_print:
        if ar.auto_delete_clones or ar.delete or ar.today or ar.business_yesterday or len(ar.TEXT) > 0:
            parser.print_usage()
        else:
            go_hourly_print()
    elif ar.auto_delete_clones:
        if ar.delete or ar.today or ar.business_yesterday or len(ar.TEXT) > 0:
            parser.print_usage()
        else:
            go_auto_delete()
    elif ar.delete is not None:
        if ar.today or ar.business_yesterday or len(ar.TEXT) > 0:
            parser.print_usage()
        else:
            go_delete(ar.delete)
    elif ar.today:
        if ar.business_yesterday or len(ar.TEXT) > 0:
            parser.print_usage()
        else:
            go_dump(readertoday)
    elif ar.business_yesterday:
        if len(ar.TEXT) > 0:
            parser.print_usage()
        else:
            go_dump(readerbusinesstoday)
    elif len(ar.TEXT) == 0:
        go_dump()
    else:
        go_write(ar.TEXT)

if __name__ == '__main__':

    logging_conf()
    try:
        go(sys.argv[1:])
    except BaseException as e:
        logging.exception('oups')
        raise e

