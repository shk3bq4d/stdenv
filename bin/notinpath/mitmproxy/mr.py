#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */
#
# Simple script showing how to read a mitmproxy dump file
#

import urlparse
import threading
import mitmproxy 
from mitmproxy import flow
from lxml import etree 
import pprint
import StringIO
import gzip
import json
import sys
import pygments
from pygments import highlight
from pygments.lexers import JsonLexer, XmlLexer, HtmlLexer
from pygments.formatters import Terminal256Formatter, TerminalFormatter

_t = Terminal256Formatter()
_t = TerminalFormatter()
_html = HtmlLexer()
_json = JsonLexer()
_xml = XmlLexer()
def mrprint(i, lexer=None):
    with open('/tmp/out', 'ab') as f:
        if lexer is None:
            f.write(str(i)+'\n')
        else:
            highlight(i, lexer, _t, f)

def mrpprint(i):
    mrprint(pprint.pformat(i))


def request(f, c):
    #mitmproxy.log("mrresponse")
    #print(threading.current_thread().name)
    mrprint('REQUEST SENT:')
    print_request(c)

def response(f, c):
    #mitmproxy.log("mrresponse")
    #print(threading.current_thread().name)
    mrprint('RESPONSE RECEIVED FOR PREVIOUS REQUEST:')
    print_request(c)
    print_response(c)

def print_request(f):
    mrprint("""
{r.method} {r.scheme}://{r.host}{r.path} {r.http_version}""".format(r=f.request))
    for h,v in f.request.headers.iteritems():
        mrprint('{:<20s} {}'.format(h + ':', v))

    print_content(f.request)

def print_response(f):
    mrprint("""
{r.status_code} {r.reason}""".format(r=f.response))

    for h,v in f.response.headers.iteritems():
        mrprint('{:<20s} {}'.format(h + ':', v))

    print_content(f.response)

def print_content(i):
    content_printed = False
    content = i.content
    if len(content) == 0:
        return
    mrprint("")
    try:
        content_type = i.headers['Content-Type']
    except:
        content_type = ''
    if 'Content-Encoding' in i.headers and \
        'gzip' in i.headers['Content-Encoding']:
            content = gzip.GzipFile(fileobj=StringIO.StringIO(content)).read()


    mrprint('mr content type 3: {}, len():{}'.format(content_type, len(content)))
    if 'xml' in content_type:
        try:
            mrprint(etree.tostring(etree.fromstring(content), pretty_print=True), _xml)
            content_printed = True
        except:
            mrprint('xml printing failed')
            pass
    elif 'html' in content_type:
        try:
            mrprint(content, _html)
            content_printed = True
        except BaseException, e:
            mrprint('html printing failed')
            pass
    elif 'json' in content_type:
        try:
            mrprint(json.dumps(json.loads(content), indent=2), _json)
            content_printed = True
        except BaseException, e:
            mrprint('json printing failed')
            pass
    elif 'application/x-www-form-urlencoded' in content_type:
        try:
            mrprint(json.dumps(dict(urlparse.parse_qsl(content)), indent=2), _json)
            content_printed = True
        except BaseException as e:
            mrprint(e.message)
            mrprint('{} printing failed'.format(content_type))
            pass


    if not  content_printed:
        mrprint(content)

