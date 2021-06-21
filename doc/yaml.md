kkkkkkkkkkk

```yaml
array:
- hehe
- habon
hash:
  firstkey: firstvalue # this is a comment
  rootkey:
---
seconddocument:
  youpi: "string"
---
receipt:     Oz-Ware Purchase Invoice
date:        2012-08-06
customer:
    first_name:   Dorothy
    family_name:  Gale

items:
    - part_no:   A4786
      descrip:   Water Bucket (Filled)
      price:     1.47
      quantity:  4

    - part_no:   E1628
      descrip:   High Heeled "Ruby" Slippers
      size:      8
      price:     133.7
      quantity:  1

bill-to:  &id001 # the full bill-to dictionary can be refered with *id001 anchor reference
    street: | # multiline are kept as multiline but dedented. Ends with new line
            123 Tornado Alley
            Suite 16
    city:   East Centerville
    state:  KS

foo: &bar original  # the string/scalar `original` with anchor bar can be referenced with *bar
bar: *bar           # reference to scalar `original`

ship-to:  *id001

# sequencer protocols for Laser eye surgery
---
- step:  &id001                  # defines anchor label &id001
    instrument:      Lasik 2000
    pulseEnergy:     5.4
    pulseDuration:   12
    repetition:      1000
    spotSize:        1mm

- step: &id002
    instrument:      Lasik 2000
    pulseEnergy:     5.0
    pulseDuration:   10
    repetition:      500
    spotSize:        2mm
- step: *id001                   # refers to the first step (with anchor &id001)
- step: *id002                   # refers to the second step
- step:
    <<: *id001
    spotSize: 2mm                # redefines just this key; refers to &id001 for the rest
- step: *id002

specialDelivery:  > # multiline are merged / fold on single line FOR AS LONG AS INDENT IS SAME . Ends with new line
    Follow the Yellow Brick
    Road to the Emerald City.
    Pay no attention to the
    man behind the curtain.
...
---
a: 123                     # an integer
b: "123"                   # a string, disambiguated by quotes
c: 123.0                   # a float
d: !!float 123             # also a float via explicit data type prefixed by (!!)
e: !!str 123               # a string, disambiguated by explicit type
f: !!str Yes               # a string via explicit type
g: Yes                     # a boolean True (yaml1.1), string "Yes" (yaml1.2)
h: Yes we have No bananas  # a string, "Yes" and "No" disambiguated by context.
 ---
 picture: !!binary |
  R0lGODdhDQAIAIAAAAAAANn
  Z2SwAAAAADQAIAAACF4SDGQ
  ar3xxbJ9p0qa7R0YxwzaFME
  1IAADs=
---
myObject:  !myClass { name: Joe, age: 15 }
```

```yaml
block_mapping:
    name:  foo
    id:    bar
flow_mapping: { name: foo, id: bar }
empty_flow_mapping: {}

flow_mapping:  http://www.yaml.org/spec/1.2/spec.html#id2790832
block_mapping: http://www.yaml.org/spec/1.2/spec.html#id2798057
```


# https://stackoverflow.com/questions/6432605/any-yaml-libraries-in-python-that-support-dumping-of-long-strings-as-block-liter
```python
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
```


YAML single quote escaping: 'bipip''hehe''youpi' -> bipbip'hehe'youpi # https://yaml.org/spec/current.html#id2534365


https://yaml-multiline.info/
Block Style Indicator: The block style indicates how newlines inside the block should behave. If you would like them to be kept as newlines, use the literal style, indicated by a pipe (|). If instead you want them to be replaced by spaces, use the folded style, indicated by a right angle bracket (>). (To get a newline using the folded style, leave a blank line by putting two newlines in. Lines with extra indentation are also not folded.) # multiline

Block Chomping Indicator: The chomping indicator controls what should happen with newlines at the end of the string. The default, clip, puts a single newline at the end of the string. To remove all newlines, strip them by putting a minus sign (-) after the style indicator. Both clip and strip ignore how many newlines are actually at the end of the block; to keep them all put a plus sign (+) after the style indicator. # multiline

Indentation Indicator: Ordinarily, the number of spaces you're using to indent a block will be automatically guessed from its first line. You may need a block indentation indicator if the first line of the block starts with extra spaces. In this case, simply put the number of spaces used for indentation (between 1 and 9) at the end of the header. # multiline
