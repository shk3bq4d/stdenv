# -*- coding: utf-8 -*-

http://www.lfd.uci.edu/~gohlke/pythonlibs
https://pypi.python.org/pypi/cx_Oracle/5.1.3

os.unlink(single_file)
shutil.rmtree(recursive_delete_directory)

# https://pip.pypa.io/en/stable/reference/requirements-file-format/#requirements-file-format
```sh
docopt == 0.6.1             # requirements Version Matching. Must be version 0.6.1
keyring >= 4.1.1            # requirements Minimum version 4.1.1
coverage != 3.5             # requirements Version Exclusion. Anything except version 3.5
Mopidy-Dirble ~= 1.1        # requirements Compatible release. Same as >= 1.1, == 1.*
pkg3>=1.0,<=2.0             # requirements
ProjectB<1.3                # requirements
```

# http://sametmax.com/sept-petites-libs-qui-changent-la-vie-dun-dev-python/
# ssh port forwarding https://stackoverflow.com/questions/11294919/port-forwarding-with-paramiko

# error: Unable to find vcvarsall.bat
# Microsoft Visual C++ Compiler for Python 2.7 -> http://www.microsoft.com/en-us/download/details.aspx?id=44266
# and manually create many subdir to reach [HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\VisualStudio\9.0\Setup\VC]
# and create a string named "ProductDir" with value "C:\\Users\\MyUser\\AppData\\Local\\Programs\\Common\\Microsoft\\Visual C++ for Python\\9.0"
"""
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\VisualStudio\9.0\Setup\VC]
@=""
"ProductDir"="C:\\Users\\MyUser\\AppData\\Local\\Programs\\Common\\Microsoft\\Visual C++ for Python\\9.0"
"""
import hashlib
hashlib.sha512("Nobody inspects the spammish repetition".encode()).hexdigest()
hashlib.md5("Nobody inspects the spammish repetition".encode()).hexdigest()
hashlib.sha1("Nobody inspects the spammish repetition".encode()).hexdigest()
hashlib.sha256("Nobody inspects the spammish repetition".encode()).hexdigest()

functools.partial # bind freeze some portion of a fuctions arguments or keywords.

from bs4 import BeautifulSoup as bs # type: ignore

# UTF-8 IO
@begin=python@
#this is bad:
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
# instead do
# PYTHONIOENCODING="UTF-8"
# in your shell or read
# https://stackoverflow.com/questions/3828723/why-should-we-not-use-sys-setdefaultencodingutf-8-in-a-py-script

# or
from io import open
with open(fp, 'w', encoding='utf-8') as f:
@end=python@


if sys.platform == "win32":
   import os, msvcrt
   msvcrt.setmode(sys.stdout.fileno(), os.O_BINARY)

import time
time.sleep(1)

import sys
sys.stdout.write('.')

import jinja2; jinja2.__version__ # test module version

from lxml import html, etree
doc = html.fromstring(t)
doc = html.parse(fp)
doc = lxml.etree.parse(filepath) # parses parser
doc = lxml.etree.fromstring(string) # parses parser
lxml.etree.tostring(doc, pretty_print=True) # outputs
doc.xpath('/*')

# process stdin line by line
"""
import fileinput # stdin
filepath = '-' # or empty, stdin
for line in fileinput.input(filepath): # stdin
    line = line.rstrip() # stdin fileinput
    if line == '': # stdin fileinput
        continue # stdin fileinput

# or in onliner
for line in filter(lambda x: len(x) > 0, map(lambda x: x.rstrip(), fileinput.input(files=None))):
for line in filter(None, map(str.rstrip, fileinput.input(files=None))):
for line in filter(None, map(str.rstrip, fileinput.input(files="-"))):
for line in filter(None, map(str.rstrip, fileinput.input())):
"\n".join(filter(None, map(str.rstrip, fileinput.input(files="-"))))

"""
from pprint import pprint; pprint(vars(obj))

# regexp regular expression
import re
str2 = re.sub(r'fsdf', '', str1)
pattern = re.compile(pattern, flags=0)
str_ = re.escape(pattern)
pprint(matcher.group())
pprint(matcher.groups())
pprint(matcher.groupdict())
pprint(re.search('(?P<first>\S+) (?P<second>\S+)', 'bonjour madame').groupdict()) # {'second': 'madame', 'first': 'bonjour'}
list_matcher = re.findall(pattern, string, flags=0)
iterator = re.finditer(pattern, string, flags=0)
match = re.match(pattern, string, flags=0)
re.purge()
match = re.search(pattern, string, flags=0)
list_str = re.split(pattern, string, maxsplit=0, flags=0)
str_ = re.sub(pattern, repl, string, count=0, flags=0)
tuple = re.subn(pattern, repl, string, count=0, flags=0)
pattern = re.template(pattern, flags=0)
re.sub(r'(foo)', r'\g<1>123', 'foobar')
re.sub(r'(foo)', r'\1hi', 'foobar')

re.DOTALL
re.I re.IGNORECASE
re.L re.LOCALE
re.M re.MULTILINE
re.U re.UNICODE
re.X re.VERBOSE
re.search(r'\bis\b', your_string) # whole word words boundary boundaries
https://docs.python.org/2/library/re.html
(?iLmsux)
(One or more letters from the set 'i', 'L', 'm', 's', 'u', 'x'.) The group matches the empty string; the letters set the corresponding flags:
i: re.I (ignore case),
L: re.L (locale dependent),
m: re.M (multi-line),
s: re.S (dot matches all),
u: re.U (Unicode dependent),
x: and re.X (verbose),
for the entire regular expression. (The flags are described in Module Contents.) This is useful if you wish to include the flags as part of the regular expression, instead of passing a flag argument to the re.compile() function.

