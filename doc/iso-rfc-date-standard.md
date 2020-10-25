# ISO-8601
ISO 8601 format, [HH[:MM[:SS[.mmm[uuu]]]]][+HH:MM]
20:min:            "iso8601": "2019-12-20T07:05:55Z",
21:min:            "iso8601_basic": "20191220T080555373702",
22:min:            "iso8601_basic_short": "20191220T080555",
23:min:            "iso8601_micro": "2019-12-20T07:05:55.373754Z",

# RFC-2822
RFC 2822 Tue, 13 Oct 2020 13:05:27 GMT
```python
import email.utils
email.utils.parsedate('Wed, 23 Sep 2009 22:15:29 GMT')
datetime.datetime(*email.utils.parsedate('Wed, 23 Sep 2009 22:15:29 GMT')[:6])
datetime.datetime(*email.utils.parsedate(requests.get(url).headers['Date'])[:6]) # 'Wed, 23 Sep 2009 22:15:29 GMT'
email.utils.parsedate_to_datetime(requests.get(url).headers['Date']) # 'Wed, 23 Sep 2009 22:15:29 GMT'
email.utils.parsedate_to_datetime(r.headers['Date']) # 'Wed, 23 Sep 2009 22:15:29 GMT'

```
