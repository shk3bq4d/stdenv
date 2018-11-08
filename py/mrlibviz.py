#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Try to reproduce the dot file example_cluster1.dot with pydot.
"""
import pydot
import pprint
import copy
import re
import os
import inspect
#import pbs
import sh
import tempfile
from pprint import pprint
#from PIL import Image

default_graph=None

def dg(**kwargs):
	global default_graph
	if 'graph_type' not in kwargs: kwargs['graph_type'] = 'digraph'
	if 'fontname'   not in kwargs: kwargs['fontname']   = 'Verdana'
	if 'compound'   not in kwargs: kwargs['compound']   = True
	g = pydot.Dot(**kwargs)

	if default_graph is None:
		default_graph = g
	return g

def w(fn=None, g=None, format='raw', engine='dot', temp_fp=None):
	if format == 'svg':
		if fn is None:
			frame,filename,line_number,function_name,lines,index=inspect.getouterframes(inspect.currentframe())[1]
			fn = filename + '.svg'
                fd = -1
                if temp_fp:
                    tfp =  temp_fp
                else:
                    fd, tfp =  tempfile.mkstemp()
		print(tfp)
		
		w(fn=tfp, g=g, format='raw')
                cmd = sh.Command(engine)
		try:
                    
			cmd('-Tsvg', '-o' + fn, '-v', tfp)
		#except BaseException as e:
		except Exception as e:
		#except pbs.ErrorReturnCode_1 as e:
			print('=============================================')
			print(e.stderr)
			print('=============================================')
			raise e
                if fd >= 0:
                    os.close(fd)
		return fn

	g = g or default_graph
	if fn is None:
		frame,filename,line_number,function_name,lines,index=inspect.getouterframes(inspect.currentframe())[1]
		fn = filename + '.'
		if format == 'raw':
			fn = fn + 'viz'
		else:
			fn = fn + format
	
	print('format is {}, fn is {}'.format(format, fn))
	g.write(fn, format=format)
	return fn

"""
def dg():
	global default_graph
	g = pydot.Dot(graph_type='digraph',fontname="Verdana")
	sg = pydot.Subgraph()
	g.add_subgraph(sg)

	if default_graph is None:
		default_graph = sg
	return sg

def w(fn=None, g=None):
	g = g or default_graph
	if fn is None:
		frame,filename,line_number,function_name,lines,index=inspect.getouterframes(inspect.currentframe())[1]
		fn = filename + '.viz'
	g.get_parent_graph().write(fn)