pattern = r"""                                               # verbose multi line comments regexp, re.X re.VERBOSE multiline debug
    [a-z]    # letter                                        # verbose multi line comments regexp, re.X re.VERBOSE multiline debug
    [0-9]+   # digits                                        # verbose multi line comments regexp, re.X re.VERBOSE multiline debug
    """                                                      # verbose multi line comments regexp, re.X re.VERBOSE multiline debug
pprint(re.search(pattern, '___a035535__-ueau', flags=re.X))  # verbose multi line comments regexp, re.X re.VERBOSE multiline debug



# format https://docs.python.org/3/library/string.html#formatspec
# format str https://www.python.org/dev/peps/pep-3101/
c = 3-5j
'The complex number {0} is formed from the real part {0.real} and the imaginary part {0.imag}.').format(c)

>>> coord = (3, 5)
>>> 'X: {0[0]};  Y: {0[1]}'.format(coord)
Accessing arguments by position:

>>>
>>> '{0}, {1}, {2}'.format('a', 'b', 'c')
'a, b, c'
>>> '{}, {}, {}'.format('a', 'b', 'c')  # 2.7+ only
'a, b, c'
>>> '{2}, {1}, {0}'.format('a', 'b', 'c')
'c, b, a'
>>> '{2}, {1}, {0}'.format(*'abc')      # unpacking argument sequence
'c, b, a'
>>> '{0}{1}{0}'.format('abra', 'cad')   # arguments' indices can be repeated
'abracadabra'
Accessing arguments by name:

>>>
>>> 'Coordinates: {latitude}, {longitude}'.format(latitude='37.24N', longitude='-115.81W')
'Coordinates: 37.24N, -115.81W'
>>> coord = {'latitude': '37.24N', 'longitude': '-115.81W'}
>>> 'Coordinates: {latitude}, {longitude}'.format(**coord)
'Coordinates: 37.24N, -115.81W'
Accessing arguments’ attributes:

>>>
>>> c = 3-5j
>>> ('The complex number {0} is formed from the real part {0.real} '
...  'and the imaginary part {0.imag}.').format(c)
'The complex number (3-5j) is formed from the real part 3.0 and the imaginary part -5.0.'
>>> class Point(object):
...     def __init__(self, x, y):
...         self.x, self.y = x, y
...     def __str__(self):
...         return 'Point({self.x}, {self.y})'.format(self=self)
...
>>> str(Point(4, 2))
'Point(4, 2)'
Accessing arguments’ items:

>>>
>>> coord = (3, 5)
>>> 'X: {0[0]};  Y: {0[1]}'.format(coord)
'X: 3;  Y: 5'
Replacing %s and %r:

>>>
>>> "repr() shows quotes: {!r}; str() doesn't: {!s}".format('test1', 'test2')
"repr() shows quotes: 'test1'; str() doesn't: test2"
Aligning the text and specifying a width:

>>>
>>> '{:<30}'.format('left aligned')
'left aligned                  '
>>> '{:>30}'.format('right aligned')
'                 right aligned'
>>> '{:^30}'.format('centered')
'           centered           '
>>> '{:*^30}'.format('centered')  # use '*' as a fill char
'***********centered***********'
Replacing %+f, %-f, and % f and specifying a sign:

>>>
>>> '{:+f}; {:+f}'.format(3.14, -3.14)  # show it always
'+3.140000; -3.140000'
>>> '{: f}; {: f}'.format(3.14, -3.14)  # show a space for positive numbers
' 3.140000; -3.140000'
>>> '{:-f}; {:-f}'.format(3.14, -3.14)  # show only the minus -- same as '{:f}; {:f}'
'3.140000; -3.140000'
Replacing %x and %o and converting the value to different bases:

>>>
>>> # format also supports binary numbers
>>> "int: {0:d};  hex: {0:x};  oct: {0:o};  bin: {0:b}".format(42)
'int: 42;  hex: 2a;  oct: 52;  bin: 101010'
>>> # with 0x, 0o, or 0b as prefix:
>>> "int: {0:d};  hex: {0:#x};  oct: {0:#o};  bin: {0:#b}".format(42)
'int: 42;  hex: 0x2a;  oct: 0o52;  bin: 0b101010'
Using the comma as a thousands separator:

f'{myvar:#x}' # int as hex with leading 0x
f'{myvar:#04x}' # int as hex with leading 0x and 0 prefixed until with (including 0x) is 4 char width
f'{myvar:x}'  # int as hex with no leading 0x
f'{myvar:x}'  # int as hex with no leading 0x

>>>
>>> '{:,}'.format(1234567890)
'1,234,567,890'
Expressing a percentage:

>>>
>>> points = 19.5
>>> total = 22
>>> 'Correct answers: {:.2%}'.format(points/total)
'Correct answers: 88.64%'
Using type-specific formatting:

'{:%Y-%m-%d %H:%M:%S} printf with strftime formatting'.format(datetime.datetime(2010, 7, 4, 12, 15, 58))
f'{datetime.now():%Y.%m.%d %H:%M:%S}' printf with strftime formatting

Nesting arguments and more complex examples:

