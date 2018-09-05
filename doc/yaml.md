https://learnxinyminutes.com/docs/yaml/


block_mapping:
    name:  foo
    id:    bar
flow_mapping: { name: foo, id: bar }
empty_flow_mapping: {}

flow_mapping:  http://www.yaml.org/spec/1.2/spec.html#id2790832
block_mapping: http://www.yaml.org/spec/1.2/spec.html#id2798057


# https://stackoverflow.com/questions/6432605/any-yaml-libraries-in-python-that-support-dumping-of-long-strings-as-block-liter
@begin=python@
    import yaml
    class folded_unicode(unicode): pass
    class literal_unicode(unicode): pass
    def folded_unicode_representer(dumper, data):
        return dumper.represent_scalar(u'tag:yaml.org,2002:str', data, style='>')
    def literal_unicode_representer(dumper, data):
        return dumper.represent_scalar(u'tag:yaml.org,2002:str', data, style='|')
    yaml.add_representer(folded_unicode, folded_unicode_representer)
    yaml.add_representer(literal_unicode, literal_unicode_representer)
    import glob
    rH = dict(data=dict())
    for f in glob.glob('*.conf'):
        with open(f, 'rb') as fd:
            #rH['data'][os.path.basename(f)] = unicode(fd.read())
            rH['data'][os.path.basename(f)] = literal_unicode(unicode(fd.read()))
    print(yaml.dump(rH, default_flow_style=False))
@end=python@
