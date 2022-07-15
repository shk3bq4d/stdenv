#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import fileinput
import os
import sys
import re
import unittest
import argparse
import logging
from typing import Sequence, Union, Iterator, List, Tuple, no_type_check, Any, Optional

from pprint import pprint, pformat

os.umask (0o27)
logger = logging.getLogger(__name__)

class SqlToLowercaseTest(unittest.TestCase):
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
        level='DEBUG' if 'VIMF6' in os.environ else 'INFO',
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
state_normal = 0
state_single_quote_str = 1
state_square_column = 2
state_single_quote_str_backslash = 3
def process(fp):
    logger.debug("-> %s", fp)
    previous_char = ''
    state = state_normal
    bA = []
    outA = []
    for char in read_char(fp):
        if state == state_normal:
            if char == "'":
                next_state = state_single_quote_str
                outA.append(lower_case(''.join(bA)))
                outA.append(char)
                bA = []
            elif char == '[':
                next_state = state_square_column
                outA.append(lower_case(''.join(bA)))
                outA.append(char)
                bA = []
            else:
                next_state = state_normal
                bA.append(char)
        elif state == state_single_quote_str:
            if char == '\\':
                next_state = state_single_quote_str_backslash
            elif char == "'":
                outA.append(char)
                next_state = state_normal
            else:
                outA.append(char)
        elif state == state_square_column:
            if char == "]":
                outA.append(char)
                next_state = state_normal
            else:
                outA.append(char)
        elif state == state_single_quote_str_backslash:
            outA.append(previous_char)
            outA.append(char)
            next_state = state_single_quote_str

        state = next_state
        previous_char = char
    outA.append(lower_case(''.join(bA)))
    return ''.join(outA)

def lower_case(s):
    def _inner(m):
        return m.group(0).lower()
    return re.sub(pattern, _inner, s)

def read_char(fp):
    for line in fileinput.input(fp): # stdin
        line = line.rstrip() # stdin
        if line == '': # stdin
            continue # stdin
        for char in line:
            yield char
        yield '\n'

def go(args) -> None:
    # https://docs.python.org/2/library/argparse.html
    # logger.info(__file__)
    # logger.debug(__file__)
    if 'VIMF6' in os.environ: args = [os.path.expanduser('~/tmp/bip')]
    parser = argparse.ArgumentParser(description="lowercase SQL keywords in passed query (stdin or file)")
    parser.add_argument("FILENAME", type=str, nargs='?', default='-', help="file to process")
    script_directory, script_name = os.path.split(__file__)
    script_txt = '{}/{}.txt'.format(script_directory, os.path.splitext(script_name)[0])
    # print(script_txt)
    ar = parser.parse_args(args)
    s = process(ar.FILENAME)
    if 'VIMF6' in os.environ: print('``' + '`sql')
    sys.stdout.write(s)
    if 'VIMF6' in os.environ: print('\n``' + '`')