>>>
>>> for align, text in zip('<^>', ['left', 'center', 'right']):
...     '{0:{fill}{align}16}'.format(text, fill=align, align=align)
...
'left<<<<<<<<<<<<'
'^^^^^center^^^^^'
'>>>>>>>>>>>right'
>>>
>>> octets = [192, 168, 0, 1]
>>> '{:02X}{:02X}{:02X}{:02X}'.format(*octets)
'C0A80001'
>>> int(_, 16)
3232235521
>>>
>>> width = 5
>>> for num in range(5,12):
...     for base in 'dXob':
...         print '{0:{width}{base}}'.format(num, base=base, width=width),
...     print
...
    5     5     5   101
    6     6     6   110
    7     7     7   111
    8     8    10  1000
    9     9    11  1001
   10     A    12  1010
   11     B    13  1011


import types # isinstance ~instanceof~
if type(a) is types.DictType: # isinstance ~instanceof~
    do_something()
if type(b) in types.StringTypes: # isinstance ~instanceof~
    do_something_else()

if isinstance(a, dict): # types ~instanceof~
    do_something()
if isinstance(b, str) or isinstance(b, unicode): # types ~instanceof~
    do_something_else()

for k, v in dict_.iteritems():
for k, v in sorted(rH.iteritems(), key=lambda x: x[0]):

for i, v in enumerate(['tic', 'tac', 'toe']): # indexed idx
    print i, v
          0  tic
          1  tac
          2  toe

for i in reversed(xrange(1,10,2)):
for f in sorted(set(basket)):
sorted(iterable, cmp=lambda x, y: x < y, reverse=True)
sorted(iterable, key=lambda x: x, reverse=True)
students = ['dave', 'john', 'jane']
newgrades = {'john': 'F', 'jane':'A', 'dave': 'C'}
sorted(iterable, key=newgrades.__getitem__)

d = dict(sape=4139, guido=4127, jack=4098)
d.copy()
import copy; copy.deepcopy(d)


{x: x**2 for x in (2, 4, 6)} # dict DICT comprehension


{x for x in 'abracadabra' if x not in 'abc'} # set comprehension


[x**2 for x in range(10)] # list comprehension
[(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
[num for elem in vec for num in elem]
[x for x in vec if x >= 0]
[str(round(pi, i)) for i in range(1, 6)]

# del in list
del a[2:4]

# del a[:]


#### current line ###
import inspect

def lineno():
    """Returns the current line number in our program."""
    return inspect.currentframe().f_back.f_lineno

if __name__ == '__main__':
    print "hello, this is line number", lineno()
    print
    print
    print "and this is line", lineno()
#### current line ###





logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)-5s %(filename)s-%(funcName)s(): %(message)s') # oneliner

import logging
import logging.config
logger = logging.getLogger(__name__)
logging.config.dictConfig({
    'version': 1,
    'disable_existing_loggers': False,  # this fixes the problem
    'formatters': {
        'standard': {
            'format': '%(asctime)s [%(levelname)s] %(name)s: %(message)s'
        },
    },
    'handlers': {
        'default': {
            'level':'INFO',
            'formatter': 'standard',
            'class':'logging.StreamHandler',
        },
    },
    'loggers': {
        '': {
            'handlers': ['default'],
            'level': 'INFO',
            'propagate': True
        }
    }
})
def auto(level='INFO'): # DEBUG
    import logging.config
    logging.config.dictConfig({'version':1,'disable_existing_loggers':False,
        'formatters':{'standard':{'format':'%(asctime)s %(levelname)-5s %(filename)s: %(message)s'},}, 'handlers':{
        'stdout': {'level':level,'formatter': 'standard','class':'logging.StreamHandler','stream': 'ext://sys.stdout'},
        'file':   {'level':level,'formatter': 'standard','class':'logging.FileHandler','filename': '/tmp/zabbix-kg_maintenance.log'}, #
        'syslog': {'level':level,'formatter': 'standard','class':'logging.handlers.SysLogHandler','address': '/dev/log', 'facility': 'user'}, # local5, ...
        }, 'loggers':{'':{'handlers': 'stdout file syslog'.split(),'level': level,'propagate':True}}})
    return
logger.error('Failed to open file', exc_info=True) # exc_info include traceback
logger.exception(msg, *args) is equals to logger.error(msg, exc_info=True, *args).
logger.error("Error reading file '%s' at offset %d", filename, offset, exc_info=1)
logger.log(logging.ERROR, "Error reading file '%s' at offset %d", filename, offset, exc_info=1)

StreamHandler            Used to write to an output stream, typically sys.stdout or sys.stderr
FileHandler              Inherits from StreamHandler to allow writing to a disk file.
RotatingFileHandler      Used for logging to a set of files, switching from one file to the next when the current file reaches a certain size.
TimedRotatingFileHandler Used for logging to a set of files, switching from one file to the next at specified times.
SocketHandler            Used to send the events, via a socket, to a remote server listening on a TCP port.
DatagramHandler          Similar  to SocketHandler, except that UDP sockets are used. There's less overhead but less reliability.
SMTPHandler              Used to send the events to designated e-mail addresses.
SysLogHandler            Used to send the events to a UNIX/Linux syslog.
NTEventLogHandler        Used to send the events to an NT event log.
HTTPHandler              Used to post the events to a Web server.
MemoryHandler            Used to buffer events in memory until a trigger is received, at which point the events are sent to another handler to deal with.
NullHandler              Used in library code which uses logging to avoid misconfiguration messages when used in an application which doesn't configure logging.

os.path.dirname()
os.path.basename()
os.path.realpath()
os.path.abspath()
os.path.realpath(os.path.abspath())
lmod = datetime.datetime.fromtimestamp(os.path.getmtime(__file__)) # last modified time of file fp
datetime.datetime.fromtimestamp(1465016400) # equivalent of date -d @1465016400 # unix epoch
python -c "import datetime; print(datetime.datetime.utcnow().strftime('%s'))" # to unix epoch totimestamp
python -c "import datetime; print(datetime.datetime.fromtimestamp(1532532080))" # unix epoch
python -c "import datetime; print('{:%s}'.format(datetime.datetime.utcnow()))" # to unix epoch totimestamp
os.name is 'posix', 'nt', 'os2', 'ce' or 'riscos'
os.curdir is a string representing the current directory ('.' or ':')
os.pardir is a string representing the parent directory ('..' or '::')
os.sep is the (or a most common) pathname separator ('/' or ':' or '\\')
os.extsep is the extension separator ('.' or '/')
os.altsep is the alternate pathname separator (None or '/')
os.pathsep is the component separator used in $PATH etc
os.linesep is the line separator in text files ('\r' or '\n' or '\r\n')
os.defpath is the default search path for executables
os.devnull is the file path of the null device ('/dev/null', etc.)
os.getenv(key, default=None) # Get an environment variable, return None if it doesn't exist.  The optional second argument can specify an alternate default.

# list files #1
from os import listdir
from os.path import isfile, join
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]

