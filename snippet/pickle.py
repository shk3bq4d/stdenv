try:
    import cPickle as pickle
except:
    import pickle
script_directory, script_name = os.path.split(__file__)
script_basename, script_ext = os.path.splitext(script_name)
fp = os.path.expanduser('~/.tmp/{}.pickle'.format(script_basename))
with open(fp, 'rb') as f:
    _cache = pickle.load(f)
with open(fp, 'wb') as f:
    pickle.dump(_cache, f)