sql_reserved_words2 = """
now
date_sub
functions
"""
# https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
sql_reserved_words = """
abort
abs
absolute
access
action
ada
add
admin
after
aggregate
alias
all
allocate
also
alter
always
analyse
analyze
and
any
are
array
as
asc
asensitive
assertion
assignment
asymmetric
at
atomic
attribute
attributes
audit
authorization
auto_increment
avg
avg_row_length
backup
backward
before
begin
bernoulli
between
bigint
binary
bit
bit_length
bitvar
blob
bool
boolean
both
breadth
break
browse
bulk
by
c
cache
call
called
cardinality
cascade
cascaded
case
cast
catalog
catalog_name
ceil
ceiling
chain
change
char
char_length
character
character_length
character_set_catalog
character_set_name
character_set_schema
characteristics
characters
check
checked
checkpoint
checksum
class
class_origin
clob
close
cluster
clustered
coalesce
cobol
collate
collation
collation_catalog
collation_name
collation_schema
collect
column
column_name
columns
command_function
command_function_code
comment
commit
committed
completion
compress
compute
condition
condition_number
connect
connection
connection_name
constraint
constraint_catalog
constraint_name
constraint_schema
constraints
constructor
contains
containstable
continue
conversion
convert
copy
corr
corresponding
count
covar_pop
covar_samp
create
createdb
createrole
createuser
cross
csv
cube
cume_dist
current
current_date
current_default_transform_group
current_path
current_role
current_time
current_timestamp
current_transform_group_for_type
current_user
cursor
cursor_name
cycle
data
database
databases
date
datetime
datetime_interval_code
datetime_interval_precision
day
day_hour
day_microsecond
day_minute
day_second
dayofmonth
dayofweek
dayofyear
dbcc
deallocate
dec
decimal
declare
default
defaults
deferrable
deferred
defined
definer
degree
delay_key_write
delayed
delete
delimiter
delimiters
dense_rank
deny
depth
deref
derived
desc
describe
descriptor
destroy
destructor
deterministic
diagnostics
dictionary
disable
disconnect
disk
dispatch
distinct
distinctrow
distributed
div
do
domain
double
drop
dual
dummy
dump
dynamic
dynamic_function
dynamic_function_code
each
element
else
elseif
enable
enclosed
encoding
encrypted
end
end-exec
enum
equals
errlvl
escape
escaped
every
except
exception
exclude
excluding
exclusive
exec
execute
existing
exists
exit
exp
explain
external
extract
false
fetch
fields
file
fillfactor
filter
final
first
float
float4
float8
floor
flush
following
for
force
foreign
fortran
forward
found
free
freetext
freetexttable
freeze
from
full
fulltext
function
fusion
g
general
generated
get
global
go
goto
grant
granted
grants
greatest
group
grouping
handler
having
header
heap
hierarchy
high_priority
hold
holdlock
host
hosts
hour
hour_microsecond
hour_minute
hour_second
identified
identity
identity_insert
identitycol
if
ignore
ilike
immediate
immutable
implementation
implicit
in
include
including
increment
index
indicator
infile
infix
inherit
inherits
initial
initialize
initially
inner
inout
input
insensitive
insert
insert_id
instance
instantiable
instead
int
int1
int2
int3
int4
int8
integer
intersect
intersection
interval
into
invoker
is
isam
isnull
isolation
iterate
join
k
key
key_member
key_type
keys
kill
lancompiler
language
large
last
last_insert_id
lateral
lead
leading
least
leave
left
length
less
level
like
limit
lineno
lines
listen
ln
load
local
localtime
localtimestamp
location
locator
lock
login
logs
long
longblob
longtext
loop
low_priority
lower
m
map
match
matched
max
max_rows
maxextents
maxvalue
mediumblob
mediumint
mediumtext
member
merge
message_length
message_octet_length
message_text
method
middleint
min
min_rows
minus
minute
minute_microsecond
minute_second
minvalue
mlslabel
mod
mode
modifies
modify
module
month
monthname
more
move
multiset
mumps
myisam
name
names
national
natural
nchar
nclob
nesting
new
next
no
no_write_to_binlog
noaudit
nocheck
nocompress
nocreatedb
nocreaterole
nocreateuser
noinherit
nologin
nonclustered
none
normalize
normalized
nosuperuser
not
nothing
notify
notnull
nowait
null
nullable
nullif
nulls
number
numeric
object
octet_length
octets
of
off
offline
offset
offsets
oids
old
on
online
only
open
opendatasource
openquery
openrowset
openxml
operation
operator
optimize
option
optionally
options
or
order
ordering
ordinality
others
out
outer
outfile
output
over
overlaps
overlay
overriding
owner
pack_keys
pad
parameter
parameter_mode
parameter_name
parameter_ordinal_position
parameter_specific_catalog
parameter_specific_name
parameter_specific_schema
parameters
partial
partition
pascal
password
path
pctfree
percent
percent_rank
percentile_cont
percentile_disc
placing
plan
pli
position
postfix
power
preceding
precision
prefix
preorder
prepare
prepared
preserve
primary
print
prior
privileges
proc
procedural
procedure
process
processlist
public
purge
quote
raid0
raiserror
range
rank
raw
read
reads
readtext
real
recheck
reconfigure
recursive
ref
references
referencing
regexp
regr_avgx
regr_avgy
regr_count
regr_intercept
regr_r2
regr_slope
regr_sxx
regr_sxy
regr_syy
reindex
relative
release
reload
rename
repeat
repeatable
replace
replication
require
reset
resignal
resource
restart
restore
restrict
result
return
returned_cardinality
returned_length
returned_octet_length
returned_sqlstate
returns
revoke
right
rlike
role
rollback
rollup
routine
routine_catalog
routine_name
routine_schema
row
row_count
row_number
rowcount
rowguidcol
rowid
rownum
rows
rule
save
savepoint
scale
schema
schema_name
schemas
scope
scope_catalog
scope_name
scope_schema
scroll
search
second
second_microsecond
section
security
select
self
sensitive
separator
sequence
serializable
server_name
session
session_user
set
setof
sets
setuser
share
show
shutdown
signal
similar
simple
size
smallint
some
soname
source
space
spatial
specific
specific_name
specifictype
sql
sql_big_result
sql_big_selects
sql_big_tables
sql_calc_found_rows
sql_log_off
sql_log_update
sql_low_priority_updates
sql_select_limit
sql_small_result
sql_warnings
sqlca
sqlcode
sqlerror
sqlexception
sqlstate
sqlwarning
sqrt
ssl
stable
start
starting
state
statement
static
statistics
status
stddev_pop
stddev_samp
stdin
stdout
storage
straight_join
strict
string
structure
style
subclass_origin
sublist
submultiset
substring
successful
sum
superuser
symmetric
synonym
sysdate
sysid
system
system_user
table
table_name
tables
tablesample
tablespace
temp
template
temporary
terminate
terminated
text
textsize
than
then
ties
time
timestamp
timezone_hour
timezone_minute
tinyblob
tinyint
tinytext
to
toast
top
top_level_count
trailing
tran
transaction
transaction_active
transactions_committed
transactions_rolled_back
transform
transforms
translate
translation
treat
trigger
trigger_catalog
trigger_name
trigger_schema
trim
true
truncate
trusted
tsequal
type
uescape
uid
unbounded
uncommitted
under
undo
unencrypted
union
unique
unknown
unlisten
unlock
unnamed
unnest
unsigned
until
update
updatetext
upper
usage
use
user
user_defined_type_catalog
user_defined_type_code
user_defined_type_name
user_defined_type_schema
using
utc_date
utc_time
utc_timestamp
vacuum
valid
validate
validator
value
values
var_pop
var_samp
varbinary
varchar
varchar2
varcharacter
variable
variables
varying
verbose
view
volatile
waitfor
when
whenever
where
while
width_bucket
window
with
within
without
work
write
writetext
x509
xor
year
year_month
zerofill
zone
"""
# ```python
pattern = re.compile(
    r'\b(' +
    "|".join(filter(lambda x: x, map(lambda y: y.strip(), (sql_reserved_words2 + "\n" + sql_reserved_words).strip().splitlines()))) +
    r')\b',
    flags=re.IGNORECASE
    )

if __name__ == '__main__':
    logging_conf()
    if 'VIMF6' in os.environ and False:
        unittest.main()
    else:
        try:
            go(sys.argv[1:])
        except BaseException as e:
            logger.exception('oups for %s', sys.argv)
            sys.exit(1)