# list files #2
from os import walk
f = []
for (dirpath, dirnames, filenames) in walk(mypath):
    f.extend(filenames)
    break

# list files #3
from os import walk; (_, _, filenames) = walk(mypath).next()

# list files #4 (keeps the same inconsistencies in filename as given)
import glob
print glob.glob("/home/adam/*.txt")

# list files #5 (fixes problems in #4 by sticking to unix paths)
import glob, os
print map(os.path.normcase, glob.glob("/home/adam/*.txt"))

# list files #5 (fixes problems in #5 if one doesn't want to have all lower case on windows)
import glob, re
print map(lambda x: re.sub(r'[/\\]+', '/', x), glob.glob("/home/adam/*.txt"))


zip map reduce


map ( function , sequence , [ sequence... ] ) → list
Create a new list from the results of applying the given function to the items of the given sequence . If more than one sequence is given, the function is called with multiple arguments, consisting of the corresponding item of each sequence. If any sequence is too short, None is used for missing value. If the function is None, map will create tuples from corresponding items in each list, much like the zip function.

Example:
>>> map(lambda a: a+1, [1,2,3,4])
[2, 3, 4, 5]
>>> map(lambda a, b: a+b, [1,2,3,4], (2,3,4,5))
[3, 5, 7, 9]
>>> map(lambda a, b: a + b if b else a + 10, [1,2,3,4,5], (2,3,4,5))   ＃ the second iterable list is one item short
[3, 5, 7, 9, 15]
>>> map(None, [1,2,3,4,5], [1,2,3])

[(1, 1), (2, 2), (3, 3), (4, None), (5, None)]
reduce

reduce(function, sequence[, initial]) -> value

Apply a function of two arguments cumulatively to the items of a sequence, from left to right, so as to reduce the sequence to a single value.
For example, reduce(lambda x, y: x+y, [1, 2, 3, 4, 5]) calculates ((((1+2)+3)+4)+5).  If initial is present, it is placed before the items of the sequence in the calculation, and serves as a default when the sequence is empty.
Example:
>>> reduce(lambda x, y: x+y, range(0,10))
45
>>> reduce(lambda x, y: x+y, range(0,10), 10)
55
filter

Namespace:  Python builtin
Docstring:
filter(function or None, sequence) -> list, tuple, or string

Return those items of sequence for which function(item) is true.  If
function is None, return the items that are true.  If sequence is a tuple

or string, return the same type, else return a list.
Example:
>>> filter(lambda d: d != 'a', 'abcd')　　＃ filter out letter 'a'。
'bcd'
>>> def d(x):　＃ not using lambda function, instead using a predefined function
 　　　　　return True if x != 'a' else False
>>> filter(d, 'abcd')
'bcd'

zip

zip(seq1 [, seq2 [...]]) -> [(seq1[0], seq2[0] ...), (...)]

Return a list of tuples, where each tuple contains the i-th element
from each of the argument sequences.  The returned list is truncated

in length to the length of the shortest argument sequence.

Example:
>>>
zip( range(5), range(1,20,2) )

[(0, 1), (1, 3), (2, 5), (3, 7), (4, 9)]

# ternary
a if test else b
>>> 'true' if True else 'false'
'true'
>>> 'true' if False else 'false'
'false'

os.getcwd() # current working directory pwd
os.environ['HOME'] # environment variable
os.path.expanduser("~/.ssh/config")
os.sep # path separator


date.strftime(format)
datetime.strftime(format)
time.strftime(format)
datetime.datetime.now().strftime('%c')

datetime.strptime(date_string, format)

# full
%c                   09/09/14 07:05:20              Locale's appropriate date and time representation.
%x                   09/09/14                       Locale's appropriate date representation.
%X                   07:05:20                       Locale's appropriate time representation.
%m/%b/%y %I:%M %p    09/Sep/14 07:05 AM
%Y.%m.%d             2014.09.09

# year
%y                   14                             Year without century as a decimal number [00,99].
%Y                   2014                           Year with century as a decimal number.


# month
%b                   Sep                            Locale's abbreviated month name.
%B                   September                      Locale's full month name.
%m                   09                             Month as a decimal number [01,12].

# week
%U                   36                             Week number of the year (Sunday as the first day of the week)
%W                   36                             Week number of the year (Monday as the first day of the week)


# day
%d                   09                             Day of the month as a decimal number [01,31].
%j                   252                            Day of the year as a decimal number [001,366].
%w                   2                              Weekday as a decimal number [0(Sunday),6].
%a                   Tue                            Locale's abbreviated weekday name.
%A                   Tuesday                        Locale's full weekday name.

