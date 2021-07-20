#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import yaml
import time
import os
import sys
import re
import json
import unittest
import requests
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

logger = logging.getLogger(__name__)

class ElasticElsTest(unittest.TestCase):
    #def __init__(self, methodName='runTest'): pass
    def tearDown(self) -> None: pass
    def setUp(self) -> None: pass

    @classmethod
    def setUpClass(cls) -> None: pass

    @classmethod
    def tearDownClass(cls) -> None: pass

    def test_queue_summary_alter(self) -> None:
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
        use='stdout', # "stdout syslog" "stdout syslog file"
        filepath=None,
        ) -> None:
    import logging.config
    script_directory, script_name = os.path.split(__file__)
    # logging.getLogger('sh.command').setLevel(logging.WARN)
    if filepath is None:
        filepath = os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
       'formatters':{
           'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s'},
           'syslogf': {'format':'%(filename)s[%(process)d]: %(levelname)-5s %(funcName)s(): %(message)s'},
           #'graylogf':{"format":"%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s"},
           },
       'handlers':{
           'stdout':   {'level':level,'formatter': 'standard','class':'logging.StreamHandler',         'stream': 'ext://sys.stdout'},
           'file':     {'level':level,'formatter': 'standard','class':'logging.FileHandler',           'filename': filepath}, #
           'syslog':   {'level':level,'formatter': 'syslogf', 'class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # (localhost, 514), local5, ...
           #'graylog': {'level':level,'formatter': 'graylogf','class':'pygelf.GelfTcpHandler',         'host': 'log.mydomain.local', 'port': 12201, 'include_extra_fields': True, 'debug': True, '_ide_script_name':script_name},
       }, 'loggers':{'':{'handlers': use.split(),'level': level,'propagate':True}}})
    try: logging.getLogger('sh.command').setLevel(logging.WARN)
    except: pass

TOP_URL = 'http://localhost:9200'
def http(url, method=None, **kwargs):
    if not url.startswith('/'):
        url = '/' + url
    url = TOP_URL + url
    headers = kwargs.pop('headers', {})
    headers['content-type'] = 'application/json'
    params = kwargs.pop('params', {})
    params['format'] = 'json'
    data = kwargs.pop('data', None)
    if data is not None and method is None:
        method = 'POST'
    if data is not None and type(data) in [list, dict]:
        data = json.dumps(data)

    if method is None:
        method = 'GET'
    logger.info("{method} {url}?{params} {data}".format(**locals()))
    r = requests.request(method, url, params=params, headers=headers, data=data, **kwargs)
    return r.json()

def nodes(**kwargs): return http('_cat/nodes', **kwargs)
def shards(**kwargs): return http('_cat/shards', **kwargs)

def node_names():
    return list(map(lambda x: x['name'], nodes()))

def get_shard(index, shard):
    logger.info('%s %s', index, shard)
    for _shard in shards():
        if _shard['index'] != index: continue
        if str(_shard['shard']) != str(shard): continue
        return _shard
    raise BaseException()

def test_connection():
    nodes()

def start_routing_allocation_transient(start=True):
    stop_routing_allocation_transient(stop=not start)

def stop_routing_allocation_transient(stop=True):
    url = '_cluster/settings'
    method = 'PUT'
    b = "none" if stop else "all"
    data = {"transient": {"cluster.routing.allocation.enable": b}}
    r = http(url, method=method, data=data)
    if r.get("acknowledged", False) is not True:
        logger.error("%s", r)
        raise BaseException("Unexpected answer")
    logger.info("<- %s", r)

def cat_indices():
    return http('_cat/indices')

def active_graylog_indices():
    max_numberH = {}
    for indexH in cat_indices():
        name = indexH.get('index')
        if  re.match(r'^gl.events.\d+$',        name) is not None or \
            re.match(r'^gl.system.events.\d+$', name) is not None or \
            re.match(r'^gl.index.failure.\d+$',  name) is not None or \
            False:
            continue
        short_name, number = re.match('(.*)_(\d+)$', name).groups()
        max_numberH[short_name] = max(max_numberH.get(short_name, -1), int(number))
    rA = []
    for k, v in max_numberH.items():
        rA.append(f'{k}_{v}')
    return sorted(rA)

def graylog_per_index_fields():
    rH = {}
    for index_name in active_graylog_indices():
        # curl -s http://els-host:9200/graylog_392/_mapping | jq '.[].mappings.properties | length' # number fields in one index
        mappingH = http(f'{index_name}/_mapping')
        rH[index_name] = list(mappingH[index_name]['mappings']['properties'].keys())
    return rH

def print_yaml(i):
    print(yaml.safe_dump(i))

def go(args) -> None:
    #pprint(node_names())
    try:
        http('_cluster/settings')
    except requests.exceptions.ConnectionError:
        print(f"no access to any ELS cluster at {TOP_URL}. try:")
        print("ssh -L 9200:127.0.0.1:9200 myelshost")
        return
    if 0:
        #stop_routing_allocation_transient()
        start_routing_allocation_transient()
    if 0:
        url = '_cluster/settings'
        url = '_cluster/health'
        url = '_cat/shards'
        pprint(http(url))
    if 0:
        print(yaml.safe_dump(graylog_per_index_fields()))
    if 0:
        url = "_template"
        print_yaml(http(url))
    if 1:
        idx = "gl_okta"
        idx = "gl_ansible"
        n = idx + "-template"
        url = "_template/" + n
        oH = http(url)
        sH = oH[n]['settings']
        uH = sH
        k = "index.mapping.total_fields"
        for i in k.split("."):
            print(i)
            uH[i] = uH.get(i, {})
            uH = uH[i]
        uH["limit"] = 1050

        print_yaml(oH[n])

        rH = http(url, method="PUT", data=oH[n])
        pprint(rH)

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ and False:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logging.exception('oups for %s', sys.argv)
            sys.exit(1)

