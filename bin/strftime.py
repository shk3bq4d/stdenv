#!/usr/bin/env python3

import datetime

today = datetime.date.today()
now = datetime.datetime.now()


for format in [ 
    ('%a', 'Locale\'s abbreviated weekday name.'),
    ('%A', 'Locale\'s full weekday name.'),
    ('%b', 'Locale\'s abbreviated month name.'),
    ('%B', 'Locale\'s full month name.'),
    ('%c', 'Locale\'s appropriate date and time representation.'),
    ('%d', 'Day of the month as a decimal number [01,31].'),
    ('%f', 'Microsecond as a decimal number [0,999999], zero-padded on the left'),
    ('%H', 'Hour (24-hour clock) as a decimal number [00,23].'),
    ('%I', 'Hour (12-hour clock) as a decimal number [01,12].'),
    ('%j', 'Day of the year as a decimal number [001,366].'),
    ('%m', 'Month as a decimal number [01,12].'),
    ('%M', 'Minute as a decimal number [00,59].'),
    ('%p', 'Locale\'s equivalent of either AM or PM.'),
    ('%S', 'Second as a decimal number [00,61].'),
    ('%U', 'Week number of the year (Sunday as the first day of the week)'),
    ('%w', 'Weekday as a decimal number [0(Sunday),6].'),
    ('%W', 'Week number of the year (Monday as the first day of the week)'),
    ('%x', 'Locale\'s appropriate date representation.'),
    ('%X', 'Locale\'s appropriate time representation.'),
    ('%y', 'Year without century as a decimal number [00,99].'),
    ('%Y', 'Year with century as a decimal number.'),
    ('%z', 'UTC offset in the form +HHMM or -HHMM.'),
    ('%Z', 'Time zone name (empty string if the object is naive).'),
    ('%%', 'A literal \'%\' character.'),
	('%m/%b/%y %I:%M %p', ''),
	('%Y.%m.%d', ''),
	('%Y.%m.%d %H:%M:%S', ''),
	('%Y-%m-%dT%H:%M:%S.%f%z', ''),
	]:
	#print(format)
	print('{:20s} {:30s} {}'.format(format[0], now.strftime(format[0]), format[1]))

print('{:20s} {:30s} {}'.format("", datetime.datetime.utcnow().isoformat('T'), "datetime.datetime.utcnow().isoformat('T')"))
print('{:20s} {:30s} {}'.format("", datetime.datetime.utcnow().isoformat('T')[:-3] + 'Z', "datetime.datetime.utcnow().isoformat('T')[:-3] + 'Z'"))
print('{:20s} {:30s} {}'.format("", '{:.23}Z'.format(datetime.datetime.utcnow().isoformat('T')), "'{:.23}Z'.format(datetime.datetime.utcnow().isoformat('T'))"))