# hours
%H                   07                             Hour (24-hour clock) as a decimal number [00,23].
%I                   07                             Hour (12-hour clock) as a decimal number [01,12].
%p                   AM                             Locale's equivalent of either AM or PM.

# minutes
%M                   05                             Minute as a decimal number [00,59].

# seconds
%f                   631000                         Microsecond as a decimal number [0,999999], zero-padded on the left
%S                   20                             Second as a decimal number [00,61].


# TZ
%z                                                  UTC offset in the form +HHMM or -HHMM.
%Z                                                  Time zone name (empty string if the object is naive).

# other
%%                   %                              A literal '%' character.

# UNIX EPOCH
import datetime
import calendar
>>> aprilFirst=datetime.datetime(2012, 04, 01, 0, 0)
>>> calendar.timegm(aprilFirst.timetuple())
1333238400

__file__
# https://docs.python.org/2/reference/datamodel.html#special-method-names
__abs__
__add__
__and__
__call__
__class__
__closure__
__cmp__
__code__
__coerce__
__complex__
__contains__
__defaults__
__del__
__delattr__
__delete__
__delitem__
__delslice__
__dict__
__div__
__divmod__
__doc__
__enter__
__eq__
__exit__
__float__
__floordiv__
__future__
__ge__
__get__
__getattr__
__getattribute__
__getitem__
__getslice__
__globals__
__gt__
__hash__
__hex__
__iadd__
__iand__
__idiv__
__ifloordiv__
__ilshift__
__imod__
__imul__
__index__
__init__
__instancecheck__
__int__
__invert__
__ior__
__ipow__
__irshift__
__isub__
__iter__
__itruediv__
__ixor__
__le__
__len__
__long__
__lshift__
__lt__
__metaclass__
__mod__
__module__
__mul__
__name__
__ne__
__neg__
__new__
__nonzero__
__oct__
__op__
__or__
__pos__
__pow__
__radd__
__rand__
__rcmp__
__rdiv__
__rdivmod__
__repr__
__reversed__
__rfloordiv__
__rlshift__
__rmod__
__rmul__
__ror__
__rpow__
__rrshift__
__rshift__
__rsub__
__rtruediv__
__rxor__
__self__
__set__
__setattr__
__setitem__
__setslice__
__slots__
__str__
__sub__
__subclasscheck__
__truediv__
__unicode__
__xor__


with open('d:/cygwin64/home/myuser/bip', 'rb') as f:
    p = f.read()

with open('d:/cygwin64/home/myuser/bip', 'wb') as f:
    f.write(content)

str.str(object='')->string
str.capitalize()
str.center()
str.count()
str.decode()
str.encode()
str.endswith()
str.expandtabs()
str.find()
str.format()
str.index()
str.isalnum()
str.isalpha()
str.isdigit()
str.islower()
str.isspace()
str.istitle()
str.isupper()
str.join()
str.ljust()
str.lower()
str.lstrip()
str.partition()
str.replace()
str.rfind()
str.rindex()
str.rjust()
str.rpartition()
str.rsplit()
str.rstrip()
str.split()
str.splitlines()
str.startswith()
str.strip() # trim
str.swapcase()
str.title()
str.translate()
str.upper()
str.zfill()

# removes duplicates in list by using set -- unique
>>> t = [1, 2, 3, 1, 2, 5, 6, 7, 8]
>>> t
[1, 2, 3, 1, 2, 5, 6, 7, 8]
>>> list(set(t))
[1, 2, 3, 5, 6, 7, 8]
>>> s = [1, 2, 3]
>>> list(set(t) - set(s))
[8, 5, 6, 7]


# https://stackoverflow.com/questions/136097/what-is-the-difference-between-staticmethod-and-classmethod-in-python
class A(object):
    def foo(self,x):
        print "executing foo(%s,%s)"%(self,x)

    @classmethod
    def class_foo(cls,x):
        print "executing class_foo(%s,%s)"%(cls,x)

    @staticmethod
    def static_foo(x):
        print "executing static_foo(%s)"%x

a=A()


