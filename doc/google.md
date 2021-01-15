filetype:rtf
site:.ch
site:hoho.ch


“search term”
Force an exact-match search. Use this to refine results for ambiguous searches, or to exclude synonyms when searching for single words.

Example: “steve jobs”

# OR
Search for X or Y. This will return results related to X or Y, or both. Note: The pipe (|) operator can also be used in place of “OR.”

Examples: jobs OR gates / jobs | gates

# AND
Search for X and Y. This will return only results related to both X and Y. Note: It doesn’t really make much difference for regular searches, as Google defaults to “AND” anyway. But it’s very useful when paired with other operators.

Example: jobs AND gates

# -
Exclude a term or phrase. In our example, any pages returned will be related to jobs but not Apple (the company).

Example: jobs ‑apple

# *
Acts as a wildcard and will match any word or phrase.

Example: steve * apple

# ( )
Group multiple terms or search operators to control how the search is executed.

Example: (ipad OR iphone) apple

# $
Search for prices. Also works for Euro (€), but not GBP (£) 🙁

Example: ipad $329

# define:
A dictionary built into Google, basically. This will display the meaning of a word in a card-like result in the SERPs.

Example: define:entrepreneur

# cache:
Returns the most recent cached version of a web page (providing the page is indexed, of course).

Example: cache:apple.com

# filetype:
Restrict results to those of a certain filetype. E.g., PDF, DOCX, TXT, PPT, etc. Note: The “ext:” operator can also be used—the results are identical.

Example: apple filetype:pdf / apple ext:pdf

# site:
Limit results to those from a specific website.

Example: site:apple.com

# related:
Find sites related to a given domain.

Example: related:apple.com

# intitle:
Find pages with a certain word (or words) in the title. In our example, any results containing the word “apple” in the title tag will be returned.

Example: intitle:apple

# allintitle:
Similar to “intitle,” but only results containing all of the specified words in the title tag will be returned.

Example: allintitle:apple iphone

# inurl:
Find pages with a certain word (or words) in the URL. For this example, any results containing the word “apple” in the URL will be returned.

Example: inurl:apple

# allinurl:
Similar to “inurl,” but only results containing all of the specified words in the URL will be returned.

Example: allinurl:apple iphone

# intext:
Find pages containing a certain word (or words) somewhere in the content. For this example, any results containing the word “apple” in the page content will be returned.

Example: intext:apple

# allintext:
Similar to “intext,” but only results containing all of the specified words somewhere on the page will be returned.

Example: allintext:apple iphone

# AROUND(X)
Proximity search. Find pages containing two words or phrases within X words of each other. For this example, the words “apple” and “iphone” must be present in the content and no further than four words apart.

Example: apple AROUND(4) iphone

# weather:
Find the weather for a specific location. This is displayed in a weather snippet, but it also returns results from other “weather” websites.

Example: weather:san francisco

# stocks:
See stock information (i.e., price, etc.) for a specific ticker.

Example: stocks:aapl

# map:
Force Google to show map results for a locational search.

Example: map:silicon valley

# movie:
Find information about a specific movie. Also finds movie showtimes if the movie is currently showing near you.

Example: movie:steve jobs

# in
Convert one unit to another. Works with currencies, weights, temperatures, etc.

Example: $329 in GBP

# source:
Find news results from a certain source in Google News.

Example: apple source:the_verge

# _
Not exactly a search operator, but acts as a wildcard for Google Autocomplete.

Example: apple CEO _ jobs



Here are the ones that are hit and miss, according to my testing:

#..#
Search for a range of numbers. In the example below, searches related to “WWDC videos” are returned for the years 2010–2014, but not for 2015 and beyond.

Example: wwdc video 2010..2014

inanchor:
Find pages that are being linked to with specific anchor text. For this example, any results with inbound links containing either “apple” or “iphone” in the anchor text will be returned.

Example: inanchor:apple iphone

allinanchor:
Similar to “inanchor,” but only results containing all of the specified words in the inbound anchor text will be returned.

Example: allinanchor:apple iphone

blogurl:
Find blog URLs under a specific domain. This was used in Google blog search, but I’ve found it does return some results in regular search.

Example: blogurl:microsoft.com

SIDENOTE. Google blog search discontinued in 2011
loc:placename
Find results from a given area.

Example: loc:”san francisco” apple

SIDENOTE. Not officially deprecated, but results are inconsistent.
location:
Find news from a certain location in Google News.

Example: loc:”san francisco” apple

SIDENOTE. Not officially deprecated, but results are inconsistent.


Here are the Google search operators that have been discontinued and no longer work. 🙁

+
Force an exact-match search on a single word or phrase.

Example: jobs +apple

SIDENOTE. You can do the same thing by using double quotes around your search.
~
Include synonyms. Doesn’t work, because Google now includes synonyms by default. (Hint: Use double quotes to exclude synonyms.)

Example: ~apple

inpostauthor:
Find blog posts written by a specific author. This only worked in Google Blog search, not regular Google search.

Example: inpostauthor:”steve jobs”

SIDENOTE. Google blog search was discontinued in 2011.
allinpostauthor:
Similar to “inpostauthor,” but removes the need for quotes (if you want to search for a specific author, including surname.)

Example: allinpostauthor:steve jobs

inposttitle:
Find blog posts with specific words in the title. No longer works, as this operator was unique to the discontinued Google blog search.

Example: intitle:apple iphone

link:
Find pages linking to a specific domain or URL. Google killed this operator in 2017, but it does still show some results—they likely aren’t particularly accurate though. (Deprecated in 2017)

Example: link:apple.com

info:
Find information about a specific page, including the most recent cache, similar pages, etc. (Deprecated in 2017). Note: The id: operator can also be used—the results are identical.

SIDENOTE. Although the original functionality of this operator is deprecated, it is still useful for finding the canonical, indexed version of a URL. Thanks to @glenngabe for pointing this one one!
Example: info:apple.com / id:apple.com

daterange:
Find results from a certain date range. Uses the Julian date format, for some reason.

Example: daterange:11278–13278

SIDENOTE. Not officially deprecated, but doesn’t seem to work.
phonebook:
Find someone’s phone number. (Deprecated in 2010)

Example: phonebook:tim cook

#
Searches #hashtags. Introduced for Google+; now deprecated.

Example: #apple

15 Actionable Ways to Use Google Search Operators
Now let’s tackle a few ways to put these operators into action.

My aim here is to show that you can achieve almost anything with Google advanced operators if you know how to use and combine them efficiently.

So don’t be afraid to play around and deviate from the examples below. You might just discover something new.
