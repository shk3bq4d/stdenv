#!/usr/bin/env python

from sh import i3_msg
from pprint import pprint
import json
import copy

def traverse(elem, workspace=None):
	children = []
	children.extend(elem['nodes'])
	children.extend(elem['floating_nodes'])
	r = None
	for node in children:
		w = workspace
		if node['type'] == 'workspace':
			w = node['name']
		if node['focused']:
			r = w
			break
#print('{focused} ty:{type:20s} w:{w:10s} {workspace} {name}'.format(w=w, workspace=workspace, **node))
#pprint(node)
		r = traverse(node, w)
		if r is not None:
			break
	return r

def go():
	root = json.loads(str(i3_msg('-t', 'get_tree')))
	return traverse(root)
	

if __name__ ==  "__main__":
	print(go())