# uncamelcase
"""
>>> convert('CamelCase')
'camel_case'
>>> convert('CamelCamelCase')
'camel_camel_case'
>>> convert('Camel2Camel2Case')
'camel2_camel2_case'
>>> convert('getHTTPResponseCode')
'get_http_response_code'
>>> convert('get2HTTPResponseCode')
'get2_http_response_code'
>>> convert('HTTPResponseCode')
'http_response_code'
>>> convert('HTTPResponseCodeXYZ')
'http_response_code_xyz'
"""
def uncamelcase(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

list(set(li)) # remove duplicates in list li -- unique

try:
    scanocr_analysis()
except KeyError, e:
    print('keyerror')
except BaseException, e:
    import traceback
    traceback.print_exc(e)

# A tester (fournis par Jean-Marc Vasquez)
  except Exception, e:
    print e
        except:
    print sys.exc_info()


from collections import namedtuple
Point = namedtuple('Point', 'x y')

# decorator https://wiki.python.org/moin/PythonDecoratorLibrary#Easy_Dump_of_Function_Arguments

# decorator http://www.pythoncentral.io/python-decorators-overview/
def decorator(fn):
    def inner(n):
        return fn(n) + 1
    return inner

@decorator
def f(n):
    return n + 1

# super
import some_module

class MyVersionOfAClass( some_module.AClass ):
    def someMethod( self, *args, **kwargs ):
        # do your "decoration" here.
        super( MyVersionOfAClass, self ). someMethod( *args, **kwargs )

7 % 3 # modulo


# find doublon
from collections import Counter
mylist = [20, 30, 25, 20]
[k for k,v in Counter(mylist).items() if v>1]

# find doublon as well as indices
from collections import defaultdict
D = defaultdict(list)
for i,item in enumerate(mylist): # indexed idx
    D[item].append(i)
D = {k:v for k,v in D.items() if len(v)>1}


curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && sudo python get-pip.py


# python3 centos
# https://sopel.chat/python3-centos7.html
yum install scl-utils
wget https://www.softwarecollections.org/en/scls/rhscl/python33/epel-7-x86_64/download/rhscl-python33-epel-7-x86_64.noarch.rpm
yum install rhscl-python33-*.noarch.rpm
yum install python33
scl enable python33 -- $SHELL
easy_install pip


# find in iterable
app_name = next(iter([x[label] for x in apps if x[_id] == rH[defaultApp][appInstanceId]])) # iter seems to be important
next(x for x in lst if ...)
which will return the first match or raise a StopIteration if none is found. Alternatively, you can use
next((x for x in lst if ...), [default value])

next((x for x in lst if matchCondition(x)), 'default value if none found') # returns the first item in a list matching a condition


# file size
import os
>>> statinfo = os.stat('somefile.txt')
>>> statinfo
(33188, 422511L, 769L, 1, 1032, 100, 926L, 1105022698,1105022732, 1105022732)
>>> statinfo.st_size
os.stat('somefile.txt').st_size # filesize file size


import os
activate_this_file = '{}/.virtualenvs/{}/bin/activate_this.py'.format(os.environ['HOME'], 'foreman2katello') # venv
execfile(activate_this_file, dict(__file__=activate_this_file))         # venv python2
exec(open(activate_this_file).read(), {'__file__': activate_this_file}) # venv python3


~/.local/lib/python2.7/site-packages/requests/packages/urllib3/connectionpool.py:843: InsecureRequestWarning: Unverified HTTPS request is being made. Adding certificate verification is strongly advised. See: https://urllib3.readthedocs.io/en/latest/advanced-usage.html#ssl-warnings InsecureRequestWarning)
can be disabled using
import warnings
import warnings; warnings.filterwarnings("ignore") # InsecureRequestWarning: Unverified HTTPS request is being made. Adding certificate verification is strongly advised.
or calling python with -W attribute (not verified)

sys._getframe().f_code.co_name # current function name http://stackoverflow.com/questions/5067604/determine-function-name-from-within-that-function-without-using-traceback
python -m json.tool [FILENAME] # pretty print

# http://stackoverflow.com/questions/2878084/sort-a-list-of-dicts-by-dict-values
import operator
L.sort(key=operator.itemgetter('title','title_url','id'))
L.sort(key=operator.attrgetter('title.subelement','title_url','id'))

python -m unittest discover           # recursively executes all test
python3 -m unittest discover -p "*py" # maybe only test_\*py pattern are loaded otherwise
python -m unittest search   # run test of module search.py
python -m unittest search.SearchTestCase.test_google_g # run test of module search.py class SearchTestCast funtion test_google_g
# http://blog.aaronboman.com/programming/testing/2016/02/11/how-to-write-tests-in-python-project-structure/
# http://blog.aaronboman.com/programming/testing/2016/03/07/how-to-write-tests-in-python-recipes-and-patterns/
# http://fgimian.github.io/blog/2014/04/10/using-the-python-mock-library-to-fake-regular-functions-during-tests/


x.update(y) # merges dict http://stackoverflow.com/questions/38987/how-to-merge-two-python-dictionaries-in-a-single-expression

export PYTHONUNBUFFERED=1
# unbuffered
import os,sys
sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)
>>>>>>> adf8934b9a3545a7b8ce5462b7a1b5ae194f5621

import traceback; traceback.print_exc() # print stack trace

# http://stackoverflow.com/questions/8315389/how-do-i-print-functions-as-they-are-called
def tracefunc(frame, event, arg, indent=[0]):
      if event == "call":
          indent[0] += 2
          print "-" * indent[0] + "> call function", frame.f_code.co_name
      elif event == "return":
          print "<" + "-" * indent[0], "exit function", frame.f_code.co_name
          indent[0] -= 2
      return tracefunc
import sys
sys.settrace(tracefunc)

os.getcwd() # pwd current working directory

PYTHONDONTWRITEBYTECODE=True # no *.pyc or *.pyo
python2 -B                   # no *.pyc or *.pyo
python3 -B                   # no *.pyc or *.pyo

from termcolor import colored
print(colored("I'm blue", 'blue'))

mylist[:] = map(func, mylist) # https://stackoverflow.com/questions/3000461/python-map-in-place


try:
    import cPickle as pickle
except:
    import pickle
with open('/tmp/_mr2.pickle', 'rb') as f:
        _cache = pickle.load(f)
with open('/tmp/_mr2.pickle', 'wb') as f:
        pickle.dump(_cache, f)

import json; json.load(reader) # parse json reader
import json; json.loads(str) # parse json string
import json; json.dumps(dict)
import json; json.dumps(dict, indent=2) # pretty-print prettyprint

import urllib; urllib.quote(      '/test', safe='') # escape uricomponent encode python2
import urllib; urllib.parse.quote('/test', safe='') # escape uricomponent encode python3

try:
    import urlparse
except:
    import urllib.parse as urlparse # python3
url = 'https://stackoverflow.com/questions/5074803/retrieving-parameters-from-a-url?a=4&b=2'
parsed = urlparse.urlparse(url)
print urlparse.parse_qs(parsed.query)['def']
from urllib.parse import urlencode; urlencode(mydict) # to query string

