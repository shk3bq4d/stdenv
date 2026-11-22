# python
'{:<0.3f}'.format(5.) => '5.000' python float
'{:<3d}'.format(5)    => '5  ' python integer
'{:<3d}'.format(51)   => '51 ' python integer
'{:,}'.format(1234567890) => '1,234,567,890' python thousand separators
'{:,}'.format(1234567890).replace(',', "'") => "1'234'567'890" python thousand separators

f"{x:,}"      # 1,234,567.89
f"{x:,.0f}"   # 1,234,568
f"{x:,.2f}"   # 1,234,567.89
f"{x:,.3f}"   # 1,234,567.890
'{:,.3f}'.format(1234567890.65) => '1,234,567,890.650'
>>> '{:<40,.15f}'.format(1234567890.65)
'1,234,567,890.650000095367432           '
>>> '{:>40,.15f}'.format(1234567890.65)
'           1,234,567,890.650000095367432'
>>> '{:>40,.0f}'.format(1234567890.65)
'                           1,234,567,891'
254:'{:%Y-%m-%d %H:%M:%S} printf with strftime formatting'.format(datetime.datetime(2010, 7, 4, 12, 15, 58))
255:f'{datetime.datetime.now():%Y.%m.%d %H:%M:%S}' printf with strftime formatting
2
