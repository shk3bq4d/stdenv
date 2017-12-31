http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html


precedes	meets	overlaps	finished by	contains	starts	equals	started by	during	finishes	overlapped by	met by	preceded by
p	m	o	fi	di	s	e	si	d	f	oi	mi	pi
gap	meet	————– overlap ————–	meet	gap



# 1 A precedes B, gap
a.end < b.start
.---------.
|    A    |
'---------'
               .---------.
               |    B    |
               '---------'


# 2 A meets B, meet
a.end = b.start
.-----------.
|     A     |
'-----------'
            .------------.
            |     B      |
            '------------'



# 3 A overlaps B, overlaps
a.start < b.start and
a.end   > b.start and
a.end   < b.end
.-------------.
|      A      |
'-------------'
          .--------------.
          |      B       |
          '--------------'



# 4 A finished by B, overlaps
a.start < b.start and
a.end   > b.start and
a.end   = b.end
.------------------------.
|           A            |
'------------------------'
          .--------------.
          |      B       |
          '--------------'



# 5 A contains B, overlaps
a.start < b.start and
a.end   > b.end
.------------------------.
|           A            |
'------------------------'
     .--------------.
     |      B       |
     '--------------'



# 6 A starts B, overlaps
a.start = b.start and
a.end   < b.end
.--------------.
|      A       |
'--------------'
.------------------------.
|           B            |
'------------------------'



# 7 A equals B, overlaps
a.start = b.start and
a.end   = b.end
.------------------------.
|           A            |
'------------------------'
.------------------------.
|           B            |
'------------------------'



# 8 A started by B, overlaps
a.start = b.start and
a.end   > b.end
.------------------------.
|           A            |
'------------------------'
.--------------.
|      B       |
'--------------'



# 9 A during B, overlaps
a.start > b.start and
a.end   < b.end
     .--------------.
     |      A       |
     '--------------'
.------------------------.
|           B            |
'------------------------'




# 10 A finishes B, overlaps
a.start > b.start and
a.end   = b.end
          .--------------.
          |      A       |
          '--------------'
.------------------------.
|           B            |
'------------------------'



# 11 A overlaps B, overlaps
a.start > b.start and
a.start < b.end   and
a.end   > b.start
          .--------------.
          |      A       |
          '--------------'
.-------------.
|      B      |
'-------------'



# 12 A met by B, meet
a.start = b.end
            .------------.
            |     A      |
            '------------'
.-----------.
|     B     |
'-----------'



# 13 A preceded by B, gap
a.start > b.end
               .---------.
               |    A    |
               '---------'
.---------.
|    B    |
'---------'


overlaps:
1 - #13 - #12 - #1 - #2
          #13+#12    +      #1+#2
not(a.start >= b.end or a.end <= b.start)
    a.start < b.end and a.end > b.start