import textwrap; textwrap.dedent(s) #un-indent block of text unindent unident un-ident

# python2 no external lib process fork
import subprocess
s = subprocess.Popen('sudo netstat -tlnpe'.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
out = '\n'.join(map(str.strip, s.communicate()))

~/py/mryaml.py
from ruamel import yaml; yaml.dump({})
import yaml; yaml.dump({}) # dump as string
import yaml; yaml.dump({}, fd) # dump into file descriptor fd
import yaml; with open('/tmp/bip.yml', 'rb') as f: yaml.safe_load(f)
import yaml; with open('/tmp/bip.yml', 'rb') as f: yaml.load(f, Loader=yaml.FullLoader)
import yaml; yaml.safe_dump({}, default_flow_style=False)
def print_yaml(i): import yaml; print(yaml.dump(i))
from StringIO import StringIO; import yaml, textwrap; mH = yaml.load(StringIO(textwrap.dedent("""python2
from io       import StringIO; import yaml, textwrap; mH = yaml.load(StringIO(textwrap.dedent("""python3
    """)))

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


from dateutil import parser
import pytz
zh = pytz.timezone('Europe/Zurich')
start_date = parser.parse(fields['customfield_10117']).astimezone(zh)
print(start_date.strftime('%Y.%m.%d %H:%M'))
delay = start_date - datetime.datetime.now(tz=zh)



def FILETIME_bytes_to_datetime(timestamp_bytes): # microsoft filetime timestamp
    import struct
    from datetime import datetime, timedelta
    quadword, = struct.unpack('<Q', timestamp_bytes)
    us = quadword // 10 - 11644473600000000
    return datetime(1970, 1, 1) + timedelta(microseconds=us)

import base64; base64.b64decode()



from string import Formatter
class NamespaceFormatter(Formatter):
    def __init__(self, namespace={}, nonexisting='', dedent=True, strip=True):
        Formatter.__init__(self)
        self.namespace = namespace
        self.nonexisting = nonexisting
        self.dedent = dedent
        self.strip = strip
    def format(self, s, *args, **kwargs):
        if self.dedent: s = textwrap.dedent(s)
        if self.strip:  s = s.strip()
        return Formatter.format(self, s, *args, **kwargs)
    def get_value(self, key, args, kwds):
        if isinstance(key, str):
            try:
                # Check explicitly passed arguments first
                return kwds[key]
            except KeyError:
                if self.namespace:
                    return self.namespace.get(key, self.nonexisting)
                else:
                    return self.nonexisting
        else:
            Formatter.get_value(key, args, kwds)
fmt = NamespaceFormatter(globals())
myglob = "iamglobal"
print(fmt.format("myglob: {myglob} keyword:{keyword} notexisting:{notexisting}_", keyword='iamakeyword')) # KeyError str.format

https://amoffat.github.io/sh/ # sh
from sh import git
git('diff', '--quiet', _cwd=work_dir)
try:
        sh.ls("/doesnt/exist")
except sh.ErrorReturnCode_2:
        print("directory doesn't exist")

logging.getLogger('sh.command').setLevel(logging.WARN) # logger sh level
# https://amoffat.github.io/sh/
# https://amoffat.github.io/sh/reference.html
sh.cat(_fg=True) # did the trick for git clone when _out=sys.stdout, _err=sys.stderr, _tty_in=True  wasn't
sh.cat(_in="_in is stdin")
sh.cat(_in="_in is stdin", _out=None, )
sh.cat(_out=sys.stdout, _err=sys.stderr)
sh.Command('ssh-keygen')
~/.local/lib/python2.7/site-packages/sh.py
sh Controlling Output _out _err _err_to_out _encoding _decode_errors _tee
sh Execution _fg _bg _bg_exc _env _timeout _timeout_signal _cwd _ok_code _new_session _uid _preexec_fn
sh Communication _in _piped _iter _iter_noblock _with _done
sh TTYs _tty_in _tty_out _tty_size
sh Performance & Optimization _in_bufsize _out_bufsize _internal_bufsize _no_out _no_err _no_pipe
sh Program Arguments _long_sep _long_prefix _arg_preprocess
sh Misc _log_msg

mydict[new_key] = mydict.pop(old_key) # rename key in a regular dict # https://stackoverflow.com/questions/16475384/rename-a-dictionary-key


class MyException(Exception):
    pass

class ValidationError(Exception):
    def __init__(self, message, errors):
        super(ValidationError, self).__init__(message)
        self.errors = errors


import platform; platform.node(); # hostname computer name
import socket; socket.gethostname(); # hostname computer name
import socket; socket.gethostbyname(domain_name); # DNS dig resolution

sys.stdin.isatty()
sys.stdout.isatty()
sys.stderr.isatty()

import random
random.randint(min_inclusive, max_inclusive)

# read from prompt
```python
from sys import version_info # prompt
py3 = version_info[0] > 2 #creates boolean value for test that Python major version > 2 prompt
if py3: #prompt
  response = input("Prompt: Please enter your name in python3: ")
else: # prompt
  response = raw_input("Prompt: Please enter your name in python2: ")
```

# argparse
```python
# https://docs.python.org/3.8/library/argparse.html
import argparse
parser = argparse.ArgumentParser(description="This is the description of what I do") # argparse
parser.add_argument("FILENAME", type=str, nargs='+', help="file to process") # argparse
parser.add_argument("-f", "--follow", help="saves output in place", action="store_true") # argparse
parser.add_argument("-n", "--number", help="number", type # argparse
parser.add_argument("-t", "--boolean-true", help="yes or no", action='store_true')
parser.add_argument("-f", "--boolean-false", help="yes or no", action='store_false')
parser.add_argument("-c", "--constant", help="constant", action='store_const', cons=42)
ar = parser.parse_args(args) # argparse
parser.add_argument('integers', metavar='N', type=int, nargs='+', help='an integer for the accumulator') # argparse
parser.add_argument('--sum', dest='accumulate', action='store_const', const=sum, default=max, help='sum the integers (default: find the max)') # arg_parse
args = parser.parse_args() # arg_parse
print args.accumulate(args.integers) # arg_parse
```

```sh
python -m SimpleHTTPServer 8000
python3 -m http.server 8000 # SimpleHTTPServer
```

pydoc mypackage
pydoc requests
pydoc requests.sessions

# reraise https://franklingu.github.io/programming/2016/06/30/properly-reraise-exception-in-python/
```python
try:
    b = 5
    b = 1 / 0
except BaseException as e:
    logger.error('mmmh %s', b)
    raise type(e), type(e)(e), sys.exc_info()[2]
```
chr(65)  # => 'A' ord character
ord('A') # => 65  chr character

# https://code-maven.com/switch-to-interactive-mode-from-python-script
import code
code.interact(local=locals())

# https://stackoverflow.com/questions/5434891/iterate-a-list-as-pair-current-next-in-python
```python

import itertools
def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = itertools.tee(iterable)
    next(b, None)
    return itertools.izip(a, b) # <- this is python2 for 3 replace "itertool.izip" with solely "zip" (no itertool)
```
https://stackoverflow.com/questions/1011938/loop-that-also-accesses-previous-and-next-values
```python
from itertools import tee, islice, chain, izip

def previous_and_next(some_iterable):
    prevs, items, nexts = tee(some_iterable, 3)
    prevs = chain([None], prevs)
    nexts = chain(islice(nexts, 1, None), [None])
    return izip(prevs, items, nexts)
# Then use it in a loop, and you'll have previous and next items in it:

mylist = ['banana', 'orange', 'apple', 'kiwi', 'tomato']

for previous, item, nxt in previous_and_next(mylist):
    print "Item is now", item, "next is", nxt, "previous is", previous
```

os.mkdir()     # mkdir makedir
os.makedirs()  # mkdir -p

ln -s foo-bar.py foo_bar.py # https://stackoverflow.com/questions/8350853/how-to-import-module-when-module-name-has-a-dash-or-hyphen-in-it

```sh
cat << 'HEREDOC' | python -
print(2 + 5)
HEREDOC
```
import enum
class REST(enum.Enum):
    get = "get" # enum
    put = "put" # enum
    post = "post" # enum
    delete = "delete" # enum


# typing
https://python.readthedocs.io/en/stable/library/typing.html
https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html
https://docs.python.org/3.6/library/typing.html
```sh
pip install mypy
mypy mycode.py # check typing
```
```python

from typing import List, Set, Dict, Tuple, Optional

from typing import NoReturn; def foo() -> NoReturn: # function does not terminate or alwasy throws an exception, typing
def hehe(a: typing.Union[int, float]) -> None:
def hehe(a: typing.List[int]) -> None:
def foo() -> None: # typing void
@typing.no_type_check
def do_not_check_me_bro():

    a = 7 # type: ignore         <-- ignore single line

# https://stackoverflow.com/questions/43957034/specifying-a-type-to-be-a-list-of-numbers-ints-and-or-floats typing
from typing import Union, Sequence # typing list
Num = Union[int, float] # typing list int or float
def quick_sort(arr: Sequence[Num]) -> Sequence[Num]: typing list
def quick_sort(arr: Sequence[Num]) -> Sequence[Num]: typing list
```

## Built-in types
```python
from typing import List, Set, Dict, Tuple, Optional

# For simple built-in types, just use the name of the type
x: int = 1
x: float = 1.0
x: bool = True
x: str = "test"
x: bytes = b"test"

# For collections, the name of the type is capitalized, and the
# name of the type inside the collection is in brackets
x: List[int] = [1]
x: Set[int] = {6, 7}

# Same as above, but with type comment syntax
x = [1]  # type: List[int]

# For mappings, we need the types of both keys and values
x: Dict[str, float] = {'field': 2.0}

# For tuples of fixed size, we specify the types of all the elements
x: Tuple[int, str, float] = (3, "yes", 7.5)

# For tuples of variable size, we use one type and ellipsis
x: Tuple[int, ...] = (1, 2, 3)

# Use Optional[] for values that could be None
x: Optional[str] = some_function()
# Mypy understands a value can't be None in an if-statement
if x is not None:
    print(x.upper())
# If a value can never be None due to some invariants, use an assert
assert x is not None
print(x.upper())
```

```python
def _my_recursive_iterator_function(): # yield from https://stackoverflow.com/questions/38254304/can-generators-be-recursive
    yield from _my_recursive_iterator_function # https://stackoverflow.com/questions/38254304/can-generators-be-recursive
```


```sh
cat << 'PYTHONBASHHEREDOC' | python3 - $g
print('python bash here doc')
PYTHONBASHHEREDOC
```

```python
    script_directory, script_name = os.path.split(__file__)
    filepath = os.path.expanduser('~/.tmp/log/{}.log'.format(os.path.splitext(script_name)[0]))
    ```


```sh
python3 -m venv /tmp/myvenv
```

with open(os.path.expanduser(fp), 'r', encoding='utf-8-sig') as f: # windows BOM UTF-8 reader