"""

def group(*args, **kwargs):
	if 'label' not in kwargs:
		kwargs['label'] = ' '
	if 'style' not in kwargs:
		kwargs['style'] = 'dotted'
	node = args[0]
	if ',' in node:
		node = node.split(',')[0]
	parent = get_parent(node)
	if 'parent' not in kwargs:
		kwargs['parent'] = parent
	r = cluster('group_' + str(group.counter), **kwargs)
	group.counter += 1
	move(r, *args)
	return r
group.counter = 0

def get_names(*args):
    pprint(args)
    return map(lambda x: x.get_name(), args)

def align(edge_boolean, *args, **kwargs):
	r = []
	for arg in args:
		if isinstance(arg, str):
			r.extend(arg.split(','))
		else:
			r.append(arg)
	r = map(_align, r)
	#print(r)
			
	newparent = cluster(
		'group_' + str(group.counter),
		parent=get_parent(r[0]),
		style='invisible',
		label=' ',
		**kwargs
		)
	group.counter += 1
	move(newparent, *r)
	if edge_boolean:
		e(*r, style='invisible', arrowhead='none', length=0.01, weight=2)
	return r
def _align(node):
	if isinstance(node, str) and node == '':
		node = n('_i' + str(group.counter), label=' ', style='invisible')
		group.counter += 1
	return node
group.counter = 0


def a(*names, **kwargs):
	for name in names:
		if isinstance(name, list):
			for node in name:
				a(node, **kwargs)
			return
		if isinstance(name, str):
			if ',' in name:
				a(name.split(','), **kwargs)
				return
			if name[0] == '.':
				name = name[1:]
				if name in n.cn:
					a(*n.cn[name], **kwargs)
				else:
					raise BaseException('unknown classname {}'.format(name))
				return
			elem = get_node(name)
		else:
			elem = name


		for key, value in kwargs.iteritems():
			elem.set(key, value)


def e2(*args, **kwargs):
	print(len(args))
	
def e(*args, **kwargs):
	(parent, classnames, kw)=p(**kwargs)
	r = []
	if len(args) == 1:
		#r.append(pydot.Edge(args[0].split(',')[0], args[0].split(',')[1], **kwargs))
		arg = args[0]
		if isinstance(arg, str):
			arg = args[0].split(',')
			if len(arg) > 1:
				return e(*arg, **kwargs)
			else:
				raise BaseException('unexpected edge definition {0}'.format(args[0]))
		else:
			return e(*arg, **kwargs)
	else:
		pa = None
		for ar in args:
			if isinstance(ar, list):
				if len(ar) == 0:
					raise BaseException('list of zero length')
				if isnode(ar[0]):
					ar = map(pydot.Node.get_name, ar)
				ar = ','.join(ar)

			if isnode(ar) or isinstance(ar, pydot.Cluster):
				ar = ar.get_name()
			if pa:
				for s1 in pa.split(','):
					for s2 in ar.split(','):
						r.append(pydot.Edge(s1, s2, **kw))
			pa = ar
	for ed in r:
		#a(e, **kwargs)
		parent.add_edge(ed)

	if len(r) == 1:
		return r[0]
	return r

def cluster(*args, **kwargs):
	return _sg(True, *args, **kwargs)

def sg(*args, **kwargs):
	return _sg(False, *args, **kwargs)

def _sg(clust, *args, **kwargs):
	r = []
	(parent, classnames, kwargs)=p(**kwargs)
	for arg in _elems(*args):
		kw = copy.copy(kwargs)
		if clust:
			if 'label'  not in kw:
				kw['label'] = arg
			sg = pydot.Cluster(arg, **kw)
		else:
			sg = pydot.Subgraph(arg, **kw)
		r.append(sg)
		if parent is None:
			default_graph.add_subgraph(sg)
		else:
			parent.add_subgraph(sg)

	if len(r) == 1:
		return r[0]
	return r
def isdot(o): 	     return isinstance(o, pydot.Dot)
def isgraph(o): 	 return isinstance(o, pydot.Graph) and not(isnodeoredge(o)) and not isdot(o)
def isnode(o): 		 return isinstance(o, pydot.Node)
def isedge(o): 		 return isinstance(o, pydot.Edge)
def isdot(o): 		 return isinstance(o, pydot.Dot)
def isnodeoredge(o): return isnode(o) or isedge(o)
brewers = ['accent3', 'accent4', 'accent5', 'accent6', 'accent7', 'accent8', 'blues3', 'blues4',
'blues5', 'blues6', 'blues7', 'blues8', 'blues9', 'brbg10', 'brbg11',
'brbg3', 'brbg4', 'brbg5', 'brbg6', 'brbg7', 'brbg8', 'brbg9',
'bugn3', 'bugn4', 'bugn5', 'bugn6', 'bugn7', 'bugn8', 'bugn9',
'bupu3', 'bupu4', 'bupu5', 'bupu6', 'bupu7', 'bupu8', 'bupu9',
'dark23', 'dark24', 'dark25', 'dark26', 'dark27', 'dark28', 'gnbu3',
'gnbu4', 'gnbu5', 'gnbu6', 'gnbu7', 'gnbu8', 'gnbu9', 'greens3',
'greens4', 'greens5', 'greens6', 'greens7', 'greens8', 'greens9', 'greys3',
'greys4', 'greys5', 'greys6', 'greys7', 'greys8', 'greys9', 'oranges3',
'oranges4', 'oranges5', 'oranges6', 'oranges7', 'oranges8', 'oranges9', 'orrd3',
'orrd4', 'orrd5', 'orrd6', 'orrd7', 'orrd8', 'orrd9', 'paired10',
'paired11', 'paired12', 'paired3', 'paired4', 'paired5', 'paired6', 'paired7',
'paired8', 'paired9', 'pastel13', 'pastel14', 'pastel15', 'pastel16', 'pastel17',
'pastel18', 'pastel19', 'pastel23', 'pastel24', 'pastel25', 'pastel26', 'pastel27',
'pastel28', 'piyg10', 'piyg11', 'piyg3', 'piyg4', 'piyg5', 'piyg6',
'piyg7', 'piyg8', 'piyg9', 'prgn10', 'prgn11', 'prgn3', 'prgn4',
'prgn5', 'prgn6', 'prgn7', 'prgn8', 'prgn9', 'pubu3', 'pubu4',
'pubu5', 'pubu6', 'pubu7', 'pubu8', 'pubu9', 'pubugn3', 'pubugn4',
'pubugn5', 'pubugn6', 'pubugn7', 'pubugn8', 'pubugn9', 'puor10', 'puor11',
'puor3', 'puor4', 'puor5', 'puor6', 'puor7', 'puor8', 'puor9',
'purd3', 'purd4', 'purd5', 'purd6', 'purd7', 'purd8', 'purd9',
'purples3', 'purples4', 'purples5', 'purples6', 'purples7', 'purples8', 'purples9',
'rdbu10', 'rdbu11', 'rdbu3', 'rdbu4', 'rdbu5', 'rdbu6', 'rdbu7',
'rdbu8', 'rdbu9', 'rdgy10', 'rdgy11', 'rdgy3', 'rdgy4', 'rdgy5',
'rdgy6', 'rdgy7', 'rdgy8', 'rdgy9', 'rdpu3', 'rdpu4', 'rdpu5',
'rdpu6', 'rdpu7', 'rdpu8', 'rdpu9', 'rdylbu10', 'rdylbu11', 'rdylbu3',
'rdylbu4', 'rdylbu5', 'rdylbu6', 'rdylbu7', 'rdylbu8', 'rdylbu9', 'rdylgn10',
'rdylgn11', 'rdylgn3', 'rdylgn4', 'rdylgn5', 'rdylgn6', 'rdylgn7', 'rdylgn8',
'rdylgn9', 'reds3', 'reds4', 'reds5', 'reds6', 'reds7', 'reds8',
'reds9', 'set13', 'set14', 'set15', 'set16', 'set17', 'set18',
'set19', 'set23', 'set24', 'set25', 'set26', 'set27', 'set28',
'set310', 'set311', 'set312', 'set33', 'set34', 'set35', 'set36',
'set37', 'set38', 'set39', 'spectral10', 'spectral11', 'spectral3', 'spectral4',
'spectral5', 'spectral6', 'spectral7', 'spectral8', 'spectral9', 'ylgn3', 'ylgn4',
'ylgn5', 'ylgn6', 'ylgn7', 'ylgn8', 'ylgn9', 'ylgnbu3', 'ylgnbu4',
'ylgnbu5', 'ylgnbu6', 'ylgnbu7', 'ylgnbu8', 'ylgnbu9', 'ylorbr3', 'ylorbr4',
'ylorbr5', 'ylorbr6', 'ylorbr7', 'ylorbr8', 'ylorbr9', 'ylorrd3', 'ylorrd4',
'ylorrd5', 'ylorrd6', 'ylorrd7', 'ylorrd8', 'ylorrd9'
]
brewer_schemes = list(sorted(set(map(lambda x: re.sub(r'\d+$', '', x), brewers))))
#pprint(brewers)
#pprint(map(lambda x: re.sub(r'\d+$', '', x), brewers))
#pprint(brewer_schemes)

def brewer(color='oranges', mx=9, fr=3, to=None):
	if color not in brewer_schemes:
		raise BaseException('{}\ncolor {} not in brewer_schemes'.format(',\n'.join(brewer_schemes), color))
	if color + str(mx) not in brewers:
		raise BaseException('{}\ncolor combination {} not in brewers'.format(',\n'.join(brewers), color + str(mx)))

	if fr > mx: fr = mx
	if fr < 1: fr = 1
	if to is None:
		return '/{}{}/{}'.format(color, mx, fr)
	if to > mx: to = mx
	if to < 1: to = 1
	return '/{}{}/{}:/{}{}/{}'.format(color, mx, fr, color, mx, to)
def p(**kwargs):
	parent=default_graph
	classnames=None
	if 'parent' in kwargs:
		pa = kwargs.pop('parent')
		if pa is None:
			parent = None
		elif pa == default_graph:
			parent = pa
		else:
			parent=get_graph(pa)
			if parent is None:
				raise BaseException('Couldnt find parent for {}'.format(pa))

			if isnodeoredge(parent) or isdot(parent):
				raise BaseException(parent)
	if 'cn' in kwargs:
		classnames=re.sub('\s+', ' ', kwargs.pop('cn').strip())
	for k,v in kwargs.items():
		if v is None or v == '':
			del kwargs[k]
	return (parent, classnames, kwargs)

def red(*elem):
	for ele in _elems(elem):
		if isedge(ele):
			a(ele, fontcolor='red', color='red')
		elif isnode(ele):
			a(ele, fontcolor='red', shape='box', color='red')
		elif isgraph(ele):
			a(ele, fontcolor='red', color='red')
		else:
			raise BaseException(ele)
	return elem
def red2(*elem):
	for ele in _elems(elem):
		if isedge(ele):
			a(ele, fontcolor='transparent', color='transparent')
		elif isnode(ele):
			a(ele, fontcolor='transparent', shape='box', color='transparent')
		elif isgraph(ele):
			a(ele, fontcolor='transparent', color='transparent')
		else:
			raise BaseException(ele)
	return elem
def i(*elem):
	for ele in _elems(elem):
		if isedge(ele):
			a(ele, style='invisible', label=' ', arrowhead='none', arrowtail='none')
		elif isnode(ele):
			#a(ele, style='invisible', label=' ')
			a(ele, style='invisible', label=' ')
		elif isgraph(ele):
			a(ele, style='invisible', label=' ')
		else:
			raise BaseException(ele)
	return elem

def _elems(*args):
	r=[]
	for arg in args:
		if isinstance(arg, str):
			for ar in arg.split(','):
				node = get_node(ar)
				if node:
					r.append(node)
				else:
					r.append(ar)
		elif isnodeoredge(arg) or isgraph(arg):
			r.append(arg)
		elif hasattr(arg, '__iter__'):
			for ar in arg:
				r.extend(_elems(ar))
		else:
			raise BaseException('unexpected ' + arg)
	return r
	
getnode_ = {}
#def getnode(name):
	#return getnode_[name]

def n(*args, **kwargs):
	r = []
	(parent, classnames, kwargs)=p(**kwargs)

	#print('classnames is {}'.format(classnames))
	
	#print mr_get_subgraph_list()

	for arg in args:
		for ar in arg.split(','):
			node = pydot.Node(ar, **kwargs)
			r.append(node)
			getnode_[ar] = node
			#a(n, **kwargs)
			if parent is None:
				default_graph.add_node(node)
			else:
				parent.add_node(node)
				#print('parent.addnode {}.addnode({})'.format(parent, ar))
			if classnames is not None:
				for cn in classnames.split(' '):
					if cn in n.cn:
						n.cn[cn].append(node)
					else:
						n.cn[cn] = [node]

	if len(r) == 1:
		return r[0]
	return r
n.cn = {}

def cn(*classnames):
	r = []
	for classname in classnames:
		for classnam in classname.split(','):
			if classnam in n.cn:
				r.extend(n.cn[classnam])
	return list(tuple(r))



def get_graph(name, g=None):
	if isgraph(name):
		return name
	g = g or default_graph
	if isnode(g):
		li = get_all_graph(g)
	elif isgraph(g) or isdot(g):
		li = get_all_graph_graph(g)
	else:
		raise BaseException('')
	for n in li:
		if n.get_name() == name:
			return n
def get_node(name, g=None):
	if isnode(name):
		return name
	g = g or default_graph
	name = name.replace('"', '')
	for n in get_all_nodes(g):
		if n.get_name().replace('"','') == name:
			return n

def get_edges(elem, g=None):
	g = g or default_graph
	names = map(lambda x: x.get_name(),  _elems(elem))
	return filter(lambda x: x.get_source() in names or x.get_destination() in names, g.get_edge_list())

def get_all_nodes(g):
	r=[]
	r.extend(g.get_nodes())
	for s in mr_get_subgraph_list(g):
		r.extend(s.get_nodes())

	return r

def mr_get_subgraph_list(g):
	global default_graph
	g = g or default_graph
	r = filter(lambda x: x, g.get_subgraph_list())
	return r
def get_all_graph_graph(g, r=[]):
	if not isgraph(g) and not isdot(g):
		raise BaseException(g)

#		p = get_parent(g)
#		if p is None or p == g:
#			return r
#		g = p

	if isgraph(g):
		r.append(g)
	for sg in mr_get_subgraph_list(g):
		get_all_graph_graph(sg, r)
	return r

def get_all_graph(n):
	if isinstance(n, str):
		name = n
		n = get_node(name)
		if n is None:
			raise BaseException('couldnt find node with name {name}'.format(**locals()))
        elif isinstance(n, pydot.Cluster):
            pass
	elif not isnode(n):
		raise BaseException(n)
	return get_all_graph_graph(n.get_parent_graph())


def get_parent(n):
	if isinstance(n, str):
		name = n
	elif n == default_graph:
		return None
	else:
		name = n.get_name()
	for sg in get_all_graph(n):
		for n2 in sg.get_node_list():
			if name == n2.get_name():
				return sg
	return default_graph




def move(new_sg, *nodes):
	for node in nodes:

		if isinstance(node, list):
			for n in node:
				move(new_sg, n)
			return
		if isnode(node):
			name = node.get_name()
                elif isinstance(node, pydot.Cluster):
                    pass
		else:
			print('node is {node}'.format(**locals()))
			if ',' in node:
				for n in node.split(','):
					move(new_sg, n)
				return
			name = node
			node = get_node(name, new_sg.get_parent_graph())
			if node is None:
				raise BaseException('couldnt find node with name {name}'.format(**locals()))

		if node.get_parent_graph() is not None:
			old_sg = get_parent(node)
			if old_sg is None:
				raise BaseException
                        if isinstance(node, pydot.Cluster):
                            #help(old_sg)
                            #old_sg.set_parent_graph(new_sg)
                            pass
                        else:
                            old_sg.del_node(node)
                if isinstance(node, pydot.Cluster):
                    new_sg.add_subgraph(node)
                    pass
                else:
                    new_sg.add_node(node)

def remove_edge_cardinal_point(e):
	i = e.obj_dict['points']
	r = (re.sub(r':[ewsn]{1,2}(")?$', r'\1', i[0]),
	     re.sub(r':[ewsn]{1,2}(")?$', r'\1', i[1]))

	e.obj_dict['points'] = r
def reverse_edge_weight(e):

	#s = e.get_source()
	#d = e.get_destination()
	# get around get_source custom reimplementation in supraviz.py
	i = e.obj_dict['points']
	e.obj_dict['points'] = (i[1], i[0])
	#pprint(vars(e))

	s = e.get_arrowtail()
	d = e.get_arrowhead()
	if s is not None or d is not None:
		e.set_arrowtail(d)
		e.set_arrowhead(s)

	s = e.get_dir()
	if s is None or s == 'forward':
		e.set_dir('back')
	else:
		e.set_dir('forward')


